//
//  PostModel.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let id: UUID
    let commentToId: UUID?
    let authorId: UUID
    let authorName: String
    let content: String
    let numberOfReposts: Int
    let numberOfComments: Int
    let numberOfLikes: Int
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case commentToId = "comment_to_id"
        case authorId = "author_id"
        case authorName = "author_name"
        case content
        case numberOfReposts = "number_of_reposts"
        case numberOfComments = "number_of_comments"
        case numberOfLikes = "number_of_likes"
        case createdAt = "created_at"
    }

    init(id: UUID, commentToId: UUID?, authorId: UUID, authorName: String, content: String, numberOfReposts: Int, numberOfComments: Int, numberOfLikes: Int, createdAt: Date? = nil) {
        self.id = id
        self.commentToId = commentToId
        self.authorId = authorId
        self.authorName = authorName
        self.content = content
        self.numberOfReposts = numberOfReposts
        self.numberOfComments = numberOfComments
        self.numberOfLikes = numberOfLikes
        self.createdAt = createdAt
    }

    init(id: UUID, commentToId: UUID?, authorId: UUID, authorName: String, content: String, numberOfReposts: Int, numberOfComments: Int, numberOfLikes: Int, createdAt: String) {
        self.id = id
        self.commentToId = commentToId
        self.authorId = authorId
        self.authorName = authorName
        self.content = content
        self.numberOfReposts = numberOfReposts
        self.numberOfComments = numberOfComments
        self.numberOfLikes = numberOfLikes

        let dateFormatter = ISO8601DateFormatter()

        if let createdAt = dateFormatter.date(from: createdAt) {
            self.createdAt = createdAt
        } else {
            fatalError("Invalid date format for createdAt")
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        commentToId = try container.decodeIfPresent(UUID.self, forKey: .commentToId)
        authorId = try container.decode(UUID.self, forKey: .authorId)
        authorName = try container.decode(String.self, forKey: .authorName)
        content = try container.decode(String.self, forKey: .content)
        numberOfReposts = try container.decode(Int.self, forKey: .numberOfReposts)
        numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
        numberOfLikes = try container.decode(Int.self, forKey: .numberOfLikes)
        
    
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure the format is interpreted consistently
            
            do {
                let createdAtString = try container.decode(String.self, forKey: .createdAt)
                guard let createdAt = dateFormatter.date(from: createdAtString) else {
                    throw DecodingError.dataCorruptedError(
                        forKey: .createdAt,
                        in: container,
                        debugDescription: "Invalid date format for createdAt: \(createdAtString)"
                    )
                }
                self.createdAt = createdAt
            } catch {
                throw error
            }
    }
}
