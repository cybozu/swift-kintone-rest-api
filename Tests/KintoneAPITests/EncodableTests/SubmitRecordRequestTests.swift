import Foundation
import Testing

@testable import KintoneAPI

struct SubmitRecordRequestTests {
    @Test
    func request_empty_fields() throws {
        let sut = SubmitRecordRequest(
            appID: 0,
            record: .init(fields: [])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "record" : {

          }
        }
        """
        #expect(actual == expected)
    }

    @Test(arguments: [
        SingleValueFieldProperty(value: .date(Date(timeIntervalSince1970: 0)), expectedValue: "1970-01-01"),
        SingleValueFieldProperty(value: .dateTime(Date(timeIntervalSince1970: 0)), expectedValue: "1970-01-01T00:00:00Z"),
        SingleValueFieldProperty(value: .dropDown("dummy"), expectedValue: "dummy"),
        SingleValueFieldProperty(value: .link("https://example.com"), expectedValue: "https:\\/\\/example.com"),
        SingleValueFieldProperty(value: .multiLineText("dummy\ndummy"), expectedValue: "dummy\\ndummy"),
        SingleValueFieldProperty(value: .number("123.456"), expectedValue: "123.456"),
        SingleValueFieldProperty(value: .radioButton("dummy"), expectedValue: "dummy"),
        SingleValueFieldProperty(value: .richText("<h1>dummy</h1>"), expectedValue: "<h1>dummy<\\/h1>"),
        SingleValueFieldProperty(value: .singleLineText("dummy"), expectedValue: "dummy"),
        SingleValueFieldProperty(value: .time(Date(timeIntervalSince1970: 0)), expectedValue: "00:00"),
    ])
    func request_single_value(_ fieldProperty: SingleValueFieldProperty) throws {
        let sut = SubmitRecordRequest(
            appID: 0,
            record: .init(fields: [
                .init(code: "dummy", value: fieldProperty.value)
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "record" : {
            "dummy" : {
              "value" : "\(fieldProperty.expectedValue)"
            }
          }
        }
        """
        #expect(actual == expected)
    }

    @Test(arguments: [
        ArrayValueFieldProperty(value: .checkBox(["dummy1", "dummy2"])),
        ArrayValueFieldProperty(value: .multiSelect(["dummy1", "dummy2"])),
    ])
    func request_array_value(_ fieldProperty: ArrayValueFieldProperty) throws {
        let sut = SubmitRecordRequest(
            appID: 0,
            record: .init(fields: [
                .init(code: "dummy", value: fieldProperty.value)
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                "dummy1",
                "dummy2"
              ]
            }
          }
        }
        """
        #expect(actual == expected)
    }

    @Test(arguments: [
        EntityValueFieldProperty(
            value: .groupSelect([.init(type: .group, code: "dummy")]),
            expectedType: "GROUP"
        ),
        EntityValueFieldProperty(
            value: .organizationSelect([.init(type: .organization, code: "dummy")]),
            expectedType: "ORGANIZATION"
        ),
        EntityValueFieldProperty(
            value: .userSelect([.init(type: .user, code: "dummy")]),
            expectedType: "USER"
        ),
    ])
    func request_entity_select(_ fieldProperty: EntityValueFieldProperty) throws {
        let sut = SubmitRecordRequest(
            appID: 0,
            record: .init(fields: [
                .init(code: "dummy", value: fieldProperty.value)
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                {
                  "code" : "dummy",
                  "type" : "\(fieldProperty.expectedType)"
                }
              ]
            }
          }
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_file() throws {
        let sut = SubmitRecordRequest(
            appID: 0,
            record: .init(fields: [
                .init(code: "dummy", value: .file([.init(fileKey: "dummy")]))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                {
                  "fileKey" : "dummy"
                }
              ]
            }
          }
        }
        """
        #expect(actual == expected)
    }

    struct SingleValueFieldProperty {
        var value: RecordFieldValue.Write
        var expectedValue: String
    }

    struct ArrayValueFieldProperty {
        var value: RecordFieldValue.Write
    }

    struct EntityValueFieldProperty {
        var value: RecordFieldValue.Write
        var expectedType: String
    }
}
