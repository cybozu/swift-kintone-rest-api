import Foundation
import Testing

@testable import KintoneAPI

struct FetchFormLayoutResponseTests {
    @Test
    func response_empty() throws {
        let input = """
        {
          "layout" : [],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.isEmpty)
        #expect(actual.formLayout.revision == 1)
    }

    @Test(arguments: [
        FieldProperty(type: "CALC", expectedType: .calc),
        FieldProperty(type: "CHECK_BOX", expectedType: .checkBox),
        FieldProperty(type: "CREATED_TIME", expectedType: .createdTime),
        FieldProperty(type: "CREATOR", expectedType: .creator),
        FieldProperty(type: "DATE", expectedType: .date),
        FieldProperty(type: "DATETIME", expectedType: .dateTime),
        FieldProperty(type: "DROP_DOWN", expectedType: .dropDown),
        FieldProperty(type: "FILE", expectedType: .file),
        FieldProperty(type: "GROUP_SELECT", expectedType: .groupSelect),
        FieldProperty(type: "LINK", expectedType: .link),
        FieldProperty(type: "MODIFIER", expectedType: .modifier),
        FieldProperty(type: "MULTI_LINE_TEXT", expectedType: .multiLineText),
        FieldProperty(type: "MULTI_SELECT", expectedType: .multiSelect),
        FieldProperty(type: "NUMBER", expectedType: .number),
        FieldProperty(type: "ORGANIZATION_SELECT", expectedType: .organizationSelect),
        FieldProperty(type: "RADIO_BUTTON", expectedType: .radioButton),
        FieldProperty(type: "RECORD_NUMBER", expectedType: .recordNumber),
        FieldProperty(type: "RICH_TEXT", expectedType: .richText),
        FieldProperty(type: "SINGLE_LINE_TEXT", expectedType: .singleLineText),
        FieldProperty(type: "TIME", expectedType: .time),
        FieldProperty(type: "UPDATED_TIME", expectedType: .updatedTime),
        FieldProperty(type: "USER_SELECT", expectedType: .userSelect),
    ])
    func response_row(_ fieldProperty: FieldProperty) throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "ROW",
              "fields" : [
                {
                  "type" : "\(fieldProperty.type)",
                  "code" : "dummy",
                  "size" : { "width" : "100" }
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .row)
        #expect(layoutChunk.fields.count == 1)
        let field = try #require(layoutChunk.fields.first)
        #expect(field.type == fieldProperty.expectedType)
        #expect(field.code == "dummy")
        #expect(field.label == nil)
        #expect(field.elementID == nil)
        #expect(actual.formLayout.revision == 1)
    }

    @Test
    func response_row_hr() throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "ROW",
              "fields" : [
                {
                  "type" : "HR",
                  "size" : { "width" : "100" }
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .row)
        #expect(layoutChunk.fields.count == 1)
        let field = try #require(layoutChunk.fields.first)
        #expect(field.type == .hr)
        #expect(field.code == nil)
        #expect(field.label == nil)
        #expect(field.elementID == nil)
        #expect(actual.formLayout.revision == 1)
    }

    @Test
    func response_row_label() throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "ROW",
              "fields" : [
                {
                  "type" : "LABEL",
                  "label" : "dummy",
                  "size" : { "width" : "100" }
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .row)
        #expect(layoutChunk.fields.count == 1)
        let field = try #require(layoutChunk.fields.first)
        #expect(field.type == .label)
        #expect(field.code == nil)
        #expect(field.label == "dummy")
        #expect(field.elementID == nil)
        #expect(actual.formLayout.revision == 1)
    }

    @Test
    func response_row_spacer() throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "ROW",
              "fields" : [
                {
                  "type" : "SPACER",
                  "elementId" : "dummy",
                  "size" : { "width" : "100" }
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .row)
        #expect(layoutChunk.fields.count == 1)
        let field = try #require(layoutChunk.fields.first)
        #expect(field.type == .spacer)
        #expect(field.code == nil)
        #expect(field.label == nil)
        #expect(field.elementID == "dummy")
        #expect(actual.formLayout.revision == 1)
    }

    @Test
    func response_row_reference_table() throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "ROW",
              "fields" : [
                {
                  "type" : "REFERENCE_TABLE",
                  "code" : "dummy"
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .row)
        #expect(layoutChunk.fields.count == 1)
        let field = try #require(layoutChunk.fields.first)
        #expect(field.type == .referenceTable)
        #expect(field.code == "dummy")
        #expect(field.label == nil)
        #expect(field.elementID == nil)
        #expect(actual.formLayout.revision == 1)
    }

    @Test(arguments: [
        FieldProperty(type: "SINGLE_LINE_TEXT", expectedType: .singleLineText),
        FieldProperty(type: "NUMBER", expectedType: .number),
    ])
    func response_group(_ fieldProperty: FieldProperty) throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "GROUP",
              "code" : "dummy",
              "layout" : [
                {
                  "type" : "ROW",
                  "fields" : [
                    {
                      "type" : "\(fieldProperty.type)",
                      "code" : "dummy",
                      "size" : { "width" : "100" }
                    }
                  ]
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .group)
        #expect(layoutChunk.code == "dummy")
        #expect(layoutChunk.fields.isEmpty)
        #expect(layoutChunk.layoutChunks.count == 1)
        let subLayoutChunk = try #require(layoutChunk.layoutChunks.first)
        #expect(subLayoutChunk.type == .row)
        #expect(subLayoutChunk.code == nil)
        #expect(subLayoutChunk.fields.count == 1)
        let subField = try #require(subLayoutChunk.fields.first)
        #expect(subField.type == fieldProperty.expectedType)
        #expect(subField.code == "dummy")
        #expect(subField.label == nil)
        #expect(subField.elementID == nil)
        #expect(subLayoutChunk.layoutChunks.isEmpty)
        #expect(actual.formLayout.revision == 1)
    }

    @Test(arguments: [
        FieldProperty(type: "SINGLE_LINE_TEXT", expectedType: .singleLineText),
        FieldProperty(type: "NUMBER", expectedType: .number),
    ])
    func response_subtable(_ fieldProperty: FieldProperty) throws {
        let input = """
        {
          "layout" : [
            {
              "type" : "SUBTABLE",
              "code" : "dummy",
              "fields" : [
                {
                  "type" : "\(fieldProperty.type)",
                  "code" : "dummy",
                  "size" : { "width" : "100" }
                }
              ]
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        #expect(actual.formLayout.layoutChunks.count == 1)
        let layoutChunk = try #require(actual.formLayout.layoutChunks.first)
        #expect(layoutChunk.type == .subtable)
        #expect(layoutChunk.code == "dummy")
        #expect(layoutChunk.fields.count == 1)
        let field = try #require(layoutChunk.fields.first)
        #expect(field.type == fieldProperty.expectedType)
        #expect(field.code == "dummy")
        #expect(field.label == nil)
        #expect(field.elementID == nil)
        #expect(layoutChunk.layoutChunks.isEmpty)
        #expect(actual.formLayout.revision == 1)
    }

    struct FieldProperty {
        var type: String
        var expectedType: FormFieldType
    }
}
