import Foundation
import Testing

@testable import KintoneAPI

struct FetchAppsResponseTests {
    @Test
    func response_empty() throws {
        let input = """
        {
          "apps" : []
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppsResponse.self, from: data)
        #expect(actual.apps.isEmpty)
    }

    @Test
    func response_app_that_does_not_belong_to_space() throws {
        let input = """
        {
          "apps" : [
            {
              "appId" : "1",
              "code" : "dummy",
              "name" : "dummy",
              "description" : "dummy",
              "createdAt" : "1970-01-01T00:00:00.000Z",
              "creator" : {
                "code" : "dummy",
                "name" : "dummy"
              },
              "modifiedAt" : "1970-01-01T00:00:00.000Z",
              "modifier" : {
                "code" : "dummy",
                "name" : "dummy"
              },
              "spaceId" : null,
              "threadId" : null
            }
          ]
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppsResponse.self, from: data)
        #expect(actual.apps.count == 1)
        let app = try #require(actual.apps.first)
        #expect(app.appID == 1)
        #expect(app.code == "dummy")
        #expect(app.name == "dummy")
        #expect(app.description == "dummy")
        #expect(app.createdAt == Date(timeIntervalSince1970: 0))
        #expect(app.creator.code == "dummy")
        #expect(app.creator.name == "dummy")
        #expect(app.modifiedAt == Date(timeIntervalSince1970: 0))
        #expect(app.modifier.code == "dummy")
        #expect(app.modifier.name == "dummy")
        #expect(app.spaceID == nil)
        #expect(app.threadID == nil)
    }

    @Test
    func response_app_that_belongs_to_space() throws {
        let input = """
        {
          "apps" : [
            {
              "appId" : "1",
              "code" : "dummy",
              "name" : "dummy",
              "description" : "dummy",
              "createdAt" : "1970-01-01T00:00:00.000Z",
              "creator" : {
                "code" : "dummy",
                "name" : "dummy"
              },
              "modifiedAt" : "1970-01-01T00:00:00.000Z",
              "modifier" : {
                "code" : "dummy",
                "name" : "dummy"
              },
              "spaceId" : "2",
              "threadId" : "3"
            }
          ]
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppsResponse.self, from: data)
        #expect(actual.apps.count == 1)
        let app = try #require(actual.apps.first)
        #expect(app.appID == 1)
        #expect(app.code == "dummy")
        #expect(app.name == "dummy")
        #expect(app.description == "dummy")
        #expect(app.createdAt == Date(timeIntervalSince1970: 0))
        #expect(app.creator.code == "dummy")
        #expect(app.creator.name == "dummy")
        #expect(app.modifiedAt == Date(timeIntervalSince1970: 0))
        #expect(app.modifier.code == "dummy")
        #expect(app.modifier.name == "dummy")
        #expect(app.spaceID == 2)
        #expect(app.threadID == 3)
    }
}
