import Foundation
import Testing

@testable import KintoneAPI

struct SubmitRecordResponseTests {
    @Test
    func response() throws {
        let input = """
        {
          "id" : "0",
          "revision" : "0"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(SubmitRecordResponse.self, from: data)
        #expect(actual.recordIdentity.id == 0)
        #expect(actual.recordIdentity.revision == 0)
    }
}
