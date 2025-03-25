//
//  Lookup.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct Lookup: Sendable, Equatable {
    public var relatedApp: RelatedApp
    public var relatedKeyField: String
    public var fieldMappings: [FieldMapping]
    public var lookupPickerFields: [String]
    public var filterCondition: String
    public var sort: String
}

extension Lookup: Decodable {
    enum CodingKeys: String, CodingKey {
        case relatedApp
        case relatedKeyField
        case fieldMappings
        case lookupPickerFields
        case filterCondition = "filterCond"
        case sort
    }
}
