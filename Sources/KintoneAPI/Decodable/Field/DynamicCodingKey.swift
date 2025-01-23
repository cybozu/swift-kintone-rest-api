//
//  DynamicCodingKey.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        nil
    }
}
