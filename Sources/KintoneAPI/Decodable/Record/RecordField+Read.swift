//
//  RecordField+Read.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

import Foundation

extension RecordField {
    public struct Read: Decodable, Sendable, Equatable {
        public var code: String
        public var value: RecordFieldValue.Read

        init(code: String, value: RecordFieldValue.Read) {
            self.code = code
            self.value = value
        }
    }
}
