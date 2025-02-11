//
//  FormFieldType.swift
//
//
//  Created by ky0me22 on 2025/01/23.
//

public enum FormFieldType: String, Decodable, Sendable {
    case calc = "CALC"
    case checkBox = "CHECK_BOX"
    case createdTime = "CREATED_TIME"
    case creator = "CREATOR"
    case date = "DATE"
    case dateTime = "DATETIME"
    case dropDown = "DROP_DOWN"
    case file = "FILE"
    case groupSelect = "GROUP_SELECT"
    case hr = "HR"
    case label = "LABEL"
    case link = "LINK"
    case modifier = "MODIFIER"
    case multiLineText = "MULTI_LINE_TEXT"
    case multiSelect = "MULTI_SELECT"
    case number = "NUMBER"
    case organizationSelect = "ORGANIZATION_SELECT"
    case radioButton = "RADIO_BUTTON"
    case recordNumber = "RECORD_NUMBER"
    case referenceTable = "REFERENCE_TABLE"
    case richText = "RICH_TEXT"
    case singleLineText = "SINGLE_LINE_TEXT"
    case spacer = "SPACER"
    case time = "TIME"
    case updatedTime = "UPDATED_TIME"
    case userSelect = "USER_SELECT"
}
