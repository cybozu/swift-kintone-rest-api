//
//  FetchAppSettingsView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/31.
//

import KintoneAPI
import SwiftUI

struct FetchAppSettingsView: View {
    var appSettings: AppSettings?
    var downloadFileHandler: (String) async -> Data?

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if let appSettings {
                    CornerRadiusText("Name: \(appSettings.name)")
                    CornerRadiusText("Description: \(appSettings.description)")
                    IconFileView(icon: appSettings.icon, downloadFileHandler: downloadFileHandler)
                    CornerRadiusText("Theme: \(appSettings.theme)")
                    TitleFieldView(titleField: appSettings.titleField)
                    CornerRadiusText("Enable Thumbnails: \(appSettings.enableThumbnails)")
                    CornerRadiusText("Enable Bulk Deletion: \(appSettings.enableBulkDeletion)")
                    CornerRadiusText("Enable Comments: \(appSettings.enableComments)")
                    CornerRadiusText("Enable Duplicate Record: \(appSettings.enableDuplicateRecord)")
                    CornerRadiusText("Enable Inline Record Editing: \(appSettings.enableInlineRecordEditing)")
                    NumberPrecisionView(numberPrecision: appSettings.numberPrecision)
                    CornerRadiusText("First Month Of Fiscal Year: \(appSettings.firstMonthOfFiscalYear)")
                    CornerRadiusText("Revision: \(appSettings.revision)")
                } else {
                    Spacer()
                }
            }
            .padding()
        }
    }
}
