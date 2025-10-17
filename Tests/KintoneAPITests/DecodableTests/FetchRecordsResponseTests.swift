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
        #expect(actual == .init(records: [], totalCount: nil))
    }

    @Test
    func response_records_empty_object() async throws {
        let input = """
        {
          "records" : [{}],
          "totalCount" : null
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(records: [], totalCount: nil))
    }

    @Test
    func response_records_empty_objects() async throws {
        let input = """
        {
          "records" : [{}, {}, {}, {}, {}, {}],
          "totalCount" : null
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(records: [], totalCount: nil))
    }

    @Test
    func response_identifier() throws {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: .init(id: 1, revision: 1),
                    fields: [
                        .init(code: "$id", value: .id(1)),
                        .init(code: "$revision", value: .revision(1)),
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_calc() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "CALC",
                "value" : "0"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .calc("0"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_category() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "CATEGORY",
                "value" : ["dummy0", "dummy1"]
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .category(["dummy0", "dummy1"]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_checkbox() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "CHECK_BOX",
                "value" : ["dummy0", "dummy1"]
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .checkbox(["dummy0", "dummy1"]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_createdTime() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "CREATED_TIME",
                "value" : "0001-01-01T00:00:00Z"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .createdTime(.distantPast))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_creator() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "CREATOR",
                "value" : {
                  "code" : "dummy",
                  "name" : "Dummy"
                }
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .creator(.init(type: .user, code: "dummy", name: "Dummy")))
                    ]
                )
            ],
            totalCount: 1
        ))
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
              "dummy" : {
                "type" : "DATE",
                "value" : \(dateProperty.value)
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .date(dateProperty.expectedValue))
                    ]
                )
            ],
            totalCount: 1
        ))
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
              "dummy" : {
                "type" : "DATETIME",
                "value" : \(dateTimeProperty.value)
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .dateTime(dateTimeProperty.expectedValue))
                    ]
                )
            ],
            totalCount: 1
        ))
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
              "dummy" : {
                "type" : "DROP_DOWN",
                "value" : \(dropDownProperty.value)
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .dropDown(dropDownProperty.expectedValue))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_file() throws {
        let input = """
        {
          "records" : [
            {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .file([.init(fileKey: "dummy", mimeType: "image/png", fileName: "dummy.png", fileSize: "100")]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_groupSelection() throws {
        let input = """
        {
          "records" : [
            {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .groupSelection([.init(type: .group, code: "dummy", name: "Dummy")]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_link() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "LINK",
                "value" : "dummy"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .link("dummy"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_modifier() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "MODIFIER",
                "value" : {
                  "code" : "dummy",
                  "name" : "Dummy"
                }
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .modifier(.init(type: .user, code: "dummy", name: "Dummy")))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_multiLineText() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "MULTI_LINE_TEXT",
                "value" : "dummy\\ndummy"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .multiLineText("dummy\ndummy"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_multiSelection() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "MULTI_SELECT",
                "value" : ["dummy0", "dummy1"]
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .multiSelection(["dummy0", "dummy1"]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_number() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "NUMBER",
                "value" : "123.456"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .number("123.456"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_organizationSelection() throws {
        let input = """
        {
          "records" : [
            {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .organizationSelection([.init(type: .organization, code: "dummy", name: "Dummy")]))
                    ]
                )
            ],
            totalCount: 1
        ))
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
              "dummy" : {
                "type" : "RADIO_BUTTON",
                "value" : \(radioButtonProperty.value)
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .radioButton(radioButtonProperty.expectedValue))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_recordNumber() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "RECORD_NUMBER",
                "value" : "DUMMY-1"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .recordNumber("DUMMY-1"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_richText() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "RICH_TEXT",
                "value" : "<h1>dummy</h1>"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .richText("<h1>dummy</h1>"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_singleLineText() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "SINGLE_LINE_TEXT",
                "value" : "dummy"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .singleLineText("dummy"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_status() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "STATUS",
                "value" : "dummy"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .status("dummy"))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_statusAssignee() throws {
        let input = """
        {
          "records" : [
            {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .statusAssignee([.init(type: .user, code: "dummy", name: "Dummy")]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_subtable() throws {
        let input = """
        {
          "records" : [
            {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .subtable([.init(id: 1, value: [
                            .init(code: "dummy0", value: .number("1234")),
                            .init(code: "dummy1", value: .singleLineText("dummy")),
                        ])]))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test(arguments: [
        TimeProperty(value: "null", expectedValue: nil),
        TimeProperty(value: "\"00:00\"", expectedValue: .distantReferenceZero),
    ])
    func response_time(_ timeProperty: TimeProperty) throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "TIME",
                "value" : \(timeProperty.value)
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .time(timeProperty.expectedValue))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_updatedTime() throws {
        let input = """
        {
          "records" : [
            {
              "dummy" : {
                "type" : "UPDATED_TIME",
                "value" : "0001-01-01T00:00:00Z"
              }
            }
          ],
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .updatedTime(.distantPast))
                    ]
                )
            ],
            totalCount: 1
        ))
    }

    @Test
    func response_userSelection() throws {
        let input = """
        {
          "records" : [
            {
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
          "totalCount" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        #expect(actual == .init(
            records: [
                .init(
                    identity: nil,
                    fields: [
                        .init(code: "dummy", value: .userSelection([.init(type: .user, code: "dummy", name: "Dummy")]))
                    ]
                )
            ],
            totalCount: 1
        ))
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
