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
        #expect(actual.fields.isEmpty)
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .calc)
        if case let .calc(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.expression == "ROUND(dummy)")
            #expect(attribute.hideExpression)
            #expect(attribute.format == calcProperty.expectedFormat)
            #expect(attribute.unit == "$")
            #expect(attribute.unitPosition == calcProperty.expectedUnitPosition)
        } else {
            Issue.record("attribute must be calc type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .category)
        if case let .category(attribute) = field.attribute {
            #expect(attribute.enabled)
        } else {
            Issue.record("attribute must be category type.")
        }
        #expect(actual.revision == 1)
    }

    @Test(arguments: [
        CheckBoxProperty(alignment: "HORIZONTAL", expectedAlignment: .horizontal),
        CheckBoxProperty(alignment: "VERTICAL", expectedAlignment: .vertical),
    ])
    func response_checkBox(_ checkBoxProperty: CheckBoxProperty) throws {
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
              "align" : "\(checkBoxProperty.alignment)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .checkBox)
        if case let .checkBox(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.options.count == 2)
            let option0 = try #require(attribute.options[0])
            #expect(option0.label == "dummy0")
            #expect(option0.index == 0)
            let option1 = try #require(attribute.options[1])
            #expect(option1.label == "dummy1")
            #expect(option1.index == 1)
            #expect(attribute.defaultValue == ["dummy0"])
            #expect(attribute.alignment == checkBoxProperty.expectedAlignment)
        } else {
            Issue.record("attribute must be check box type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .createdTime)
        if case let .createdTime(attribute) = field.attribute {
            #expect(attribute.noLabel)
        } else {
            Issue.record("attribute must be created time type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .creator)
        if case let .creator(attribute) = field.attribute {
            #expect(attribute.noLabel)
        } else {
            Issue.record("attribute must be creator type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .date)
        if case let .date(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.unique)
            #expect(attribute.defaultNowValue == false)
            #expect(attribute.defaultValue == .distantPast)
        } else {
            Issue.record("attribute must be date type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .dateTime)
        if case let .dateTime(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.unique)
            #expect(attribute.defaultNowValue == false)
            #expect(attribute.defaultValue == .distantPast)
        } else {
            Issue.record("attribute must be date time type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .dropDown)
        if case let .dropDown(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.options.count == 2)
            let option0 = try #require(attribute.options[0])
            #expect(option0.label == "dummy0")
            #expect(option0.index == 0)
            let option1 = try #require(attribute.options[1])
            #expect(option1.label == "dummy1")
            #expect(option1.index == 1)
            #expect(attribute.defaultValue == "dummy0")
        } else {
            Issue.record("attribute must be drop down type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .file)
        if case let .file(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.thumbnailSize == 150)
        } else {
            Issue.record("attribute must be file type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .group)
        if case let .group(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.openGroup)
        } else {
            Issue.record("attribute must be group type.")
        }
        #expect(actual.revision == 1)
    }

    @Test
    func response_groupSelect() throws {
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .groupSelect)
        if case let .groupSelect(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.entities.count == 2)
            let entity0 = try #require(attribute.entities[0])
            #expect(entity0.type == .group)
            #expect(entity0.code == "dummy0")
            let entity1 = try #require(attribute.entities[1])
            #expect(entity1.type == .group)
            #expect(entity1.code == "dummy1")
            #expect(attribute.defaultValue.count == 1)
            let defaultValue = try #require(attribute.defaultValue.first)
            #expect(defaultValue.type == .group)
            #expect(defaultValue.code == "dummy0")
        } else {
            Issue.record("attribute must be group select type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .link)
        if case let .link(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.linkProtocol == linkProperty.expectedLinkProtocol)
            #expect(attribute.minLength == nil)
            #expect(attribute.maxLength == 100)
            #expect(attribute.unique)
            #expect(attribute.defaultValue == linkProperty.defaultValue)
        } else {
            Issue.record("attribute must be link type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == lookupProperty.expectedType)
        if case let .lookup(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.lookup.relatedApp.appID == 1)
            #expect(attribute.lookup.relatedApp.code == "")
            #expect(attribute.lookup.relatedKeyField == "dummy")
            #expect(attribute.lookup.fieldMappings.count == 1)
            let fieldMapping = try #require(attribute.lookup.fieldMappings.first)
            #expect(fieldMapping.field == "dummy")
            #expect(fieldMapping.relatedField == "related_dummy")
            #expect(attribute.lookup.lookupPickerFields == ["dummy"])
            #expect(attribute.lookup.filterCondition == "dummy = \"1\"")
            #expect(attribute.lookup.sort == "dummy desc")
        } else {
            Issue.record("attribute must be lookup type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .modifier)
        if case let .modifier(attribute) = field.attribute {
            #expect(attribute.noLabel)
        } else {
            Issue.record("attribute must be modifier type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .multiLineText)
        if case let .multiLineText(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.defaultValue == "dummy\ndummy")
        } else {
            Issue.record("attribute must be multi line text type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .number)
        if case let .number(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.minValue == -10)
            #expect(attribute.maxValue == nil)
            #expect(attribute.digit)
            #expect(attribute.unique)
            #expect(attribute.defaultValue == "123.456")
            #expect(attribute.displayScale == 3)
            #expect(attribute.unit == "¥")
            #expect(attribute.unitPosition == numberProperty.expectedUnitPosition)
        } else {
            Issue.record("attribute must be number type.")
        }
        #expect(actual.revision == 1)
    }

    @Test
    func response_organizationSelect() throws {
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .organizationSelect)
        if case let .organizationSelect(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.entities.count == 2)
            let entity0 = try #require(attribute.entities[0])
            #expect(entity0.type == .organization)
            #expect(entity0.code == "dummy0")
            let entity1 = try #require(attribute.entities[1])
            #expect(entity1.type == .organization)
            #expect(entity1.code == "dummy1")
            #expect(attribute.defaultValue.count == 1)
            let defaultValue = try #require(attribute.defaultValue.first)
            #expect(defaultValue.type == .organization)
            #expect(defaultValue.code == "dummy0")
        } else {
            Issue.record("attribute must be organization select type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .radioButton)
        if case let .radioButton(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.options.count == 2)
            let option0 = try #require(attribute.options[0])
            #expect(option0.label == "dummy0")
            #expect(option0.index == 0)
            let option1 = try #require(attribute.options[1])
            #expect(option1.label == "dummy1")
            #expect(option1.index == 1)
            #expect(attribute.defaultValue == "dummy0")
            #expect(attribute.alignment == radioButtonProperty.expectedAlignment)
        } else {
            Issue.record("attribute must be radio button type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .recordNumber)
        if case let .recordNumber(attribute) = field.attribute {
            #expect(attribute.noLabel)
        } else {
            Issue.record("attribute must be record number type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .referenceTable)
        if case let .referenceTable(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.referenceTable.relatedApp.appID == 1)
            #expect(attribute.referenceTable.relatedApp.code == "")
            #expect(attribute.referenceTable.condition.field == "dummy")
            #expect(attribute.referenceTable.condition.relatedField == "related_dummy")
            #expect(attribute.referenceTable.filterCondition == "dummy = \"1\"")
            #expect(attribute.referenceTable.displayFields == ["dummy"])
            #expect(attribute.referenceTable.sort == "dummy desc")
            #expect(attribute.referenceTable.size == 5)
        } else {
            Issue.record("attribute must be reference table type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .richText)
        if case let .richText(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.defaultValue == "<h1>dummy</h1>")
        } else {
            Issue.record("attribute must be rich text type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .singleLineText)
        if case let .singleLineText(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.minLength == nil)
            #expect(attribute.maxLength == 100)
            #expect(attribute.expression == "")
            #expect(attribute.hideExpression)
            #expect(attribute.unique)
            #expect(attribute.defaultValue == "dummy")
        } else {
            Issue.record("attribute must be single line text type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .status)
        if case let .status(attribute) = field.attribute {
            #expect(attribute.enabled)
        } else {
            Issue.record("attribute must be status type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .statusAssignee)
        if case let .statusAssignee(attribute) = field.attribute {
            #expect(attribute.enabled)
        } else {
            Issue.record("attribute must be status assignee type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .subtable)
        if case let .subtable(attribute) = field.attribute {
            #expect(attribute.noLabel)
            let fields = attribute.fields.sorted { $0.code < $1.code }
            #expect(fields.count == 2)
            #expect(fields[0].code == "dummy0")
            #expect(fields[0].label == "dummy0")
            #expect(fields[0].type == .number)
            if case let .number(numberAttribute) = fields[0].attribute {
                #expect(numberAttribute.noLabel)
                #expect(numberAttribute.required)
                #expect(numberAttribute.minValue == nil)
                #expect(numberAttribute.maxValue == 100)
                #expect(numberAttribute.digit)
                #expect(numberAttribute.unique)
                #expect(numberAttribute.defaultValue == "123.456")
                #expect(numberAttribute.displayScale == 3)
                #expect(numberAttribute.unit == "¥")
                #expect(numberAttribute.unitPosition == .before)
            } else {
                Issue.record("numberAttribute must be number type.")
            }
            #expect(fields[1].code == "dummy1")
            #expect(fields[1].label == "dummy1")
            #expect(fields[1].type == .singleLineText)
            if case let .singleLineText(textAttribute) = fields[1].attribute {
                #expect(textAttribute.noLabel)
                #expect(textAttribute.required)
                #expect(textAttribute.minLength == 10)
                #expect(textAttribute.maxLength == nil)
                #expect(textAttribute.expression == "")
                #expect(textAttribute.hideExpression)
                #expect(textAttribute.unique)
                #expect(textAttribute.defaultValue == "dummy")
            } else {
                Issue.record("textAttribute must be single line text type.")
            }
        } else {
            Issue.record("attribute must be subtable type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .time)
        if case let .time(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.defaultNowValue == false)
            #expect(attribute.defaultValue == .distantReference)
        } else {
            Issue.record("attribute must be time type.")
        }
        #expect(actual.revision == 1)
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
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .updatedTime)
        if case let .updatedTime(attribute) = field.attribute {
            #expect(attribute.noLabel)
        } else {
            Issue.record("attribute must be updated time type.")
        }
        #expect(actual.revision == 1)
    }

    @Test
    func response_userSelect() throws {
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
                { "type" : "USER", "code" : "dummy0" },
                { "type" : "USER", "code" : "dummy1" }
              ],
              "defaultValue" : [
                { "type" : "USER", "code" : "dummy0" }
              ]
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        #expect(actual.fields.count == 1)
        let field = try #require(actual.fields.first)
        #expect(field.code == "dummy")
        #expect(field.label == "dummy")
        #expect(field.type == .userSelect)
        if case let .userSelect(attribute) = field.attribute {
            #expect(attribute.noLabel)
            #expect(attribute.required)
            #expect(attribute.entities.count == 2)
            let entity0 = try #require(attribute.entities[0])
            #expect(entity0.type == .user)
            #expect(entity0.code == "dummy0")
            let entity1 = try #require(attribute.entities[1])
            #expect(entity1.type == .user)
            #expect(entity1.code == "dummy1")
            #expect(attribute.defaultValue.count == 1)
            let defaultValue = try #require(attribute.defaultValue.first)
            #expect(defaultValue.type == .user)
            #expect(defaultValue.code == "dummy0")
        } else {
            Issue.record("attribute must be user select type.")
        }
        #expect(actual.revision == 1)
    }

    struct CalcProperty {
        var format: String
        var expectedFormat: CalcFormat
        var unitPosition: String
        var expectedUnitPosition: UnitPosition
    }

    struct CheckBoxProperty {
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
