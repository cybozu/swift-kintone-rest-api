//
//  FormField.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct FormField: Sendable, Equatable {
    public var type: FormFieldType
    public var code: String?
    public var label: String?
    public var elementID: String?
}

extension FormField: Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case code
        case label
        case elementID = "elementId"
    }
}
