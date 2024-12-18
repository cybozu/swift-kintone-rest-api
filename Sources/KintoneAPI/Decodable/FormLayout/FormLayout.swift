//
//  FormLayout.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct FormLayout: Decodable, Sendable {
    public var type: FormLayoutType
    public var code: String?
    public var fields: [FormField]
}
