import Foundation
import Testing

@testable import KintoneAPI

struct FetchAppSettingsResponseTests {
    @Test
    func response_preset_icon() throws {
        let input = """
        {
          "name" : "dummy",
          "description" : "dummy",
          "icon" : {
            "type" : "PRESET",
            "key" : "APP39"
          },
          "theme" : "WHITE",
          "titleField" : {
            "selectionMode" : "AUTO",
            "code" : "dummy"
          },
          "enableThumbnails" : true,
          "enableBulkDeletion" : true,
          "enableComments" : true,
          "enableDuplicateRecord" : true,
          "enableInlineRecordEditing" : true,
          "numberPrecision" : {
            "digits" : "16",
            "decimalPlaces" : "4",
            "roundingMode" : "HALF_EVEN"
          },
          "firstMonthOfFiscalYear" : "1",
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppSettingsResponse.self, from: data)
        #expect(actual.appSettings.name == "dummy")
        #expect(actual.appSettings.description == "dummy")
        if case let .preset(key) = actual.appSettings.icon {
            #expect(key == "APP39")
        } else {
            Issue.record("icon must be preset type.")
        }
        #expect(actual.appSettings.theme == .white)
        #expect(actual.appSettings.titleField.selectionMode == .automatic)
        #expect(actual.appSettings.titleField.code == "dummy")
        #expect(actual.appSettings.enableThumbnails)
        #expect(actual.appSettings.enableBulkDeletion)
        #expect(actual.appSettings.enableComments)
        #expect(actual.appSettings.enableDuplicateRecord)
        #expect(actual.appSettings.enableInlineRecordEditing)
        #expect(actual.appSettings.numberPrecision.digits == 16)
        #expect(actual.appSettings.numberPrecision.decimalPlaces == 4)
        #expect(actual.appSettings.numberPrecision.roundingMode == .halfEven)
        #expect(actual.appSettings.firstMonthOfFiscalYear == 1)
        #expect(actual.appSettings.revision == 1)
    }

    @Test
    func response_preset_file() throws {
        let input = """
        {
          "name" : "dummy",
          "description" : "dummy",
          "icon" : {
            "type" : "FILE",
            "file" : {
              "fileKey" : "dummy",
              "name" : "dummy.png",
              "contentType" : "image/png",
              "size" : "10000"
            }
          },
          "theme" : "BLACK",
          "titleField" : {
            "selectionMode" : "MANUAL",
            "code" : "dummy"
          },
          "enableThumbnails" : false,
          "enableBulkDeletion" : false,
          "enableComments" : false,
          "enableDuplicateRecord" : false,
          "enableInlineRecordEditing" : false,
          "numberPrecision" : {
            "digits" : "16",
            "decimalPlaces" : "4",
            "roundingMode" : "UP"
          },
          "firstMonthOfFiscalYear" : "1",
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppSettingsResponse.self, from: data)
        #expect(actual.appSettings.name == "dummy")
        #expect(actual.appSettings.description == "dummy")
        if case let .file(file) = actual.appSettings.icon {
            #expect(file.fileKey == "dummy")
            #expect(file.fileName == "dummy.png")
            #expect(file.mimeType == "image/png")
            #expect(file.fileSize == "10000")
        } else {
            Issue.record("icon must be file type.")
        }
        #expect(actual.appSettings.theme == .black)
        #expect(actual.appSettings.titleField.selectionMode == .manual)
        #expect(actual.appSettings.titleField.code == "dummy")
        #expect(actual.appSettings.enableThumbnails == false)
        #expect(actual.appSettings.enableBulkDeletion == false)
        #expect(actual.appSettings.enableComments == false)
        #expect(actual.appSettings.enableDuplicateRecord == false)
        #expect(actual.appSettings.enableInlineRecordEditing == false)
        #expect(actual.appSettings.numberPrecision.digits == 16)
        #expect(actual.appSettings.numberPrecision.decimalPlaces == 4)
        #expect(actual.appSettings.numberPrecision.roundingMode == .up)
        #expect(actual.appSettings.firstMonthOfFiscalYear == 1)
        #expect(actual.appSettings.revision == 1)
    }
}
