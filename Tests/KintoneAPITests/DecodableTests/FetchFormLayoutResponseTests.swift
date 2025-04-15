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
        #expect(actual == .init(layoutChunks: [], revision: 1))
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
        FieldProperty(type: "GROUP_SELECT", expectedType: .groupSelection),
        FieldProperty(type: "LINK", expectedType: .link),
        FieldProperty(type: "MODIFIER", expectedType: .modifier),
        FieldProperty(type: "MULTI_LINE_TEXT", expectedType: .multiLineText),
        FieldProperty(type: "MULTI_SELECT", expectedType: .multiSelection),
        FieldProperty(type: "NUMBER", expectedType: .number),
        FieldProperty(type: "ORGANIZATION_SELECT", expectedType: .organizationSelection),
        FieldProperty(type: "RADIO_BUTTON", expectedType: .radioButton),
        FieldProperty(type: "RECORD_NUMBER", expectedType: .recordNumber),
        FieldProperty(type: "RICH_TEXT", expectedType: .richText),
        FieldProperty(type: "SINGLE_LINE_TEXT", expectedType: .singleLineText),
        FieldProperty(type: "TIME", expectedType: .time),
        FieldProperty(type: "UPDATED_TIME", expectedType: .updatedTime),
        FieldProperty(type: "USER_SELECT", expectedType: .userSelection),
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .row,
                    code: nil,
                    fields: [.init(type: fieldProperty.expectedType, code: "dummy", label: nil, elementID: nil)],
                    layoutChunks: []
                )
            ],
            revision: 1
        ))
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .row,
                    code: nil,
                    fields: [.init(type: .hr, code: nil, label: nil, elementID: nil)],
                    layoutChunks: []
                )
            ],
            revision: 1
        ))
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .row,
                    code: nil,
                    fields: [.init(type: .label, code: nil, label: "dummy", elementID: nil)],
                    layoutChunks: []
                )
            ],
            revision: 1
        ))
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .row,
                    code: nil,
                    fields: [.init(type: .spacer, code: nil, label: nil, elementID: "dummy")],
                    layoutChunks: []
                )
            ],
            revision: 1
        ))
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .row,
                    code: nil,
                    fields: [.init(type: .referenceTable, code: "dummy", label: nil, elementID: nil)],
                    layoutChunks: []
                )
            ],
            revision: 1
        ))
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .group,
                    code: "dummy",
                    fields: [],
                    layoutChunks: [
                        .init(
                            type: .row,
                            code: nil,
                            fields: [.init(type: fieldProperty.expectedType, code: "dummy", label: nil, elementID: nil)],
                            layoutChunks: []
                        )
                    ]
                )
            ],
            revision: 1
        ))
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
        #expect(actual == .init(
            layoutChunks: [
                .init(
                    type: .subtable,
                    code: "dummy",
                    fields: [
                        .init(type: fieldProperty.expectedType, code: "dummy", label: nil, elementID: nil)
                    ],
                    layoutChunks: []
                )
            ],
            revision: 1
        ))
    }

    struct FieldProperty {
        var type: String
        var expectedType: FormFieldType
    }
}
