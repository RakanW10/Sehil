//
//  DatabaseApi.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import Foundation
import Supabase

enum DatabaseError: Error {
    case NotCreatedError
    case FetchError
}

protocol DatabaseApiProtocol {
    func addNewUser(user: AppUser) async throws
    func getUser(userId: UUID) async throws -> AppUser
    func fetchPosts() async throws -> [PostModel]
    func addNewPost(post: PostModel) async throws
}

class DatabaseApi: DatabaseApiProtocol {
    let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }

    func addNewUser(user: AppUser) async throws {
        do {
            try await client.database.from("users").insert(user).execute()
        } catch {
            print("DatabaseApi-addNewUser: \(error)")
            throw error
        }
    }
    
    func getUser(userId: UUID) async throws -> AppUser{
        do{
            let userData = try await client.database.from("users").select().eq("id", value: userId).execute()
            return try JSONDecoder().decode([AppUser].self, from: userData.data)[0]
        }catch{
            print("DatabaseApi-getUser: \(error)")
            throw error
        }
    }

    func fetchPosts() async throws -> [PostModel] {
        var request = URLRequest(url: URL(string: "https://jcyohxitueuubwgwitwq.supabase.co/rest/v1/post?select=*")!, timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpjeW9oeGl0dWV1dWJ3Z3dpdHdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MTY2MTYsImV4cCI6MjAxNzA5MjYxNn0.knAp1njTRqy1TvIjz9XchsLcMNoCaGFJuxzveLKSoD0", forHTTPHeaderField: "apikey")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpjeW9oeGl0dWV1dWJ3Z3dpdHdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MTY2MTYsImV4cCI6MjAxNzA5MjYxNn0.knAp1njTRqy1TvIjz9XchsLcMNoCaGFJuxzveLKSoD0", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return try JSONDecoder().decode([PostModel].self, from: data)
                } else {
                    print("DatabaseApi-addNewPost: statusCode not 201. statusCode is [\(httpResponse.statusCode)]")
                    throw DatabaseError.NotCreatedError
                }
            } else {
                print("DatabaseApi-fetchPosts: HttpResponse cannot casted")
                throw DatabaseError.FetchError
            }
        } catch {
            print("DatabaseApi-fetchPosts: \(error)")
            throw error
        }
    }

    func addNewPost(post: PostModel) async throws {
        var request = URLRequest(url: URL(string: "https://jcyohxitueuubwgwitwq.supabase.co/rest/v1/post")!, timeoutInterval: Double.infinity)
        request.addValue(
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpjeW9oeGl0dWV1dWJ3Z3dpdHdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MTY2MTYsImV4cCI6MjAxNzA5MjYxNn0.knAp1njTRqy1TvIjz9XchsLcMNoCaGFJuxzveLKSoD0",
            forHTTPHeaderField: "apikey"
        )
        request.addValue(
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpjeW9oeGl0dWV1dWJ3Z3dpdHdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MTY2MTYsImV4cCI6MjAxNzA5MjYxNn0.knAp1njTRqy1TvIjz9XchsLcMNoCaGFJuxzveLKSoD0",
            forHTTPHeaderField: "Authorization"
        )
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("return=minimal", forHTTPHeaderField: "Prefer")
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONEncoder().encode(post)
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 201 {
                    print("DatabaseApi-addNewPost: statusCode not 201. statusCode is [\(httpResponse.statusCode)]")

                    throw DatabaseError.NotCreatedError
                }
            }
        } catch {
            print("DatabaseApi-addNewPost: \(error)")
            throw error
        }
    }
}
