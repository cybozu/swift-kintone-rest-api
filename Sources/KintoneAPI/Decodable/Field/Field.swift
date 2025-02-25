//
//  Field.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct Field: Decodable, Sendable, Equatable {
    public var code: String
    public var label: String
    public var type: FieldType
    public var attribute: FieldAttribute

    enum CodingKeys: CodingKey {
        case code
        case label
        case type
        case lookup
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        label = try container.decode(String.self, forKey: .label)
        type = try container.decode(FieldType.self, forKey: .type)
        attribute = if container.allKeys.contains(.lookup) {
            try FieldAttribute.lookup(LookupAttribute(from: decoder))
        } else {
            switch type {
            case .calc:
                try FieldAttribute.calc(CalcAttribute(from: decoder))
            case .category:
                try FieldAttribute.category(CategoryAttribute(from: decoder))
            case .checkBox:
                try FieldAttribute.checkBox(CheckBoxAttribute(from: decoder))
            case .createdTime:
                try FieldAttribute.createdTime(CreatedTimeAttribute(from: decoder))
            case .creator:
                try FieldAttribute.creator(CreatorAttribute(from: decoder))
            case .date:
                try FieldAttribute.date(DateAttribute(from: decoder))
            case .dateTime:
                try FieldAttribute.dateTime(DateTimeAttribute(from: decoder))
            case .dropDown:
                try FieldAttribute.dropDown(DropDownAttribute(from: decoder))
            case .file:
                try FieldAttribute.file(FileAttribute(from: decoder))
            case .group:
                try FieldAttribute.group(GroupAttribute(from: decoder))
            case .groupSelect:
                try FieldAttribute.groupSelect(GroupSelectAttribute(from: decoder))
            case .link:
                try FieldAttribute.link(LinkAttribute(from: decoder))
            case .modifier:
                try FieldAttribute.modifier(ModifierAttribute(from: decoder))
            case .multiLineText:
                try FieldAttribute.multiLineText(MultiLineTextAttribute(from: decoder))
            case .multiSelect:
                try FieldAttribute.multiSelect(MultiSelectAttribute(from: decoder))
            case .number:
                try FieldAttribute.number(NumberAttribute(from: decoder))
            case .organizationSelect:
                try FieldAttribute.organizationSelect(OrganizationSelectAttribute(from: decoder))
            case .radioButton:
                try FieldAttribute.radioButton(RadioButtonAttribute(from: decoder))
            case .recordNumber:
                try FieldAttribute.recordNumber(RecordNumberAttribute(from: decoder))
            case .referenceTable:
                try FieldAttribute.referenceTable(ReferenceTableAttribute(from: decoder))
            case .richText:
                try FieldAttribute.richText(RichTextAttribute(from: decoder))
            case .singleLineText:
                try FieldAttribute.singleLineText(SingleLineTextAttribute(from: decoder))
            case .status:
                try FieldAttribute.status(StatusAttribute(from: decoder))
            case .statusAssignee:
                try FieldAttribute.statusAssignee(StatusAssigneeAttribute(from: decoder))
            case .subtable:
                try FieldAttribute.subtable(SubtableAttribute(from: decoder))
            case .time:
                try FieldAttribute.time(TimeAttribute(from: decoder))
            case .updatedTime:
                try FieldAttribute.updatedTime(UpdatedTimeAttribute(from: decoder))
            case .userSelect:
                try FieldAttribute.userSelect(UserSelectAttribute(from: decoder))
            }
        }
    }

    init(code: String, label: String, type: FieldType, attribute: FieldAttribute) {
        self.code = code
        self.label = label
        self.type = type
        self.attribute = attribute
    }
}
