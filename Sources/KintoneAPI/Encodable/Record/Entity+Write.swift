//
//  Entity+Write.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

extension Entity {
    public struct Write: Encodable, Sendable {
        public var type: EntityType
        public var code: String

        public init(type: EntityType, code: String) {
            self.type = type
            self.code = code
        }
    }
}
