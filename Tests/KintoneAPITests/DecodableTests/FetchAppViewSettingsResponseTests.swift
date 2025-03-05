import Foundation
import Testing

@testable import KintoneAPI

struct FetchAppViewSettingsResponseTests {
    @Test
    func response_empty() throws {
        let input = """
        {
          "views" : {},
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppViewSettingsResponse.self, from: data)
        #expect(actual == .init(views: [], revision: 1))
    }

    @Test
    func response_list() throws {
        let input = """
        {
          "views" : {
            "dummy" : {
              "id" : "1",
              "name" : "dummy",
              "filterCond" : "",
              "sort" : "field0 asc",
              "index" : "0",
              "type" : "LIST",
              "fields" : ["field0", "field1"]
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppViewSettingsResponse.self, from: data)
        #expect(actual == .init(
            views: [
                .init(
                    id: 1,
                    name: "dummy",
                    filterCondition: "",
                    sort: "field0 asc",
                    index: 0,
                    type: .list,
                    attribute: .list(.init(fields: ["field0", "field1"])),
                    builtinType: nil
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_list_with_assignee() throws {
        let input = """
        {
          "views" : {
            "(Assigned to me)" : {
              "id" : "1",
              "name" : "(Assigned to me)",
              "filterCond" : "Assignee in (LOGINUSER())",
              "sort" : "field0 asc",
              "index" : "0",
              "type" : "LIST",
              "fields" : ["field0", "field1"],
              "builtinType" : "ASSIGNEE"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppViewSettingsResponse.self, from: data)
        #expect(actual == .init(
            views: [
                .init(
                    id: 1,
                    name: "(Assigned to me)",
                    filterCondition: "Assignee in (LOGINUSER())",
                    sort: "field0 asc",
                    index: 0,
                    type: .list,
                    attribute: .list(.init(fields: ["field0", "field1"])),
                    builtinType: .assignee
                )
            ],
            revision: 1
        ))
    }

    @Test
    func response_calendar() throws {
        let input = """
        {
          "views" : {
            "dummy" : {
              "id" : "1",
              "name" : "dummy",
              "filterCond" : "",
              "sort" : "field0 desc",
              "index" : "0",
              "type" : "CALENDAR",
              "title" : "field1",
              "date" : "field2"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppViewSettingsResponse.self, from: data)
        #expect(actual == .init(
            views: [
                .init(
                    id: 1,
                    name: "dummy",
                    filterCondition: "",
                    sort: "field0 desc",
                    index: 0,
                    type: .calendar,
                    attribute: .calendar(.init(titleField: "field1", dateField: "field2")),
                    builtinType: nil
                )
            ],
            revision: 1
        ))
    }

    @Test(arguments: [
        CustomProperty(device: "DESKTOP", expectedDevice: .desktop),
        CustomProperty(device: "ANY", expectedDevice: .any),
    ])
    func response_custom(_ customProperty: CustomProperty) throws {
        let input = """
        {
          "views" : {
            "dummy" : {
              "id" : "1",
              "name" : "dummy",
              "filterCond" : "field0 >= \\"1\\"",
              "sort" : "field0 desc",
              "index" : "0",
              "type" : "CUSTOM",
              "html" : "<div id=\\"customized-view\\"></div>",
              "pager" : false,
              "device" : "\(customProperty.device)"
            }
          },
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppViewSettingsResponse.self, from: data)
        #expect(actual == .init(
            views: [
                .init(
                    id: 1,
                    name: "dummy",
                    filterCondition: "field0 >= \"1\"",
                    sort: "field0 desc",
                    index: 0,
                    type: .custom,
                    attribute: .custom(.init(
                        html: "<div id=\"customized-view\"></div>",
                        pager: false,
                        device: customProperty.expectedDevice
                    )),
                    builtinType: nil
                )
            ],
            revision: 1
        ))
    }

    struct CustomProperty {
        var device: String
        var expectedDevice: Device
    }
}
