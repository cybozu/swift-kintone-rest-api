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
        #expect(actual.comments.isEmpty)
        #expect(actual.older == false)
        #expect(actual.newer == false)
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
              "creator" : { "code" : "dummy", "name" : "dummy" },
              "mentions" : []
            }
          ],
          "older" : true,
          "newer" : true
        }
        """
        let data = try #require(input.data(using: .utf8))
        let actual = try JSONDecoder().decode(FetchRecordCommentsResponse.self, from: data)
        #expect(actual.comments.count == 1)
        let comment = try #require(actual.comments.first)
        #expect(comment.id == 1)
        #expect(comment.text == "dummy\ndummy\ndummy")
        #expect(comment.createdAt == .distantPast)
        #expect(comment.creator.code == "dummy")
        #expect(comment.creator.name == "dummy")
        #expect(comment.mentions.isEmpty)
        #expect(actual.older)
        #expect(actual.newer)
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
              "creator" : { "code" : "dummy", "name" : "dummy" },
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
        #expect(actual.comments.count == 1)
        let comment = try #require(actual.comments.first)
        #expect(comment.id == 1)
        #expect(comment.text == "user \norganization \ngroup \ndummy")
        #expect(comment.createdAt == .distantPast)
        #expect(comment.creator.code == "dummy")
        #expect(comment.creator.name == "dummy")
        #expect(comment.mentions.count == 1)
        let mention = try #require(comment.mentions.first)
        #expect(mention.code == "dummy")
        #expect(mention.type == mentionProperty.expectedType)
        #expect(actual.older)
        #expect(actual.newer)
    }

    struct MentionProperty {
        var type: String
        var expectedType: EntityType
    }
}
