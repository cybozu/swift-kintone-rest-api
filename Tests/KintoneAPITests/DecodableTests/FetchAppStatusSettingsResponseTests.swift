import Foundation
import Testing

@testable import KintoneAPI

struct FetchAppStatusSettingsResponseTests {
    @Test
    func response_empty() throws {
        let input = """
        {
          "enable" : true,
          "states" : null,
          "actions" : null,
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppStatusSettingsResponse.self, from: data)
        #expect(actual == .init(enable: true, states: [], actions: [], revision: 1))
    }

    @Test
    func response_assignee_one() throws {
        let input = """
        {
          "enable" : true,
          "states" : {
            "dummy" : {
              "name" : "dummy",
              "index" : "1",
              "assignee" : {
                "type" : "ONE",
                "entities" : [
                  {
                    "entity" : {
                      "type" : "USER",
                      "code" : "dummy"
                    },
                    "includeSubs" : false
                  }
                ]
              }
            }
          },
          "actions" : null,
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppStatusSettingsResponse.self, from: data)
        #expect(actual == .init(
            enable: true,
            states: [
                .init(
                    name: "dummy",
                    index: 1,
                    assignee: .init(
                        type: .one,
                        entities: [
                            .init(type: .user, code: "dummy", includeSubs: false)
                        ]
                    )
                )
            ],
            actions: [],
            revision: 1
        ))
    }

    @Test
    func response_assignee_all() throws {
        let input = """
        {
          "enable" : true,
          "states" : {
            "dummy" : {
              "name" : "dummy",
              "index" : "1",
              "assignee" : {
                "type" : "ALL",
                "entities" : [
                  {
                    "entity" : {
                      "type" : "FIELD_ENTITY",
                      "code" : "dummy0"
                    },
                    "includeSubs" : false
                  },
                  {
                    "entity" : {
                      "type" : "CUSTOM_FIELD",
                      "code" : "dummy1"
                    },
                    "includeSubs" : false
                  }
                ]
              }
            }
          },
          "actions" : null,
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppStatusSettingsResponse.self, from: data)
        #expect(actual == .init(
            enable: true,
            states: [
                .init(
                    name: "dummy",
                    index: 1,
                    assignee: .init(
                        type: .all,
                        entities: [
                            .init(type: .fieldEntity, code: "dummy0", includeSubs: false),
                            .init(type: .customField, code: "dummy1", includeSubs: false),
                        ]
                    )
                )
            ],
            actions: [],
            revision: 1
        ))
    }

    @Test
    func response_assignee_any() throws {
        let input = """
        {
          "enable" : true,
          "states" : {
            "dummy" : {
              "name" : "dummy",
              "index" : "1",
              "assignee" : {
                "type" : "ANY",
                "entities" : [
                  {
                    "entity" : {
                      "type" : "GROUP",
                      "code" : "dummy0"
                    },
                    "includeSubs" : false
                  },
                  {
                    "entity" : {
                      "type" : "ORGANIZATION",
                      "code" : "dummy1"
                    },
                    "includeSubs" : false
                  },
                  {
                    "entity" : {
                      "type" : "CREATOR",
                      "code" : null
                    },
                    "includeSubs" : false
                  }
                ]
              }
            }
          },
          "actions" : null,
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppStatusSettingsResponse.self, from: data)
        #expect(actual == .init(
            enable: true,
            states: [
                .init(
                    name: "dummy",
                    index: 1,
                    assignee: .init(
                        type: .any,
                        entities: [
                            .init(type: .group, code: "dummy0", includeSubs: false),
                            .init(type: .organization, code: "dummy1", includeSubs: false),
                            .init(type: .creator, code: nil, includeSubs: false),
                        ]
                    )
                )
            ],
            actions: [],
            revision: 1
        ))
    }

    @Test
    func response_actions() throws {
        let input = """
        {
          "enable" : true,
          "states" : null,
          "actions" : [
            {
              "name" : "action1",
              "from" : "step1",
              "to" : "step2",
              "filterCond" : ""
            },
            {
              "name" : "action2",
              "from" : "step2",
              "to" : "step3",
              "filterCond" : "dummy = \\"1\\""
            }
          ],
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppStatusSettingsResponse.self, from: data)
        #expect(actual == .init(
            enable: true,
            states: [],
            actions: [
                .init(name: "action1", from: "step1", to: "step2", filterCondition: ""),
                .init(name: "action2", from: "step2", to: "step3", filterCondition: "dummy = \"1\""),
            ],
            revision: 1
        ))
    }
}
