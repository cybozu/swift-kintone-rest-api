//
//  ReferenceTable.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct ReferenceTable: Decodable, Sendable {
    public var relatedApp: RelatedApp
    public var condition: ReferenceCondition
    public var filterCondition: String
    public var displayFields: [String]
    public var sort: String
    public var size: String

    enum CodingKeys: String, CodingKey {
        case relatedApp
        case condition
        case filterCondition = "filterCond"
        case displayFields
        case sort
        case size
    }
}
