//
//  CodeObject.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

public struct CodeObject: Encodable, Sendable {
    public var code: String

    public init(code: String) {
        self.code = code
    }
}
