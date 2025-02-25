//
//  TitleField.swift
//
//
//  Created by ky0me22 on 2025/02/04.
//

public struct TitleField: Decodable, Sendable, Equatable {
    public var selectionMode: TitleFieldSelectionMode
    public var code: String

    init(selectionMode: TitleFieldSelectionMode, code: String) {
        self.selectionMode = selectionMode
        self.code = code
    }
}
