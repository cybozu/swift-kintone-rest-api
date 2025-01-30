//
//  RecordIdentity+Write.swift
//  KintoneAPI
//
//  Created by ky0me22 on 2025/01/30.
//

extension RecordIdentity {
    public struct Write: Sendable {
        public var id: Int
        public var revision: Int?
        
        public init(id: Int, revision: Int? = nil) {
            self.id = id
            self.revision = revision
        }
    }
}
