//
//  FieldMapping.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct FieldMapping: Decodable, Sendable, Equatable {
    public var field: String
    public var relatedField: String

    init(field: String, relatedField: String) {
        self.field = field
        self.relatedField = relatedField
    }
}
