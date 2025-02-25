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
        #expect(actual == .init(apps: []))
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
              "createdAt" : "0001-01-01T00:00:00.000Z",
              "creator" : {
                "code" : "dummy",
                "name" : "Dummy"
              },
              "modifiedAt" : "0001-01-01T00:00:00.000Z",
              "modifier" : {
                "code" : "dummy",
                "name" : "Dummy"
              },
              "spaceId" : null,
              "threadId" : null
            }
          ]
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppsResponse.self, from: data)
        #expect(actual == .init(apps: [
            .init(
                appID: 1,
                code: "dummy",
                name: "dummy",
                description: "dummy",
                spaceID: nil,
                threadID: nil,
                createdAt: .distantPast,
                creator: .init(type: .user, code: "dummy", name: "Dummy"),
                modifiedAt: .distantPast,
                modifier: .init(type: .user, code: "dummy", name: "Dummy")
            )
        ]))
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
              "createdAt" : "0001-01-01T00:00:00.000Z",
              "creator" : {
                "code" : "dummy",
                "name" : "Dummy"
              },
              "modifiedAt" : "0001-01-01T00:00:00.000Z",
              "modifier" : {
                "code" : "dummy",
                "name" : "Dummy"
              },
              "spaceId" : "2",
              "threadId" : "3"
            }
          ]
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchAppsResponse.self, from: data)
        #expect(actual == .init(apps: [
            .init(
                appID: 1,
                code: "dummy",
                name: "dummy",
                description: "dummy",
                spaceID: 2,
                threadID: 3,
                createdAt: .distantPast,
                creator: .init(type: .user, code: "dummy", name: "Dummy"),
                modifiedAt: .distantPast,
                modifier: .init(type: .user, code: "dummy", name: "Dummy")
            )
        ]))
    }
}
