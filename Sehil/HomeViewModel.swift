//
//  HomeViewModel.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var showingPosts: [PostModel] = []
    @Published var isHomeLoading: Bool = true
    @Published var postTextField: String = ""
    let appUser: AppUser?
    let databaseApi: DatabaseApiProtocol = DatabaseApi(client: Shared.client)

    init(appUser: AppUser?) {
        self.appUser = appUser
    }

    func fetchPosts(){
        isHomeLoading = true
        Task {
            do {
                let posts = try await databaseApi.fetchPosts()
                DispatchQueue.main.async {
                    self.showingPosts = posts
                    self.isHomeLoading = false
                }
            }
            catch{
                print("HomeViewModel-fetchPosts: \(error)")
            }
        }
    }
    
    func addMainPost() {
        if let appUser = self.appUser {
            let tempPost = PostModel(
                id: UUID(),
                commentToId: nil,
                authorId: appUser.id,
                authorName: appUser.name,
                content: postTextField,
                numberOfReposts: 0,
                numberOfComments: 0,
                numberOfLikes: 0
            )
            
            Task {
                do {
                    try await databaseApi.addNewPost(post: tempPost)
                } catch {
                    print("HomeViewModel-addMainPost: \(error)")
                }
            }
        }
    }
    
}
