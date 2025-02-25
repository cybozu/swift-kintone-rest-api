//
//  ReferenceTableAttribute.swift
//
//
//  Created by ky0me22 on 2025/02/11.
//

public struct ReferenceTableAttribute: Decodable, Sendable, Equatable {
    public var noLabel: Bool
    public var referenceTable: ReferenceTable

    init(noLabel: Bool, referenceTable: ReferenceTable) {
        self.noLabel = noLabel
        self.referenceTable = referenceTable
    }
}
