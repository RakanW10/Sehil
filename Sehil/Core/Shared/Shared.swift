//
//  Shared.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import Foundation
import Supabase

struct Shared{
    static let client = SupabaseClient(supabaseURL: Secret.apiUrl, supabaseKey: Secret.apiKey)
}
