import Foundation
import Testing

@testable import KintoneAPI

struct UpdateStatusResponseTests {
    @Test
    func response() throws {
        let input = """
        {
          "revision" : "1"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(UpdateStatusResponse.self, from: data)
        #expect(actual == .init(revision: 1))
    }
}
