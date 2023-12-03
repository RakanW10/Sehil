//
//  HomeView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

struct HomeView: View {
    @Binding var isDrawerOpened: Bool
    var body: some View {
        // NOTE: With out NavigationView it's not showing tool bar
        NavigationView {
            ScrollView {
                //TODO: HomeView
                Color.blue
                    .frame(height: 1000)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isDrawerOpened = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                }
                ToolbarItem(placement: .principal) {
                    MainLogo()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView(isDrawerOpened: .constant(false))
}
