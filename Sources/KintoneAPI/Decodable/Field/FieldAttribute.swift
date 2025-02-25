//
//  FieldAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum FieldAttribute: Sendable, Equatable {
    case calc(CalcAttribute)
    case category(CategoryAttribute)
    case checkBox(CheckBoxAttribute)
    case createdTime(CreatedTimeAttribute)
    case creator(CreatorAttribute)
    case date(DateAttribute)
    case dateTime(DateTimeAttribute)
    case dropDown(DropDownAttribute)
    case file(FileAttribute)
    case group(GroupAttribute)
    case groupSelect(GroupSelectAttribute)
    case link(LinkAttribute)
    case lookup(LookupAttribute)
    case modifier(ModifierAttribute)
    case multiLineText(MultiLineTextAttribute)
    case multiSelect(MultiSelectAttribute)
    case number(NumberAttribute)
    case organizationSelect(OrganizationSelectAttribute)
    case radioButton(RadioButtonAttribute)
    case recordNumber(RecordNumberAttribute)
    case referenceTable(ReferenceTableAttribute)
    case richText(RichTextAttribute)
    case singleLineText(SingleLineTextAttribute)
    case status(StatusAttribute)
    case statusAssignee(StatusAssigneeAttribute)
    case subtable(SubtableAttribute)
    case time(TimeAttribute)
    case updatedTime(UpdatedTimeAttribute)
    case userSelect(UserSelectAttribute)

    public static func == (lhs: FieldAttribute, rhs: FieldAttribute) -> Bool {
        switch (lhs, rhs) {
        case let (.calc(l), .calc(r)): l == r
        case let (.category(l), .category(r)): l == r
        case let (.checkBox(l), .checkBox(r)): l == r
        case let (.createdTime(l), .createdTime(r)): l == r
        case let (.creator(l), .creator(r)): l == r
        case let (.date(l), .date(r)): l == r
        case let (.dateTime(l), .dateTime(r)): l == r
        case let (.dropDown(l), .dropDown(r)): l == r
        case let (.file(l), .file(r)): l == r
        case let (.group(l), .group(r)): l == r
        case let (.groupSelect(l), .groupSelect(r)): l == r
        case let (.link(l), .link(r)): l == r
        case let (.lookup(l), .lookup(r)): l == r
        case let (.modifier(l), .modifier(r)): l == r
        case let (.multiLineText(l), .multiLineText(r)): l == r
        case let (.multiSelect(l), .multiSelect(r)): l == r
        case let (.number(l), .number(r)): l == r
        case let (.organizationSelect(l), .organizationSelect(r)): l == r
        case let (.radioButton(l), .radioButton(r)): l == r
        case let (.recordNumber(l), .recordNumber(r)): l == r
        case let (.referenceTable(l), .referenceTable(r)): l == r
        case let (.richText(l), .richText(r)): l == r
        case let (.singleLineText(l), .singleLineText(r)): l == r
        case let (.status(l), .status(r)): l == r
        case let (.statusAssignee(l), .statusAssignee(r)): l == r
        case let (.subtable(l), .subtable(r)): l == r
        case let (.time(l), .time(r)): l == r
        case let (.updatedTime(l), .updatedTime(r)): l == r
        case let (.userSelect(l), .userSelect(r)): l == r
        default: false
        }
    }
}
