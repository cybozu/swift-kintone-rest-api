//
//  Entity+Write.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

extension Entity {
    public struct Read: Decodable, Sendable {
        public var type: EntityType
        public var code: String
        public var name: String?
    }
}
