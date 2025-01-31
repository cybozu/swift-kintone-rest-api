//
//  AppIcon.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

extension AppIcon {
    public enum Read: Decodable, Sendable {
        case preset(String)
        case file(File.Read)

        public enum CodingKeys: CodingKey {
            case type
            case key
            case file
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(AppIconType.self, forKey: .type)
            switch type {
            case .preset:
                self = .preset(try container.decode(String.self, forKey: .key))
            case .file:
                self = .file(try container.decode(File.Read.self, forKey: .file))
            }
        }
    }
}
