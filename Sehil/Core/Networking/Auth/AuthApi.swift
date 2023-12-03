//
//  SignUpAPI.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import Foundation
import Supabase

enum AuthErrors: Error {
    case signUpError
    case signInError
}

protocol AuthApiProtocol {
    func signUp(email: String, password: String) async throws -> UUID
    func signIn(email: String, password: String) async throws -> UUID
    func isEmailTaken(email: String) async -> Bool
}

class AuthApi: AuthApiProtocol {
    let client: SupabaseClient

    init(client: SupabaseClient) {
        self.client = client
    }

    func signUp(email: String, password: String) async throws -> UUID {
        do {
            let authResponse = try await client.auth.signUp(email: email, password: password)
            return (authResponse.session?.user.id)!
        } catch {
            print("AuthApi-signUp: \(error)")
            throw AuthErrors.signUpError
        }
    }

    func signIn(email: String, password: String) async throws -> UUID {
        do {
            let session = try await client.auth.signIn(email: email, password: password)
            return session.user.id
        } catch {
            print("AuthApi-signIn: \(error)")
            throw AuthErrors.signInError
        }
    }

    func isEmailTaken(email: String) async -> Bool {
        do {
            let response = try await client.database.from("users").select().eq("email", value: email.lowercased()).execute()
            let data = try JSONDecoder().decode([AppUser].self, from: response.data)
            if !data.isEmpty {
                return true
            }
        } catch {
            print("AuthApi-isEmailTaken:", error)
        }
        return false
    }
}
