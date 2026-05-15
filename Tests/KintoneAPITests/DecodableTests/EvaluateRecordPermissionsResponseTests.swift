import Foundation
import Testing

@testable import KintoneAPI

struct EvaluateRecordPermissionsResponseTests {
    @Test
    func response_empty() throws {
        let input = """
        {
          "rights" : []
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(EvaluateRecordPermissionsResponse.self, from: data)
        #expect(actual == .init(recordPermissionChunks: []))
    }

    @Test
    func response_full() throws {
        let input = """
        {
          "rights" : [
            {
              "id" : "1",
              "record" : {
                "viewable" : true,
                "editable" : true,
                "deletable" : false
              },
              "fields": {
                "dummy": {
                  "viewable": true,
                  "editable": false
                }
              }
            }
          ]
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(EvaluateRecordPermissionsResponse.self, from: data)
        #expect(actual == .init(recordPermissionChunks: [
            .init(
                recordPermission: .init(
                    id: 1,
                    viewable: true,
                    editable: true,
                    deletable: false
                ),
                fieldPermissions: [
                    .init(
                        code: "dummy",
                        viewable: true,
                        editable: false
                    )
                ]
            )
        ]))
    }
}
