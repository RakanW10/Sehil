//
//  DatabaseApi.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import Foundation
import Supabase

protocol DatabaseApiProtocol{
    func addNewUser(user: AppUser) async throws
}


class DatabaseApi: DatabaseApiProtocol{
    let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func addNewUser(user: AppUser) async throws {
        do{
            try await client.database.from("users").insert(user).execute()
        }
        catch{
            print("DatabaseApi-addNewUser: \(error)")
            throw error
        }
    }
}
