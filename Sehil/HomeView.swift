//
//  HomeView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import Lottie
import SwiftUI
struct HomeView: View {
    @ObservedObject var vm: HomeViewModel
    @Binding var isDrawerOpened: Bool
    @State var isAddPostSheetPresented = false
    var body: some View {
        // NOTE: With out NavigationView it's not showing tool bar
        NavigationView {
            ZStack {
                ScrollView {
                    if vm.isHomeLoading {
                        LottieView(animation: .named("horse_animation"))
                            .resizable()
                            .playing(loopMode: .loop)
                            .scaledToFit()
                            .frame(width: 8 * 8)
                            .onAppear(perform: vm.fetchPosts)
                    } else {
                        ForEach(vm.showingPosts) { post in
                            PostDetails(post: post)
                        }
                    }
                }
                .refreshable {
                    vm.fetchPosts()
                }
                
                .padding(.horizontal, 8)

                // MARK: - Toolbar

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
                } //: ScrolleView
                .navigationBarTitleDisplayMode(.inline)

                // MARK: - Floating Action Button

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { isAddPostSheetPresented.toggle() }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 8 * 2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .padding(8 * 2)
                                .background(
                                    Circle()
                                        .fill(.blue)
                                )
                                .shadow(radius: 4)

                        })
                        .padding()
                    }
                }
            } //: ZStack

            // MARK: - Add Post Sheet

            .sheet(isPresented: $isAddPostSheetPresented, content: {
                VStack(alignment: .trailing) {
                    HStack {
                        Button(action: {
                            isAddPostSheetPresented = false
                        }, label: {
                            Text("Cancel")
                                .foregroundStyle(.gray)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                        })
                        Spacer()
                        Button(action: vm.addMainPost, label: {
                            Text("Post")
                                .foregroundStyle(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(.blue)
                                .clipShape(Capsule())

                        })
                    }
                    // TODO: make onTap on all space
                    TextField(text: $vm.postTextField) {
                        Text("Tell the world")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .padding()
                .presentationDetents([.large])

            })
        }
    }
}

#Preview {
    HomeView(
        vm: HomeViewModel(
            appUser: AppUser(
                id: UUID(uuidString: "23aaf66d-81e8-4b52-9ba5-80ff5d17e21a")!,
                name: "Rakan",
                email: "rakna",
                dateOfBirth: Date(),
                createdAt: Date())
        ),
        isDrawerOpened: .constant(false))
}
