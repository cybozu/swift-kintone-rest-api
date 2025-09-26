//
//  KintoneAPIError.Reason+Detail.swift
//
//
//  Created by ky0me22 on 2025/09/18.
//

import Foundation

extension KintoneAPIError.Reason {
    public struct Detail: Sendable, Equatable, CustomStringConvertible {
        public var id: String
        public var code: String
        public var message: String
        public var appendixErrors: [AppendixError]

        public var description: String {
            var items = [
                "id: \"\(id)\"",
                "code: \"\(code)\"",
                "message: \"\(message)\"",
            ]
            if !appendixErrors.isEmpty {
                items.append("appendixErrors: \(appendixErrors)")
            }
            return "{ \(items.joined(separator: ", ")) }"
        }
    }
}

extension KintoneAPIError.Reason.Detail: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case message
        case appendixErrors = "errors"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        if container.allKeys.contains(.appendixErrors) {
            let errorsContainer = try container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .appendixErrors)
            appendixErrors = try errorsContainer.allKeys.map { key in
                let _value = try errorsContainer.decode(AppendixErrorValue.self, forKey: .init(stringValue: key.stringValue)!)
                return AppendixError(location: key.stringValue, messages: _value.messages)
            }
            .sorted(using: KeyPathComparator(\.location))
        } else {
            appendixErrors = []
        }
    }

    public struct AppendixError: Sendable, Equatable, CustomStringConvertible {
        public var location: String
        public var messages: [String]

        public var description: String {
            "{ location: \"\(location)\", messages: \(messages) }"
        }
    }

    struct AppendixErrorValue: Decodable {
        var messages: [String]
    }
}
