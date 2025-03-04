//
//  Endpoint.swift
//
//
//  Created by ky0me22 on 2024/12/17.
//

enum Endpoint: String {
    case apps =           "/k/v1/apps.json"
    case formLayout =     "/k/v1/app/form/layout.json"
    case fields =         "/k/v1/app/form/fields.json"
    case appSettings =    "/k/v1/app/settings.json"
    case appStatus =      "/k/v1/app/status.json"
    case appViews =       "/k/v1/app/views.json"
    case records =        "/k/v1/records.json"
    case record =         "/k/v1/record.json"
    case recordComments = "/k/v1/record/comments.json"
    case recordStatus =   "/k/v1/record/status.json"
    case file =           "/k/v1/file.json"
}
