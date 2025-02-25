//
//  Entity+Write.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

extension Entity {
    public struct Read: Decodable, Sendable, Equatable {
        public var type: EntityType
        public var code: String
        public var name: String?

        init(type: EntityType, code: String, name: String?) {
            self.type = type
            self.code = code
            self.name = name
        }
    }
}
