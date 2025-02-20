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
        #expect(actual.enable)
        #expect(actual.states.isEmpty)
        #expect(actual.actions.isEmpty)
        #expect(actual.revision == 1)
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
        #expect(actual.enable)
        #expect(actual.states.count == 1)
        let state = try #require(actual.states.first)
        #expect(state.name == "dummy")
        #expect(state.index == 1)
        #expect(state.assignee.type == .one)
        #expect(state.assignee.entities.count == 1)
        let entity = try #require(state.assignee.entities.first)
        #expect(entity.type == .user)
        #expect(entity.code == "dummy")
        #expect(entity.includeSubs == false)
        #expect(actual.actions.isEmpty)
        #expect(actual.revision == 1)
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
                      "code" : "dummy"
                    },
                    "includeSubs" : false
                  },
                  {
                    "entity" : {
                      "type" : "CUSTOM_FIELD",
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
        #expect(actual.enable)
        #expect(actual.states.count == 1)
        let state = try #require(actual.states.first)
        #expect(state.name == "dummy")
        #expect(state.index == 1)
        #expect(state.assignee.type == .all)
        #expect(state.assignee.entities.count == 2)
        let entity0 = try #require(state.assignee.entities[0])
        #expect(entity0.type == .fieldEntity)
        #expect(entity0.code == "dummy")
        #expect(entity0.includeSubs == false)
        let entity1 = try #require(state.assignee.entities[1])
        #expect(entity1.type == .customField)
        #expect(entity1.code == "dummy")
        #expect(entity1.includeSubs == false)
        #expect(actual.actions.isEmpty)
        #expect(actual.revision == 1)
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
                      "code" : "dummy"
                    },
                    "includeSubs" : false
                  },
                  {
                    "entity" : {
                      "type" : "ORGANIZATION",
                      "code" : "dummy"
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
        #expect(actual.enable)
        #expect(actual.states.count == 1)
        let state = try #require(actual.states.first)
        #expect(state.name == "dummy")
        #expect(state.index == 1)
        #expect(state.assignee.type == .any)
        #expect(state.assignee.entities.count == 3)
        let entity0 = try #require(state.assignee.entities[0])
        #expect(entity0.type == .group)
        #expect(entity0.code == "dummy")
        #expect(entity0.includeSubs == false)
        let entity1 = try #require(state.assignee.entities[1])
        #expect(entity1.type == .organization)
        #expect(entity1.code == "dummy")
        #expect(entity1.includeSubs == false)
        let entity2 = try #require(state.assignee.entities[2])
        #expect(entity2.type == .creator)
        #expect(entity2.code == nil)
        #expect(entity2.includeSubs == false)
        #expect(actual.actions.isEmpty)
        #expect(actual.revision == 1)
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
        #expect(actual.enable)
        #expect(actual.states.isEmpty)
        #expect(actual.actions.count == 2)
        let action0 = try #require(actual.actions[0])
        #expect(action0.name == "action1")
        #expect(action0.from == "step1")
        #expect(action0.to == "step2")
        #expect(action0.filterCondition == "")
        let action1 = try #require(actual.actions[1])
        #expect(action1.name == "action2")
        #expect(action1.from == "step2")
        #expect(action1.to == "step3")
        #expect(action1.filterCondition == "dummy = \"1\"")
        #expect(actual.revision == 1)
    }
}
