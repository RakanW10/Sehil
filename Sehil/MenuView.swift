//
//  MenuView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var vm: RootViewModel
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            Text("Menu")
        }
    }
}
