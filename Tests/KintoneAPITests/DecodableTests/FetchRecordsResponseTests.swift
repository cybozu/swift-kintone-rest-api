import Foundation
import Testing

@testable import KintoneAPI

struct FetchRecordsResponseTests {
    @Test
    func response_records_empty() throws {
        let input = """
        {
          "records" : [],
          "totalCount" : null
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.isEmpty)
    }

    @Test
    func response_fields_empty() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.isEmpty)
        #expect(actual.totalCount == 1)
    }

    @Test
    func response_calc() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "CALC",
                "value" : "0"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .calc(value) = field.value {
            #expect(value == "0")
        } else {
            Issue.record("value must be calc type.")
        }
    }

    @Test
    func response_category() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "CATEGORY",
                "value" : ["dummy0", "dummy1"]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .category(value) = field.value {
            #expect(value == ["dummy0", "dummy1"])
        } else {
            Issue.record("value must be category type.")
        }
    }

    @Test
    func response_checkBox() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "CHECK_BOX",
                "value" : ["dummy0", "dummy1"]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .checkBox(value) = field.value {
            #expect(value == ["dummy0", "dummy1"])
        } else {
            Issue.record("value must be check box type.")
        }
    }

    @Test
    func response_createdTime() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "CREATED_TIME",
                "value" : "0001-01-01T00:00:00Z"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .createdTime(value) = field.value {
            #expect(value == .distantPast)
        } else {
            Issue.record("value must be created time type.")
        }
    }

    @Test
    func response_creator() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "CREATOR",
                "value" : {
                  "code" : "dummy",
                  "name" : "dummy"
                }
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .creator(value) = field.value {
            #expect(value.code == "dummy")
            #expect(value.name == "dummy")
        } else {
            Issue.record("value must be creator type.")
        }
    }

    @Test(arguments: [
        DateProperty(value: "null", expectedValue: nil),
        DateProperty(value: "\"0001-01-01\"", expectedValue: .distantPast),
    ])
    func response_date(_ dateProperty: DateProperty) throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "DATE",
                "value" : \(dateProperty.value)
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .date(value) = field.value {
            #expect(value == dateProperty.expectedValue)
        } else {
            Issue.record("value must be date type.")
        }
    }

    @Test(arguments: [
        DateTimeProperty(value: "null", expectedValue: nil),
        DateTimeProperty(value: "\"0001-01-01T00:00:00Z\"", expectedValue: .distantPast),
    ])
    func response_dateTime(_ dateTimeProperty: DateTimeProperty) throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "DATETIME",
                "value" : \(dateTimeProperty.value)
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .dateTime(value) = field.value {
            #expect(value == dateTimeProperty.expectedValue)
        } else {
            Issue.record("value must be date time type.")
        }
    }

    @Test(arguments: [
        DropDownProperty(value: "null", expectedValue: nil),
        DropDownProperty(value: "\"dummy\"", expectedValue: "dummy"),
    ])
    func response_dropDown(_ dropDownProperty: DropDownProperty) throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "DROP_DOWN",
                "value" : \(dropDownProperty.value)
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .dropDown(value) = field.value {
            #expect(value == dropDownProperty.expectedValue)
        } else {
            Issue.record("value must be drop down type.")
        }
    }

    @Test
    func response_file() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "FILE",
                "value" : [
                  {
                    "fileKey" : "dummy",
                    "contentType" : "image/png",
                    "name" : "dummy.png",
                    "size" : "100"
                  }
                ]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .file(value) = field.value {
            #expect(value.count == 1)
            let file = try #require(value.first)
            #expect(file.fileKey == "dummy")
            #expect(file.mimeType == "image/png")
            #expect(file.fileName == "dummy.png")
            #expect(file.fileSize == "100")
        } else {
            Issue.record("value must be file type.")
        }
    }

    @Test
    func response_groupSelect() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "GROUP_SELECT",
                "value" : [
                  {
                    "code" : "dummy",
                    "name" : "Dummy"
                  }
                ]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .groupSelect(value) = field.value {
            #expect(value.count == 1)
            let entity = try #require(value.first)
            #expect(entity.type == .group)
            #expect(entity.code == "dummy")
            #expect(entity.name == "Dummy")
        } else {
            Issue.record("value must be group select type.")
        }
    }

    @Test
    func response_link() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "LINK",
                "value" : "dummy"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .link(value) = field.value {
            #expect(value == "dummy")
        } else {
            Issue.record("value must be link type.")
        }
    }

    @Test
    func response_modifier() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "MODIFIER",
                "value" : {
                  "code" : "dummy",
                  "name" : "dummy"
                }
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .modifier(value) = field.value {
            #expect(value.code == "dummy")
            #expect(value.name == "dummy")
        } else {
            Issue.record("value must be modifier type.")
        }
    }

    @Test
    func response_multiLineText() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "MULTI_LINE_TEXT",
                "value" : "dummy\\ndummy"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .multiLineText(value) = field.value {
            #expect(value == "dummy\ndummy")
        } else {
            Issue.record("value must be multi line text type.")
        }
    }

    @Test
    func response_multiSelect() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "MULTI_SELECT",
                "value" : ["dummy0", "dummy1"]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .multiSelect(value) = field.value {
            #expect(value == ["dummy0", "dummy1"])
        } else {
            Issue.record("value must be multi select type.")
        }
    }

    @Test
    func response_number() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "NUMBER",
                "value" : "123.456"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .number(value) = field.value {
            #expect(value == "123.456")
        } else {
            Issue.record("value must be number type.")
        }
    }

    @Test
    func response_organizationSelect() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "ORGANIZATION_SELECT",
                "value" : [
                  {
                    "code" : "dummy",
                    "name" : "Dummy"
                  }
                ]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .organizationSelect(value) = field.value {
            #expect(value.count == 1)
            let entity = try #require(value.first)
            #expect(entity.type == .organization)
            #expect(entity.code == "dummy")
            #expect(entity.name == "Dummy")
        } else {
            Issue.record("value must be group select type.")
        }
    }

    @Test(arguments: [
        RadioButtonProperty(value: "null", expectedValue: nil),
        RadioButtonProperty(value: "\"dummy\"", expectedValue: "dummy"),
    ])
    func response_radioButton(_ radioButtonProperty: RadioButtonProperty) throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "RADIO_BUTTON",
                "value" : \(radioButtonProperty.value)
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .radioButton(value) = field.value {
            #expect(value == radioButtonProperty.expectedValue)
        } else {
            Issue.record("value must be radio button type.")
        }
    }

    @Test
    func response_recordNumber() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "RECORD_NUMBER",
                "value" : "DUMMY-1"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .recordNumber(value) = field.value {
            #expect(value == "DUMMY-1")
        } else {
            Issue.record("value must be record number type.")
        }
    }

    @Test
    func response_richText() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "RICH_TEXT",
                "value" : "<h1>dummy</h1>"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .richText(value) = field.value {
            #expect(value == "<h1>dummy</h1>")
        } else {
            Issue.record("value must be record number type.")
        }
    }

    @Test
    func response_singleLineText() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "SINGLE_LINE_TEXT",
                "value" : "dummy"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .singleLineText(value) = field.value {
            #expect(value == "dummy")
        } else {
            Issue.record("value must be single line text type.")
        }
    }

    @Test
    func response_status() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "STATUS",
                "value" : "dummy"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .status(value) = field.value {
            #expect(value == "dummy")
        } else {
            Issue.record("value must be status type.")
        }
    }

    @Test
    func response_statusAssignee() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "STATUS_ASSIGNEE",
                "value" : [
                  {
                    "code" : "dummy",
                    "name" : "Dummy"
                  }
                ]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .statusAssignee(value) = field.value {
            #expect(value.count == 1)
            let entity = try #require(value.first)
            #expect(entity.type == .user)
            #expect(entity.code == "dummy")
            #expect(entity.name == "Dummy")
        } else {
            Issue.record("value must be status assignee type.")
        }
    }

    @Test
    func response_subTable() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "SUBTABLE",
                "value" : [
                  {
                    "id" : "1",
                    "value" : {
                      "dummy0" : { "type" : "NUMBER", "value" : "1234" },
                      "dummy1" : { "type" : "SINGLE_LINE_TEXT", "value" : "dummy" }
                    }
                  }
                ]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .subTable(value) = field.value {
            #expect(value.count == 1)
            let row = try #require(value.first)
            #expect(row.id == 1)
            let subFields = row.value.sorted { $0.code < $1.code }
            #expect(subFields.count == 2)
            #expect(subFields[0].code == "dummy0")
            if case let .number(numberValue) = subFields[0].value {
                #expect(numberValue == "1234")
            } else {
                Issue.record("numberValue must be number type.")
            }
            #expect(subFields[1].code == "dummy1")
            if case let .singleLineText(textValue) = subFields[1].value {
                #expect(textValue == "dummy")
            } else {
                Issue.record("textValue must be single line text type.")
            }
        } else {
            Issue.record("value must be status sub table type.")
        }
    }

    @Test(arguments: [
        TimeProperty(value: "null", expectedValue: nil),
        TimeProperty(value: "\"00:00\"", expectedValue: .distantReference),
    ])
    func response_time(_ timeProperty: TimeProperty) throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "TIME",
                "value" : \(timeProperty.value)
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .time(value) = field.value {
            #expect(value == timeProperty.expectedValue)
        } else {
            Issue.record("value must be time type.")
        }
    }

    @Test
    func response_updatedTime() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "UPDATED_TIME",
                "value" : "0001-01-01T00:00:00Z"
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .updatedTime(value) = field.value {
            #expect(value == .distantPast)
        } else {
            Issue.record("value must be updated time type.")
        }
    }

    @Test
    func response_userSelect() throws {
        let input = """
        {
          "records" : [
            {
              "$id" : {
                "type" : "__ID__",
                "value" : "1"
              },
              "$revision" : {
                "type" : "__REVISION__",
                "value" : "1"
              },
              "dummy" : {
                "type" : "USER_SELECT",
                "value" : [
                  {
                    "code" : "dummy",
                    "name" : "Dummy"
                  }
                ]
              }
            }
          ],
          "totalCount" : 1
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual.records.count == 1)
        let record = try #require(actual.records.first)
        #expect(record.identity.id == 1)
        #expect(record.identity.revision == 1)
        #expect(record.fields.count == 1)
        let field = try #require(record.fields.first)
        #expect(field.code == "dummy")
        if case let .userSelect(value) = field.value {
            #expect(value.count == 1)
            let entity = try #require(value.first)
            #expect(entity.type == .user)
            #expect(entity.code == "dummy")
            #expect(entity.name == "Dummy")
        } else {
            Issue.record("value must be group select type.")
        }
    }

    struct DateProperty {
        var value: String
        var expectedValue: Date?
    }

    struct DateTimeProperty {
        var value: String
        var expectedValue: Date?
    }

    struct DropDownProperty {
        var value: String
        var expectedValue: String?
    }

    struct RadioButtonProperty {
        var value: String
        var expectedValue: String?
    }

    struct TimeProperty {
        var value: String
        var expectedValue: Date?
    }
}
