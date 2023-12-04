//
//  RootView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var vm: RootViewModel
    var body: some View {
        GeometryReader { proxy in
            DrawerView(
                isOpened: $vm.isDrawerOpened,

                // MARK: - Side Menu

                menu: {
                    MenuView(vm: vm)
                        .frame(width: proxy.size.width * 0.8)
                        .gesture(DragGesture(minimumDistance: 60)
                            .onChanged { value in
                                if value.location.x < value.startLocation.x {
                                    vm.isDrawerOpened = false
                                }
                            }
                        )
                },

                // MARK: - Main Content
                
                content: {
                    TabView {
                        HomeView(
                            vm: HomeViewModel(appUser: vm.appUser)
                            , isDrawerOpened: $vm.isDrawerOpened)
                            .tabItem {
                                Image(systemName: "house")
                            }

                        Text("SearchView")
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                            }
                    }
                    .tint(Color(.primary))
                }
            )
        }
        .navigationBarBackButtonHidden()
    }
}
