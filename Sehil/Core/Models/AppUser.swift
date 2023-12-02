//
//  AppUser.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import Foundation

struct AppUser: Codable {
    let id: UUID
    let name: String
    let email: String
    let dateOfBirth: Date
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case dateOfBirth = "date_of_birth"
        case createdAt = "created_at"
    }

    init(id: UUID, name: String, email: String, dateOfBirth: String, createdAt: String) {
        self.id = id
        self.name = name
        self.email = email
        let dateFormatter = ISO8601DateFormatter()

        if let dateOfBirth = dateFormatter.date(from: dateOfBirth) {
            self.dateOfBirth = dateOfBirth
        } else {
            fatalError("Invalid date format for dateOfBirth")
        }

        if let createdAt = dateFormatter.date(from: createdAt) {
            self.createdAt = createdAt
        } else {
            fatalError("Invalid date format for createdAt")
        }
    }

    init(id: UUID, name: String, email: String, dateOfBirth: Date, createdAt: Date) {
        self.id = id
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.createdAt = createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)

        let dateFormatter = ISO8601DateFormatter()

        let dateOfBirthString = try container.decode(String.self, forKey: .dateOfBirth)

        if let dateOfBirth = dateFormatter.date(from: dateOfBirthString) {
            self.dateOfBirth = dateOfBirth
        } else {
            throw DecodingError.dataCorruptedError(forKey: .dateOfBirth, in: container, debugDescription: "Invalid date format for date_of_birth")
        }

        let createdAtString = try container.decode(String.self, forKey: .createdAt)

        if let createdAt = dateFormatter.date(from: createdAtString) {
            self.createdAt = createdAt
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Invalid date format for created_at")
        }
    }
}
