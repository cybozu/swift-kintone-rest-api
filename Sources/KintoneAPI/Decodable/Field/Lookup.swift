//
//  Lookup.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public struct Lookup: Decodable, Sendable {
    public var relatedApp: RelatedApp
    public var relatedKeyField: String
    public var fieldMappings: [FieldMapping]
    public var lookupPickerFields: [String]
    public var filterCondition: String
    public var sort: String

    enum CodingKeys: String, CodingKey {
        case relatedApp
        case relatedKeyField
        case fieldMappings
        case lookupPickerFields
        case filterCondition = "filterCond"
        case sort
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        relatedApp = try container.decode(RelatedApp.self, forKey: .relatedApp)
        relatedKeyField = try container.decode(String.self, forKey: .relatedKeyField)
        fieldMappings = (try? container.decode([FieldMapping].self, forKey: .fieldMappings)) ?? []
        lookupPickerFields = (try? container.decode([String].self, forKey: .lookupPickerFields)) ?? []
        filterCondition = try container.decode(String.self, forKey: .filterCondition)
        sort = try container.decode(String.self, forKey: .sort)
    }
}
