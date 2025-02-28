import Foundation
import Testing

@testable import KintoneAPI

struct FetchRecordResponseTests {
    @Test
    func response_fields_empty() throws {
        let input = """
        {
          "record" : {
            "$id" : {
              "type" : "__ID__",
              "value" : "1"
            },
            "$revision" : {
              "type" : "__REVISION__",
              "value" : "1"
            }
          }
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(identity: .init(id: 1, revision: 1), fields: [])))
    }

    @Test
    func response_calc() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .calc("0"))
            ]
        )))
    }

    @Test
    func response_category() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .category(["dummy0", "dummy1"]))
            ]
        )))
    }

    @Test
    func response_checkBox() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .checkBox(["dummy0", "dummy1"]))
            ]
        )))
    }

    @Test
    func response_createdTime() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .createdTime(.distantPast))
            ]
        )))
    }

    @Test
    func response_creator() throws {
        let input = """
        {
          "record" : {
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
                "name" : "Dummy"
              }
            }
          }
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .creator(.init(type: .user, code: "dummy", name: "Dummy")))
            ]
        )))
    }

    @Test(arguments: [
        DateProperty(value: "null", expectedValue: nil),
        DateProperty(value: "\"0001-01-01\"", expectedValue: .distantPast),
    ])
    func response_date(_ dateProperty: DateProperty) throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .date(dateProperty.expectedValue))
            ]
        )))
    }

    @Test(arguments: [
        DateTimeProperty(value: "null", expectedValue: nil),
        DateTimeProperty(value: "\"0001-01-01T00:00:00Z\"", expectedValue: .distantPast),
    ])
    func response_dateTime(_ dateTimeProperty: DateTimeProperty) throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .dateTime(dateTimeProperty.expectedValue))
            ]
        )))
    }

    @Test(arguments: [
        DropDownProperty(value: "null", expectedValue: nil),
        DropDownProperty(value: "\"dummy\"", expectedValue: "dummy"),
    ])
    func response_dropDown(_ dropDownProperty: DropDownProperty) throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .dropDown(dropDownProperty.expectedValue))
            ]
        )))
    }

    @Test
    func response_file() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .file([.init(fileKey: "dummy", mimeType: "image/png", fileName: "dummy.png", fileSize: "100")]))
            ]
        )))
    }

    @Test
    func response_groupSelect() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .groupSelect([.init(type: .group, code: "dummy", name: "Dummy")]))
            ]
        )))
    }

    @Test
    func response_link() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .link("dummy"))
            ]
        )))
    }

    @Test
    func response_modifier() throws {
        let input = """
        {
          "record" : {
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
                "name" : "Dummy"
              }
            }
          }
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .modifier(.init(type: .user, code: "dummy", name: "Dummy")))
            ]
        )))
    }

    @Test
    func response_multiLineText() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .multiLineText("dummy\ndummy"))
            ]
        )))
    }

    @Test
    func response_multiSelect() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .multiSelect(["dummy0", "dummy1"]))
            ]
        )))
    }

    @Test
    func response_number() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .number("123.456"))
            ]
        )))
    }

    @Test
    func response_organizationSelect() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .organizationSelect([.init(type: .organization, code: "dummy", name: "Dummy")]))
            ]
        )))
    }

    @Test(arguments: [
        RadioButtonProperty(value: "null", expectedValue: nil),
        RadioButtonProperty(value: "\"dummy\"", expectedValue: "dummy"),
    ])
    func response_radioButton(_ radioButtonProperty: RadioButtonProperty) throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .radioButton(radioButtonProperty.expectedValue))
            ]
        )))
    }

    @Test
    func response_recordNumber() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .recordNumber("DUMMY-1"))
            ]
        )))
    }

    @Test
    func response_richText() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .richText("<h1>dummy</h1>"))
            ]
        )))
    }

    @Test
    func response_singleLineText() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .singleLineText("dummy"))
            ]
        )))
    }

    @Test
    func response_status() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .status("dummy"))
            ]
        )))
    }

    @Test
    func response_statusAssignee() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .statusAssignee([.init(type: .user, code: "dummy", name: "Dummy")]))
            ]
        )))
    }

    @Test
    func response_subtable() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .subtable([.init(id: 1, value: [
                    .init(code: "dummy0", value: .number("1234")),
                    .init(code: "dummy1", value: .singleLineText("dummy")),
                ])]))
            ]
        )))
    }

    @Test(arguments: [
        TimeProperty(value: "null", expectedValue: nil),
        TimeProperty(value: "\"00:00\"", expectedValue: .distantReference),
    ])
    func response_time(_ timeProperty: TimeProperty) throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .time(timeProperty.expectedValue))
            ]
        )))
    }

    @Test
    func response_updatedTime() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .updatedTime(.distantPast))
            ]
        )))
    }

    @Test
    func response_userSelect() throws {
        let input = """
        {
          "record" : {
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
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordResponse.self, from: data)
        #expect(actual == .init(record: .init(
            identity: .init(id: 1, revision: 1),
            fields: [
                .init(code: "dummy", value: .userSelect([.init(type: .user, code: "dummy", name: "Dummy")]))
            ]
        )))
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
