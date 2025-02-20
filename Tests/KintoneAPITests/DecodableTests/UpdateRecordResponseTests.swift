import Foundation
import Testing

@testable import KintoneAPI

struct UpdateRecordResponseTests {
    @Test
    func response() throws {
        let input = """
        {
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(UpdateRecordResponse.self, from: data)
        #expect(actual.revision == 1)
    }
}
