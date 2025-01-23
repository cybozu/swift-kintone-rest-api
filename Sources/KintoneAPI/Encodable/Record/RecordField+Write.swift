//
//  RecordField+Write.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

extension RecordField {
    public struct Write: Encodable, Sendable {
        public var code: String
        public var value: RecordFieldValue.Write
        
        public init(code: String, value: RecordFieldValue.Write) {
            self.code = code
            self.value = value
        }
    }
}
