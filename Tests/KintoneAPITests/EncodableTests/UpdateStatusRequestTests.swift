import Foundation
import Testing

@testable import KintoneAPI

struct UpdateStatusRequestTests {
    @Test
    func request_full_properties() throws {
        let sut = UpdateStatusRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            actionName: "dummy",
            assignee: "dummy"
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "action" : "dummy",
          "app" : 0,
          "assignee" : "dummy",
          "id" : 0,
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_without_revision() throws {
        let sut = UpdateStatusRequest(
            appID: 0,
            recordIdentity: .init(id: 0),
            actionName: "dummy",
            assignee: "dummy"
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "action" : "dummy",
          "app" : 0,
          "assignee" : "dummy",
          "id" : 0
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_without_assignee() throws {
        let sut = UpdateStatusRequest(
            appID: 0,
            recordIdentity: .init(id: 0, revision: 0),
            actionName: "dummy"
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "action" : "dummy",
          "app" : 0,
          "id" : 0,
          "revision" : 0
        }
        """
        #expect(actual == expected)
    }
}
