//
//  FieldData.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum FieldData: Sendable {
    case calc(CalcData)
    case category(CategoryData)
    case checkBox(CheckBoxData)
    case createdTime(CreatedTimeData)
    case creator(CreatorData)
    case date(DateData)
    case dateTime(DateTimeData)
    case dropDown(DropDownData)
    case file(FileData)
    case group(GroupData)
    case groupSelect(GroupSelectData)
    case link(LinkData)
    case lookup(LookupData)
    case modifier(ModifierData)
    case multiLineText(MultiLineTextData)
    case multiSelect(MultiSelectData)
    case number(NumberData)
    case organizationSelect(OrganizationSelectData)
    case radioButton(RadioButtonData)
    case recordNumber(RecordNumberData)
    case richText(RichTextData)
    case singleLineText(SingleLineTextData)
    case status(StatusData)
    case statusAssignee(StatusAssigneeData)
    case time(TimeData)
    case updatedTime(UpdatedTimeData)
    case userSelect(UserSelectData)
    case other
}
