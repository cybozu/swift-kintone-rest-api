import Foundation
import Testing

@testable import KintoneAPI

struct UpdateRecordRequestTests {
    @Test
    func request_empty_record() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {

          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_empty_record_without_revision() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0),
            record: .init(fields: [])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {

          }
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_checkBox() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .checkBox(["dummy"]))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                "dummy"
              ]
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_date() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .date(Date(timeIntervalSince1970: 0)))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "1970-01-01"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_dateTime() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .dateTime(Date(timeIntervalSince1970: 0)))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "1970-01-01T00:00:00Z"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_dropDown() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .dropDown("dummy"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "dummy"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_file() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
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
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                {
                  "fileKey" : "dummy"
                }
              ]
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_groupSelect() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .groupSelect([.init(type: .group, code: "dummy")]))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                {
                  "code" : "dummy",
                  "type" : "GROUP"
                }
              ]
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_link() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .link("https://example.com"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "https:\\/\\/example.com"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_multiLineText() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .multiLineText("dummy\ndummy"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "dummy\\ndummy"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_multiSelect() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .multiSelect(["dummy1", "dummy2"]))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                "dummy1",
                "dummy2"
              ]
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_number() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .number("123.456"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "123.456"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_organizationSelect() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .organizationSelect([.init(type: .organization, code: "dummy")]))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                {
                  "code" : "dummy",
                  "type" : "ORGANIZATION"
                }
              ]
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_radioButton() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .radioButton("dummy"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "dummy"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_richText() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .richText("<h1>dummy</h1>"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "<h1>dummy<\\/h1>"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_singleLineText() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .singleLineText("dummy"))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "dummy"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_time() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .time(Date(timeIntervalSince1970: 0)))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : "00:00"
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_userSelect() throws {
        let sut = UpdateRecordRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            record: .init(fields: [
                .init(code: "dummy", value: .userSelect([.init(type: .user, code: "dummy")]))
            ])
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "id" : 0,
          "record" : {
            "dummy" : {
              "value" : [
                {
                  "code" : "dummy",
                  "type" : "USER"
                }
              ]
            }
          },
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }
}
