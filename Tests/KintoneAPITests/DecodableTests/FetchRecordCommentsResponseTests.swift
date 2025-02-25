import Foundation
import Testing

@testable import KintoneAPI

struct FetchRecordCommentsResponseTests {
    @Test
    func response_comments_empty() throws {
        let input = """
        {
          "comments" : [],
          "older" : false,
          "newer" : false
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordCommentsResponse.self, from: data)
        #expect(actual == .init(
            comments: [],
            older: false,
            newer: false
        ))
    }

    @Test
    func response_comments_without_mentions() throws {
        let input = """
        {
          "comments" : [
            {
              "id" : "1",
              "text" : "dummy\\ndummy\\ndummy",
              "createdAt" : "0001-01-01T00:00:00Z",
              "creator" : { "code" : "dummy", "name" : "Dummy" },
              "mentions" : []
            }
          ],
          "older" : true,
          "newer" : true
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordCommentsResponse.self, from: data)
        #expect(actual == .init(
            comments: [
                .init(
                    id: 1,
                    text: "dummy\ndummy\ndummy",
                    createdAt: .distantPast,
                    creator: .init(type: .user, code: "dummy", name: "Dummy"),
                    mentions: []
                )
            ],
            older: true,
            newer: true
        ))
    }

    @Test(arguments: [
        MentionProperty(type: "USER", expectedType: .user),
        MentionProperty(type: "GROUP", expectedType: .group),
        MentionProperty(type: "ORGANIZATION", expectedType: .organization),
    ])
    func response_comments_with_mentions(_ mentionProperty: MentionProperty) throws {
        let input = """
        {
          "comments" : [
            {
              "id" : "1",
              "text" : "user \\norganization \\ngroup \\ndummy",
              "createdAt" : "0001-01-01T00:00:00Z",
              "creator" : { "code" : "dummy", "name" : "Dummy" },
              "mentions" : [
                { "code" : "dummy", "type" : "\(mentionProperty.type)" }
              ]
            }
          ],
          "older" : true,
          "newer" : true
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordCommentsResponse.self, from: data)
        #expect(actual == .init(
            comments: [
                .init(
                    id: 1,
                    text: "user \norganization \ngroup \ndummy",
                    createdAt: .distantPast,
                    creator: .init(type: .user, code: "dummy", name: "Dummy"),
                    mentions: [
                        .init(type: mentionProperty.expectedType, code: "dummy", name: nil)
                    ]
                )
            ],
            older: true,
            newer: true
        ))
    }

    struct MentionProperty {
        var type: String
        var expectedType: EntityType
    }
}
