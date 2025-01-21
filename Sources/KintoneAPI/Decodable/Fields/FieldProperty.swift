//
//  FieldProperty.swift
//
//
//  Created by ky0me22 on 2024/12/07.
//

public struct FieldProperty: Decodable, Sendable {
    public var code: String
    public var label: String
    public var type: FieldType
    public var data: FieldData

    enum CodingKeys: String, CodingKey {
        case code
        case label
        case type
        case data
        case lookup
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        label = try container.decode(String.self, forKey: .label)
        type = try container.decode(FieldType.self, forKey: .type)
        data = if container.allKeys.contains(.lookup) {
            try FieldData.lookup(LookupData(from: decoder))
        } else {
            switch type {
            case .calc:
                try FieldData.calc(CalcData(from: decoder))
            case .category:
                try FieldData.category(CategoryData(from: decoder))
            case .checkBox:
                try FieldData.checkBox(CheckBoxData(from: decoder))
            case .createdTime:
                try FieldData.createdTime(CreatedTimeData(from: decoder))
            case .creator:
                try FieldData.creator(CreatorData(from: decoder))
            case .date:
                try FieldData.date(DateData(from: decoder))
            case .dateTime:
                try FieldData.dateTime(DateTimeData(from: decoder))
            case .dropDown:
                try FieldData.dropDown(DropDownData(from: decoder))
            case .file:
                try FieldData.file(FileData(from: decoder))
            case .group:
                try FieldData.group(GroupData(from: decoder))
            case .groupSelect:
                try FieldData.groupSelect(GroupSelectData(from: decoder))
            case .link:
                try FieldData.link(LinkData(from: decoder))
            case .modifier:
                try FieldData.modifier(ModifierData(from: decoder))
            case .multiLineText:
                try FieldData.multiLineText(MultiLineTextData(from: decoder))
            case .multiSelect:
                try FieldData.multiSelect(MultiSelectData(from: decoder))
            case .number:
                try FieldData.number(NumberData(from: decoder))
            case .organizationSelect:
                try FieldData.organizationSelect(OrganizationSelectData(from: decoder))
            case .radioButton:
                try FieldData.radioButton(RadioButtonData(from: decoder))
            case .recordNumber:
                try FieldData.recordNumber(RecordNumberData(from: decoder))
            case .richText:
                try FieldData.richText(RichTextData(from: decoder))
            case .singleLineText:
                try FieldData.singleLineText(SingleLineTextData(from: decoder))
            case .status:
                try FieldData.status(StatusData(from: decoder))
            case .statusAssignee:
                try FieldData.statusAssignee(StatusAssigneeData(from: decoder))
            case .subtable:
                try FieldData.subtable(SubtableData(from: decoder))
            case .time:
                try FieldData.time(TimeData(from: decoder))
            case .updatedTime:
                try FieldData.updatedTime(UpdatedTimeData(from: decoder))
            case .userSelect:
                try FieldData.userSelect(UserSelectData(from: decoder))
            default:
                FieldData.other
            }
        }
    }
}
