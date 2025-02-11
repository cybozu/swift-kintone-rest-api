//
//  FieldAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum FieldAttribute: Sendable {
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
}
