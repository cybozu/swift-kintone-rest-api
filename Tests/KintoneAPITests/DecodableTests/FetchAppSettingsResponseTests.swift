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
        #expect(actual.name == "dummy")
        #expect(actual.description == "dummy")
        if case let .preset(key) = actual.icon {
            #expect(key == "APP39")
        } else {
            Issue.record("icon must be preset type.")
        }
        #expect(actual.theme == .white)
        #expect(actual.titleField.selectionMode == .automatic)
        #expect(actual.titleField.code == "dummy")
        #expect(actual.enableThumbnails)
        #expect(actual.enableBulkDeletion)
        #expect(actual.enableComments)
        #expect(actual.enableDuplicateRecord)
        #expect(actual.enableInlineRecordEditing)
        #expect(actual.numberPrecision.digits == 16)
        #expect(actual.numberPrecision.decimalPlaces == 4)
        #expect(actual.numberPrecision.roundingMode == .halfEven)
        #expect(actual.firstMonthOfFiscalYear == 1)
        #expect(actual.revision == 1)
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
        #expect(actual.name == "dummy")
        #expect(actual.description == "dummy")
        if case let .file(file) = actual.icon {
            #expect(file.fileKey == "dummy")
            #expect(file.fileName == "dummy.png")
            #expect(file.mimeType == "image/png")
            #expect(file.fileSize == "10000")
        } else {
            Issue.record("icon must be file type.")
        }
        #expect(actual.theme == .black)
        #expect(actual.titleField.selectionMode == .manual)
        #expect(actual.titleField.code == "dummy")
        #expect(actual.enableThumbnails == false)
        #expect(actual.enableBulkDeletion == false)
        #expect(actual.enableComments == false)
        #expect(actual.enableDuplicateRecord == false)
        #expect(actual.enableInlineRecordEditing == false)
        #expect(actual.numberPrecision.digits == 16)
        #expect(actual.numberPrecision.decimalPlaces == 4)
        #expect(actual.numberPrecision.roundingMode == .up)
        #expect(actual.firstMonthOfFiscalYear == 1)
        #expect(actual.revision == 1)
    }
}
