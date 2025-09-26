import Foundation
import Testing

@testable import KintoneAPI

struct KintoneAPIErrorReasonDetailTests {
    @Test
    func detail_CB_NO02() throws {
        let input = """
        {
          "id" : "XXXXXXXXXX",
          "code" : "CB_NO02",
          "message" : "No privilege to proceed."
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(KintoneAPIError.Reason.Detail.self, from: data)
        #expect(actual == .init(
            id: "XXXXXXXXXX",
            code: "CB_NO02",
            message: "No privilege to proceed.",
            appendixErrors: []
        ))
    }

    @Test
    func detail_CB_VA01() throws {
        let input = """
        {
          "id" : "XXXXXXXXXX",
          "code" : "CB_VA01",
          "message" : "Missing or invalid input.",
          "errors" : {
            "record.Number.value" : { "messages" : ["The value must be 150 or less."] },
            "record.Text.value" : { "messages" : ["Required."] }
          }
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(KintoneAPIError.Reason.Detail.self, from: data)
        #expect(actual == .init(
            id: "XXXXXXXXXX",
            code: "CB_VA01",
            message: "Missing or invalid input.",
            appendixErrors: [
                .init(location: "record.Number.value", messages: ["The value must be 150 or less."]),
                .init(location: "record.Text.value", messages: ["Required."]),
            ]
        ))
    }

    @Test
    func detail_GAIA_CO02() throws {
        let input = """
        {
          "id": "XXXXXXXXXX",
          "code": "GAIA_CO02",
          "message": "The revision is not the latest. Someone may update a record."
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(KintoneAPIError.Reason.Detail.self, from: data)
        #expect(actual == .init(
            id: "XXXXXXXXXX",
            code: "GAIA_CO02",
            message: "The revision is not the latest. Someone may update a record.",
            appendixErrors: []
        ))
    }
}
