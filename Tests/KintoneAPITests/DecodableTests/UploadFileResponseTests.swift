import Foundation
import Testing

@testable import KintoneAPI

struct UploadFileResponseTests {
    @Test
    func response() throws {
        let input = """
        {
          "fileKey" : "dummy"
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(UploadFileResponse.self, from: data)
        #expect(actual.fileKey == "dummy")
    }
}
