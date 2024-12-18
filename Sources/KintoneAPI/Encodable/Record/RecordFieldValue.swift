//
//  RecordFieldValue.swift
//
//
//  Created by ky0me22 on 2024/12/09.
//

import Foundation

public enum RecordFieldValue: Encodable, Sendable {
    case checkBox([String])
    case date(Date)
    case dateTime(Date)
    case dropDown(String)
    case file([FileObject])
    case groupSelect([CodeObject])
    case link(String)
    case multiLineText(String)
    case multiSelect([String])
    case number(String)
    case organizationSelect([CodeObject])
    case radioButton(String)
    case richText(String)
    case singleLineText(String)
    case time(Date)
    case userSelect([CodeObject])
}
