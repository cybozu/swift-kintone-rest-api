//
//  FieldAttribute.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum FieldAttribute: Sendable, Equatable {
    case calc(CalcAttribute)
    case category(CategoryAttribute)
    case checkbox(CheckboxAttribute)
    case createdTime(CreatedTimeAttribute)
    case creator(CreatorAttribute)
    case date(DateAttribute)
    case dateTime(DateTimeAttribute)
    case dropDown(DropDownAttribute)
    case file(FileAttribute)
    case group(GroupAttribute)
    case groupSelection(GroupSelectionAttribute)
    case link(LinkAttribute)
    case lookup(LookupAttribute)
    case modifier(ModifierAttribute)
    case multiLineText(MultiLineTextAttribute)
    case multiSelection(MultiSelectionAttribute)
    case number(NumberAttribute)
    case organizationSelection(OrganizationSelectionAttribute)
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
    case userSelection(UserSelectionAttribute)
}
