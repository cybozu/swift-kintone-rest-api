import Foundation
import Testing

@testable import KintoneAPI

struct FetchFieldsResponseTests {
    @Test
    func response_empty_unexpected() throws {
        let input = """
        {
          "properties" : {},
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(fields: [], revision: 1))
    }

    @Test(arguments: [
        CalcProperty(format: "NUMBER", expectedFormat: .number, unitPosition: "BEFORE", expectedUnitPosition: .before),
        CalcProperty(format: "NUMBER_DIGIT", expectedFormat: .numberDigit, unitPosition: "AFTER", expectedUnitPosition: .after),
        CalcProperty(format: "DATETIME", expectedFormat: .dateTime, unitPosition: "BEFORE", expectedUnitPosition: .before),
        CalcProperty(format: "DATE", expectedFormat: .date, unitPosition: "AFTER", expectedUnitPosition: .after),
        CalcProperty(format: "TIME", expectedFormat: .time, unitPosition: "BEFORE", expectedUnitPosition: .before),
        CalcProperty(format: "HOUR_MINUTE", expectedFormat: .hourMinute, unitPosition: "AFTER", expectedUnitPosition: .after),
        CalcProperty(format: "DAY_HOUR_MINUTE", expectedFormat: .dayHourMinute, unitPosition: "BEFORE", expectedUnitPosition: .before),
    ])
    func response_calc(_ calcProperty: CalcProperty) throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "CALC",
              "noLabel" : true,
              "required" : true,
              "expression" : "ROUND(dummy)",
              "hideExpression" : true,
              "format" : "\(calcProperty.format)",
              "displayScale" : "3",
              "unit" : "$",
              "unitPosition" : "\(calcProperty.unitPosition)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .calc,
                    attribute: .calc(.init(
                        noLabel: true,
                        required: true,
                        expression: "ROUND(dummy)",
                        hideExpression: true,
                        format: calcProperty.expectedFormat,
                        displayScale: 3,
                        unit: "$",
                        unitPosition: calcProperty.expectedUnitPosition
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_category() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "CATEGORY",
              "enabled" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .category,
                    attribute: .category(.init(enabled: true))
                )
            ],
            revision: 1
        ))
    }

    @Test(arguments: [
        CheckboxProperty(alignment: "HORIZONTAL", expectedAlignment: .horizontal),
        CheckboxProperty(alignment: "VERTICAL", expectedAlignment: .vertical),
    ])
    func response_checkbox(_ checkboxProperty: CheckboxProperty) throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "CHECK_BOX",
              "noLabel" : true,
              "required" : true,
              "options" : {
                  "dummy0" : { "label" : "dummy0", "index" : "0" },
                  "dummy1" : { "label" : "dummy1", "index" : "1" }
              },
              "defaultValue" : ["dummy0"],
              "align" : "\(checkboxProperty.alignment)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .checkbox,
                    attribute: .checkbox(.init(
                        noLabel: true,
                        required: true,
                        options: [.init(label: "dummy0", index: 0), .init(label: "dummy1", index: 1)],
                        defaultValue: ["dummy0"],
                        alignment: checkboxProperty.expectedAlignment
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_createdTime() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "CREATED_TIME",
              "noLabel" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .createdTime,
                    attribute: .createdTime(.init(noLabel: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_creator() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "CREATOR",
              "noLabel" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .creator,
                    attribute: .creator(.init(noLabel: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_date() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "DATE",
              "noLabel" : true,
              "required" : true,
              "unique" : true,
              "defaultNowValue" : false,
              "defaultValue" : "0001-01-01"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .date,
                    attribute: .date(.init(
                        noLabel: true,
                        required: true,
                        unique: true,
                        defaultNowValue: false,
                        defaultValue: .distantPast
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_dateTime() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "DATETIME",
              "noLabel" : true,
              "required" : true,
              "unique" : true,
              "defaultNowValue" : false,
              "defaultValue" : "0001-01-01T00:00"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .dateTime,
                    attribute: .dateTime(.init(
                        noLabel: true,
                        required: true,
                        unique: true,
                        defaultNowValue: false,
                        defaultValue: .distantPast
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_dropDown() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "DROP_DOWN",
              "noLabel" : true,
              "required" : true,
              "options" : {
                "dummy0" : { "label" : "dummy0", "index" : "0" },
                "dummy1" : { "label" : "dummy1", "index" : "1" }
              },
              "defaultValue" : "dummy0"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .dropDown,
                    attribute: .dropDown(.init(
                        noLabel: true,
                        required: true,
                        options: [.init(label: "dummy0", index: 0), .init(label: "dummy1", index: 1)],
                        defaultValue: "dummy0"
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_file() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "FILE",
              "noLabel" : true,
              "required" : true,
              "thumbnailSize" : "150"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .file,
                    attribute: .file(.init(
                        noLabel: true,
                        required: true,
                        thumbnailSize: 150
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_group() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "GROUP",
              "noLabel" : true,
              "openGroup" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .group,
                    attribute: .group(.init(noLabel: true, openGroup: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_groupSelection() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "GROUP_SELECT",
              "noLabel" : true,
              "required" : true,
              "entities" : [
                { "type" : "GROUP", "code" : "dummy0" },
                { "type" : "GROUP", "code" : "dummy1" }
              ],
              "defaultValue" : [
                { "type" : "GROUP", "code" : "dummy0" }
              ]
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .groupSelection,
                    attribute: .groupSelection(.init(
                        noLabel: true,
                        required: true,
                        entities: [
                            .init(type: .group, code: "dummy0", name: nil),
                            .init(type: .group, code: "dummy1", name: nil),
                        ],
                        defaultValue: [
                            .init(type: .group, code: "dummy0", name: nil)
                        ]
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test(arguments: [
        LinkProperty(protocol: "WEB", expectedLinkProtocol: .web, defaultValue: "https://example.com"),
        LinkProperty(protocol: "CALL", expectedLinkProtocol: .call, defaultValue: "080-1234-5678"),
        LinkProperty(protocol: "MAIL", expectedLinkProtocol: .mail, defaultValue: "dummy@org.com"),
    ])
    func response_link(_ linkProperty: LinkProperty) throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "LINK",
              "noLabel" : true,
              "required" : true,
              "protocol" : "\(linkProperty.protocol)",
              "minLength" : "",
              "maxLength" : "100",
              "unique" : true,
              "defaultValue" : "\(linkProperty.defaultValue)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .link,
                    attribute: .link(.init(
                        noLabel: true,
                        required: true,
                        linkProtocol: linkProperty.expectedLinkProtocol,
                        minLength: nil,
                        maxLength: 100,
                        unique: true,
                        defaultValue: linkProperty.defaultValue
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test(arguments: [
        LookupProperty(type: "NUMBER", expectedType: .number),
        LookupProperty(type: "SINGLE_LINE_TEXT", expectedType: .singleLineText),
    ])
    func response_lookup(_ lookupProperty: LookupProperty) throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "\(lookupProperty.type)",
              "noLabel" : true,
              "required" : true,
              "lookup" : {
                "relatedApp" : { "app" : "1", "code" : "" },
                "relatedKeyField" : "dummy",
                "fieldMappings" : [
                  { "field" : "dummy", "relatedField" : "related_dummy" }
                ],
                "lookupPickerFields" : ["dummy"],
                "filterCond" : "dummy = \\"1\\"",
                "sort" : "dummy desc"
              }
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: lookupProperty.expectedType,
                    attribute: .lookup(.init(
                        noLabel: true,
                        required: true,
                        lookup: .init(
                            relatedApp: .init(appID: 1, code: ""),
                            relatedKeyField: "dummy",
                            fieldMappings: [.init(field: "dummy", relatedField: "related_dummy")],
                            lookupPickerFields: ["dummy"],
                            filterCondition: "dummy = \"1\"",
                            sort: "dummy desc"
                        )
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_modifier() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "MODIFIER",
              "noLabel" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .modifier,
                    attribute: .modifier(.init(noLabel: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_multiLineText() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "MULTI_LINE_TEXT",
              "noLabel" : true,
              "required" : true,
              "defaultValue" : "dummy\\ndummy"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .multiLineText,
                    attribute: .multiLineText(.init(
                        noLabel: true,
                        required: true,
                        defaultValue: "dummy\ndummy"
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test(arguments: [
        NumberProperty(unitPosition: "BEFORE", expectedUnitPosition: .before),
        NumberProperty(unitPosition: "AFTER", expectedUnitPosition: .after),
    ])
    func response_number(_ numberProperty: NumberProperty) throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "NUMBER",
              "noLabel" : true,
              "required" : true,
              "minValue" : "-10",
              "maxValue" : "",
              "digit" : true,
              "unique" : true,
              "defaultValue" : "123.456",
              "displayScale" : "3",
              "unit" : "¥",
              "unitPosition" : "\(numberProperty.unitPosition)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .number,
                    attribute: .number(.init(
                        noLabel: true,
                        required: true,
                        minValue: -10,
                        maxValue: nil,
                        digit: true,
                        unique: true,
                        defaultValue: "123.456",
                        displayScale: 3,
                        unit: "¥",
                        unitPosition: numberProperty.expectedUnitPosition
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_organizationSelection() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "ORGANIZATION_SELECT",
              "noLabel" : true,
              "required" : true,
              "entities" : [
                { "type" : "ORGANIZATION", "code" : "dummy0" },
                { "type" : "ORGANIZATION", "code" : "dummy1" }
              ],
              "defaultValue" : [
                { "type" : "ORGANIZATION", "code" : "dummy0" }
              ]
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .organizationSelection,
                    attribute: .organizationSelection(.init(
                        noLabel: true,
                        required: true,
                        entities: [
                            .init(type: .organization, code: "dummy0", name: nil),
                            .init(type: .organization, code: "dummy1", name: nil),
                        ],
                        defaultValue: [
                            .init(type: .organization, code: "dummy0", name: nil)
                        ]
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test(arguments: [
        RadioButtonProperty(alignment: "HORIZONTAL", expectedAlignment: .horizontal),
        RadioButtonProperty(alignment: "VERTICAL", expectedAlignment: .vertical),
    ])
    func response_radioButton(_ radioButtonProperty: RadioButtonProperty) throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "RADIO_BUTTON",
              "noLabel" : true,
              "required" : true,
              "options" : {
                "dummy0" : { "label" : "dummy0", "index" : "0" },
                "dummy1" : { "label" : "dummy1", "index" : "1" }
              },
              "defaultValue" : "dummy0",
              "align" : "\(radioButtonProperty.alignment)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .radioButton,
                    attribute: .radioButton(.init(
                        noLabel: true,
                        required: true,
                        options: [
                            .init(label: "dummy0", index: 0),
                            .init(label: "dummy1", index: 1),
                        ],
                        defaultValue: "dummy0",
                        alignment: radioButtonProperty.expectedAlignment
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_recordNumber() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "RECORD_NUMBER",
              "noLabel" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .recordNumber,
                    attribute: .recordNumber(.init(noLabel: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_referenceTable() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "type" : "REFERENCE_TABLE",
              "code" : "dummy",
              "label" : "dummy",
              "noLabel" : true,
              "referenceTable" : {
                "relatedApp" : { "app" : "1", "code" : "" },
                "condition" : { "field" : "dummy", "relatedField" : "related_dummy" },
                "filterCond" : "dummy = \\"1\\"",
                "displayFields" : ["dummy"],
                "sort" : "dummy desc",
                "size" : "5"
              }
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .referenceTable,
                    attribute: .referenceTable(.init(
                        noLabel: true,
                        referenceTable: .init(
                            relatedApp: .init(appID: 1, code: ""),
                            condition: .init(field: "dummy", relatedField: "related_dummy"),
                            filterCondition: "dummy = \"1\"",
                            displayFields: ["dummy"],
                            sort: "dummy desc",
                            size: 5
                        )
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_richText() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "RICH_TEXT",
              "noLabel" : true,
              "required" : true,
              "defaultValue" : "<h1>dummy</h1>"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .richText,
                    attribute: .richText(.init(
                        noLabel: true,
                        required: true,
                        defaultValue: "<h1>dummy</h1>"
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_singleLineText() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "SINGLE_LINE_TEXT",
              "noLabel" : true,
              "required" : true,
              "minLength" : "",
              "maxLength" : "100",
              "expression" : "",
              "hideExpression" : true,
              "unique" : true,
              "defaultValue" : "dummy"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .singleLineText,
                    attribute: .singleLineText(.init(
                        noLabel: true,
                        required: true,
                        minLength: nil,
                        maxLength: 100,
                        expression: "",
                        hideExpression: true,
                        unique: true,
                        defaultValue: "dummy"
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_status() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "STATUS",
              "enabled" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .status,
                    attribute: .status(.init(enabled: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_statusAssignee() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "STATUS_ASSIGNEE",
              "enabled" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .statusAssignee,
                    attribute: .statusAssignee(.init(enabled: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_subtable() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "SUBTABLE",
              "noLabel" : true,
              "fields" : {
                "dummy0" : {
                  "code" : "dummy0",
                  "label" : "dummy0",
                  "type" : "NUMBER",
                  "noLabel" : true,
                  "required" : true,
                  "minValue" : "",
                  "maxValue" : "100",
                  "digit" : true,
                  "unique" : true,
                  "defaultValue" : "123.456",
                  "displayScale" : "3",
                  "unit" : "¥",
                  "unitPosition" : "BEFORE"
                },
                "dummy1" : {
                  "code" : "dummy1",
                  "label" : "dummy1",
                  "type" : "SINGLE_LINE_TEXT",
                  "noLabel" : true,
                  "required" : true,
                  "minLength" : "10",
                  "maxLength" : "",
                  "expression" : "",
                  "hideExpression" : true,
                  "unique" : true,
                  "defaultValue" : "dummy"
                }
              }
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .subtable,
                    attribute: .subtable(.init(
                        noLabel: true,
                        fields: [
                            .init(
                                code: "dummy0",
                                label: "dummy0",
                                type: .number,
                                attribute: .number(.init(
                                    noLabel: true,
                                    required: true,
                                    minValue: nil,
                                    maxValue: 100,
                                    digit: true,
                                    unique: true,
                                    defaultValue: "123.456",
                                    displayScale: 3,
                                    unit: "¥",
                                    unitPosition: .before
                                ))
                            ),
                            .init(
                                code: "dummy1",
                                label: "dummy1",
                                type: .singleLineText,
                                attribute: .singleLineText(.init(
                                    noLabel: true,
                                    required: true,
                                    minLength: 10,
                                    maxLength: nil,
                                    expression: "",
                                    hideExpression: true,
                                    unique: true,
                                    defaultValue: "dummy"
                                ))
                            )
                        ]
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_time() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "TIME",
              "noLabel" : true,
              "required" : true,
              "unique" : true,
              "defaultNowValue" : false,
              "defaultValue" : "00:00:00.000"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .time,
                    attribute: .time(.init(
                        noLabel: true,
                        required: true,
                        defaultNowValue: false,
                        defaultValue: .distantReferenceZero
                    ))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_updatedTime() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "UPDATED_TIME",
              "noLabel" : true
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .updatedTime,
                    attribute: .updatedTime(.init(noLabel: true))
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_userSelection() throws {
        let input = """
        {
          "properties" : {
            "dummy" : {
              "code" : "dummy",
              "label" : "dummy",
              "type" : "USER_SELECT",
              "noLabel" : true,
              "required" : true,
              "entities" : [
                { "type" : "USER", "code" : "user" },
                { "type" : "GROUP", "code" : "group" },
                { "type" : "ORGANIZATION", "code" : "organization" },
              ],
              "defaultValue" : [
                { "type" : "USER", "code" : "user" },
                { "type" : "FUNCTION", "code" : "LOGINUSER()" }
              ]
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual == .init(
            fields: [
                .init(
                    code: "dummy",
                    label: "dummy",
                    type: .userSelection,
                    attribute: .userSelection(.init(
                        noLabel: true,
                        required: true,
                        entities: [
                            .init(type: .user, code: "user", name: nil),
                            .init(type: .group, code: "group", name: nil),
                            .init(type: .organization, code: "organization", name: nil),
                        ],
                        defaultValue: [
                            .init(type: .user, code: "user", name: nil),
                            .init(type: .function, code: "LOGINUSER()", name: nil)
                        ]
                    ))
                )
            ],
            revision: 1
        ))
    }

    struct CalcProperty {
        var format: String
        var expectedFormat: CalcFormat
        var unitPosition: String
        var expectedUnitPosition: UnitPosition
    }

    struct CheckboxProperty {
        var alignment: String
        var expectedAlignment: FieldOptionAlignment
    }

    struct LinkProperty {
        var `protocol`: String
        var expectedLinkProtocol: LinkProtocol
        var defaultValue: String
    }

    struct LookupProperty {
        var type: String
        var expectedType: FieldType
    }

    struct NumberProperty {
        var unitPosition: String
        var expectedUnitPosition: UnitPosition
    }

    struct RadioButtonProperty {
        var alignment: String
        var expectedAlignment: FieldOptionAlignment
    }
}
