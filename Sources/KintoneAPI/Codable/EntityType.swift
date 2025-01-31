//
//  EntityType.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum EntityType: String, Codable, Sendable {
    case user = "USER"
    case group = "GROUP"
    case organization = "ORGANIZATION"
    case fieldEntity = "FIELD_ENTITY"
    case creator = "CREATOR"
    case customField = "CUSTOM_FIELD"
}
