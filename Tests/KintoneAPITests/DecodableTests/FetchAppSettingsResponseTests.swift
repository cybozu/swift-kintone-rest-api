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
        #expect(actual == .init(
            name: "dummy",
            description: "dummy",
            icon: .preset("APP39"),
            theme: .white,
            titleField: .init(
                selectionMode: .automatic,
                code: "dummy"
            ),
            enableThumbnails: true,
            enableBulkDeletion: true,
            enableComments: true,
            enableDuplicateRecord: true,
            enableInlineRecordEditing: true,
            numberPrecision: .init(
                digits: 16,
                decimalPlaces: 4,
                roundingMode: .halfEven
            ),
            firstMonthOfFiscalYear: 1,
            revision: 1
        ))
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
              "contentType" : "image/png",
              "name" : "dummy.png",
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
        #expect(actual == .init(
            name: "dummy",
            description: "dummy",
            icon: .file(.init(
                fileKey: "dummy",
                mimeType: "image/png",
                fileName: "dummy.png",
                fileSize: "10000"
            )),
            theme: .black,
            titleField: .init(
                selectionMode: .manual,
                code: "dummy"
            ),
            enableThumbnails: false,
            enableBulkDeletion: false,
            enableComments: false,
            enableDuplicateRecord: false,
            enableInlineRecordEditing: false,
            numberPrecision: .init(
                digits: 16,
                decimalPlaces: 4,
                roundingMode: .up
            ),
            firstMonthOfFiscalYear: 1,
            revision: 1
        ))
    }
}
