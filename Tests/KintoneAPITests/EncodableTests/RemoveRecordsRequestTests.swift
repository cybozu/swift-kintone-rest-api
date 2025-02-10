import Foundation
import Testing

@testable import KintoneAPI

struct RemoveRecordsRequestTests {
    @Test
    func request_empty_record_identities() throws {
        let sut = RemoveRecordsRequest(
            appID: 0,
            recordIdentities: []
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "ids" : [

          ],
          "revisions" : [

          ]
        }
        """
        #expect(actual == expected)
    }

    @Test
    func request_full_record_identities() throws {
        let sut = RemoveRecordsRequest(
            appID: 0,
            recordIdentities: [.init(id: 0), .init(id: 1, revision: 0)]
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(sut)
        let actual = try #require(String(data: data, encoding: .utf8))
        let expected = """
        {
          "app" : 0,
          "ids" : [
            0,
            1
          ],
          "revisions" : [
            -1,
            0
          ]
        }
        """
        #expect(actual == expected)
    }
}
