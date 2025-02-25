//
//  ReferenceTable.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct ReferenceTable: Decodable, Sendable, Equatable {
    public var relatedApp: RelatedApp
    public var condition: ReferenceCondition
    public var filterCondition: String
    public var displayFields: [String]
    public var sort: String
    public var size: Int

    enum CodingKeys: String, CodingKey {
        case relatedApp
        case condition
        case filterCondition = "filterCond"
        case displayFields
        case sort
        case size
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        relatedApp = try container.decode(RelatedApp.self, forKey: .relatedApp)
        condition = try container.decode(ReferenceCondition.self, forKey: .condition)
        filterCondition = try container.decode(String.self, forKey: .filterCondition)
        displayFields = try container.decode([String].self, forKey: .displayFields)
        sort = try container.decode(String.self, forKey: .sort)
        size = try container.customDecode(String.self, forKey: .size) { Int($0) }
    }

    init(
        relatedApp: RelatedApp,
        condition: ReferenceCondition,
        filterCondition: String,
        displayFields: [String],
        sort: String,
        size: Int
    ) {
        self.relatedApp = relatedApp
        self.condition = condition
        self.filterCondition = filterCondition
        self.displayFields = displayFields
        self.sort = sort
        self.size = size
    }
}
