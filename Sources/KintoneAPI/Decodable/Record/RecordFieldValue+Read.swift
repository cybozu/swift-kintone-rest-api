//
//  File.swift
//  KintoneAPI
//
//  Created by ky0me22 on 2025/01/22.
//

import Foundation

extension RecordFieldValue {
    public enum Read: Decodable, Sendable {
        case calc(String)
        case category([String])
        case checkBox([String])
        case createdTime(Date)
        case creator(Entity.Read)
        case date(Date?)
        case dateTime(Date?)
        case dropDown(String?)
        case file([File.Read])
        case groupSelect([Entity.Read])
        case id(Int)
        case link(String)
        case modifier(Entity.Read)
        case multiLineText(String)
        case multiSelect([String])
        case number(String)
        case organizationSelect([Entity.Read])
        case radioButton(String?)
        case recordNumber(String)
        case revision(Int)
        case richText(String)
        case singleLineText(String)
        case status(String)
        case statusAssignee([Entity.Read])
        case subTable([SubtableValue.Read])
        case time(Date?)
        case updatedTime(Date)
        case userSelect([Entity.Read])

        enum CodingKeys: CodingKey {
            case type
            case value
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(RecordFieldType.self, forKey: .type)
            switch type {
            case .calc:
                self = .calc(try container.decode(String.self, forKey: .value))
            case .category:
                self = .category(try container.decode([String].self, forKey: .value))
            case .checkBox:
                self = .checkBox(try container.decode([String].self, forKey: .value))
            case .createdTime:
                let dateString = try container.decode(String.self, forKey: .value)
                self = .createdTime(DateFormatter.kintoneDateTime.date(from: dateString)!)
            case .creator:
                let entities = try container.customDecode(EntityValue.self, forKey: .value) {
                    Entity.Read(type: .user, code: $0.code, name: $0.name)
                }
                self = .creator(entities)
            case .date:
                let dateString = try container.decode(String?.self, forKey: .value)
                self = .date(DateFormatter.kintoneDate.date(fromOptional: dateString))
            case .dateTime:
                let dateString = try container.decode(String?.self, forKey: .value)
                self = .dateTime(DateFormatter.kintoneDateTime.date(fromOptional: dateString))
            case .dropDown:
                self = .dropDown(try container.decode(String?.self, forKey: .value))
            case .file:
                self = .file(try container.decode([File.Read].self, forKey: .value))
            case .groupSelect:
                let entities = try container.customDecode([EntityValue].self, forKey: .value) {
                    $0.map { Entity.Read(type: .group, code: $0.code, name: $0.name) }
                }
                self = .userSelect(entities)
            case .id:
                self = .id(try container.customDecode(String.self, forKey: .value, initializer: { Int($0) }))
            case .link:
                self = .link(try container.decode(String.self, forKey: .value))
            case .modifier:
                let entities = try container.customDecode(EntityValue.self, forKey: .value) {
                    Entity.Read(type: .user, code: $0.code, name: $0.name)
                }
                self = .modifier(entities)
            case .multiLineText:
                self = .multiLineText(try container.decode(String.self, forKey: .value))
            case .multiSelect:
                self = .multiSelect(try container.decode([String].self, forKey: .value))
            case .number:
                self = .number(try container.decode(String.self, forKey: .value))
            case .organizationSelect:
                let entities = try container.customDecode([EntityValue].self, forKey: .value) {
                    $0.map { Entity.Read(type: .organization, code: $0.code, name: $0.name) }
                }
                self = .organizationSelect(entities)
            case .radioButton:
                self = .radioButton(try container.decode(String?.self, forKey: .value))
            case .recordNumber:
                self = .recordNumber(try container.decode(String.self, forKey: .value))
            case .revision:
                self = .revision(try container.customDecode(String.self, forKey: .value, initializer: { Int($0) }))
            case .richText:
                self = .richText(try container.decode(String.self, forKey: .value))
            case .singleLineText:
                self = .singleLineText(try container.decode(String.self, forKey: .value))
            case .status:
                self = .status(try container.decode(String.self, forKey: .value))
            case .statusAssignee:
                let entities = try container.customDecode([EntityValue].self, forKey: .value) {
                    $0.map { Entity.Read(type: .user, code: $0.code, name: $0.name) }
                }
                self = .statusAssignee(entities)
            case .subtable:
                self = .subTable(try container.decode([SubtableValue.Read].self, forKey: .value))
            case .time:
                let dateString = try container.decode(String?.self, forKey: .value)
                self = .time(DateFormatter.kintoneTime.date(fromOptional: dateString))
            case .updatedTime:
                let dateString = try container.decode(String.self, forKey: .value)
                self = .updatedTime(DateFormatter.kintoneDateTime.date(from: dateString)!)
            case .userSelect:
                let entities = try container.customDecode([EntityValue].self, forKey: .value) {
                    $0.map { Entity.Read(type: .user, code: $0.code, name: $0.name) }
                }
                self = .userSelect(entities)
            }
        }

        public var integer: Int? {
            switch self {
            case let .id(value): value
            case let .revision(value): value
            default: nil
            }
        }

        public var string: String? {
            switch self {
            case let .calc(value): value
            case let .dropDown(value): value
            case let .link(value): value
            case let .multiLineText(value): value
            case let .number(value): value
            case let .radioButton(value): value
            case let .recordNumber(value): value
            case let .richText(value): value
            case let .singleLineText(value): value
            case let .status(value): value
            default: nil
            }
        }

        public var strings: [String]? {
            switch self {
            case let .category(value): value
            case let .checkBox(value): value
            case let .multiSelect(value): value
            default: nil
            }
        }

        public var date: Date? {
            switch self {
            case let .createdTime(value): value
            case let .date(value): value
            case let .dateTime(value): value
            case let .time(value): value
            case let .updatedTime(value): value
            default: nil
            }
        }

        public var files: [File.Read]? {
            switch self {
            case let .file(value): value
            default: nil
            }
        }

        public var entity: Entity.Read? {
            switch self {
            case let .creator(value): value
            case let .modifier(value): value
            default: nil
            }
        }

        public var entities: [Entity.Read]? {
            switch self {
            case let .groupSelect(value): value
            case let .organizationSelect(value): value
            case let .statusAssignee(value): value
            case let .userSelect(value): value
            default: nil
            }
        }
    }
}
