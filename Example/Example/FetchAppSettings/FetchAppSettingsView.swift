//
//  FetchAppSettingsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct FetchAppSettingsView: View {
    private var name: String?
    private var description: String?
    private var icon: AppIcon.Read?
    private var theme: AppThemeType?
    private var titleField: TitleField?
    private var enableThumbnails: Bool?
    private var enableBulkDeletion: Bool?
    private var enableComments: Bool?
    private var enableDuplicateRecord: Bool?
    private var enableInlineRecordEditing: Bool?
    private var numberPrecision: NumberPrecision?
    private var firstMonthOfFiscalYear: Int?
    private var revision: Int?
    private var downloadFileHandler: (String) async -> Data?

    init(
        appSettingsResponse: FetchAppSettingsResponse?,
        downloadFileHandler: @escaping (String) async -> Data?
    ) {
        name = appSettingsResponse?.name
        description = appSettingsResponse?.description
        icon = appSettingsResponse?.icon
        theme = appSettingsResponse?.theme
        titleField = appSettingsResponse?.titleField
        enableThumbnails = appSettingsResponse?.enableThumbnails
        enableBulkDeletion = appSettingsResponse?.enableBulkDeletion
        enableComments = appSettingsResponse?.enableComments
        enableDuplicateRecord = appSettingsResponse?.enableDuplicateRecord
        enableInlineRecordEditing = appSettingsResponse?.enableInlineRecordEditing
        numberPrecision = appSettingsResponse?.numberPrecision
        firstMonthOfFiscalYear = appSettingsResponse?.firstMonthOfFiscalYear
        revision = appSettingsResponse?.revision
        self.downloadFileHandler = downloadFileHandler
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                CornerRadiusText("Name: \(String(optional: name))")
                CornerRadiusText("Description: \(String(optional: description))")
                IconFileView(icon: icon, downloadFileHandler: downloadFileHandler)
                CornerRadiusText("Theme: \(String(optional: theme?.rawValue))")
                TitleFieldView(titleField: titleField)
                CornerRadiusText("Enable Thumbnails: \(String(optional: enableThumbnails))")
                CornerRadiusText("Enable Bulk Deletion: \(String(optional: enableBulkDeletion))")
                CornerRadiusText("Enable Comments: \(String(optional: enableComments))")
                CornerRadiusText("Enable Duplicate Record: \(String(optional: enableDuplicateRecord))")
                CornerRadiusText("Enable Inline Record Editing: \(String(optional: enableInlineRecordEditing))")
                NumberPrecisionView(numberPrecision: numberPrecision)
                CornerRadiusText("First Month Of Fiscal Year: \(String(optional: firstMonthOfFiscalYear))")
                CornerRadiusText("Revision: \(String(optional: revision))")
            }
            .padding()
        }
    }
}
