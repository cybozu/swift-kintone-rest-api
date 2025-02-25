//
//  FetchAppSettingsResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

public struct FetchAppSettingsResponse: Decodable, Sendable, Equatable {
    public var name: String
    public var description: String
    public var icon: AppIcon.Read
    public var theme: AppThemeType
    public var titleField: TitleField
    public var enableThumbnails: Bool
    public var enableBulkDeletion: Bool
    public var enableComments: Bool
    public var enableDuplicateRecord: Bool
    public var enableInlineRecordEditing: Bool
    public var numberPrecision: NumberPrecision
    public var firstMonthOfFiscalYear: Int
    public var revision: Int

    enum CodingKeys: CodingKey {
        case name
        case description
        case icon
        case theme
        case titleField
        case enableThumbnails
        case enableBulkDeletion
        case enableComments
        case enableDuplicateRecord
        case enableInlineRecordEditing
        case numberPrecision
        case firstMonthOfFiscalYear
        case revision
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(AppIcon.Read.self, forKey: .icon)
        theme = try container.decode(AppThemeType.self, forKey: .theme)
        titleField = try container.decode(TitleField.self, forKey: .titleField)
        enableThumbnails = try container.decode(Bool.self, forKey: .enableThumbnails)
        enableBulkDeletion = try container.decode(Bool.self, forKey: .enableBulkDeletion)
        enableComments = try container.decode(Bool.self, forKey: .enableComments)
        enableDuplicateRecord = try container.decode(Bool.self, forKey: .enableDuplicateRecord)
        enableInlineRecordEditing = try container.decode(Bool.self, forKey: .enableInlineRecordEditing)
        numberPrecision = try container.decode(NumberPrecision.self, forKey: .numberPrecision)
        firstMonthOfFiscalYear = try container.customDecode(String.self, forKey: .firstMonthOfFiscalYear) { Int($0) }
        revision = try container.customDecode(String.self, forKey: .revision) { Int($0) }
    }

    init(
        name: String,
        description: String,
        icon: AppIcon.Read,
        theme: AppThemeType,
        titleField: TitleField,
        enableThumbnails: Bool,
        enableBulkDeletion: Bool,
        enableComments: Bool,
        enableDuplicateRecord: Bool,
        enableInlineRecordEditing: Bool,
        numberPrecision: NumberPrecision,
        firstMonthOfFiscalYear: Int,
        revision: Int
    ) {
        self.name = name
        self.description = description
        self.icon = icon
        self.theme = theme
        self.titleField = titleField
        self.enableThumbnails = enableThumbnails
        self.enableBulkDeletion = enableBulkDeletion
        self.enableComments = enableComments
        self.enableDuplicateRecord = enableDuplicateRecord
        self.enableInlineRecordEditing = enableInlineRecordEditing
        self.numberPrecision = numberPrecision
        self.firstMonthOfFiscalYear = firstMonthOfFiscalYear
        self.revision = revision
    }
}
