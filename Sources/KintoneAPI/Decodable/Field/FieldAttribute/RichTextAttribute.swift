//
//  RichTextAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct RichTextAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var required: Bool
    public var defaultValue: String

    init(noLabel: Bool, required: Bool, defaultValue: String) {
        self.noLabel = noLabel
        self.required = required
        self.defaultValue = defaultValue
    }
}
