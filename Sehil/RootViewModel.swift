//
//  RootViewModel.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import Foundation

class RootViewModel: ObservableObject{
    @Published var isDrawerOpened = false
    let appUser: AppUser?
    
    init(appUser: AppUser?) {
        self.appUser = appUser
    }
}
