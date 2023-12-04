//
//  PostDetails.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

struct PostDetails: View {
    let post: PostModel
    var body: some View {
        VStack {
            Divider()
            HStack(alignment: .top, spacing: 16) {
                // MARK: - Author image

                VStack {
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D")!) { phase in
                        switch phase {
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 8 * 8, height: 8 * 8)
                                .clipShape(Circle())
                        case .failure:
                            Circle()
                                .fill(.gray)
                                .scaledToFit()
                                .frame(width: 8 * 8, height: 8 * 8)
                                .clipShape(Circle())
                                .overlay {
                                    Image(systemName: "exclamationmark.triangle")
                                }
                        case .empty:
                            Circle()
                                .fill(.gray)
                                .scaledToFit()
                                .frame(width: 8 * 8, height: 8 * 8)
                                .clipShape(Circle())
                                .overlay {
                                    ProgressView()
                                        .tint(.white)
                                }
                        }
                    }
                } //: VStack

                VStack(alignment: .leading) {
                    // MARK: - Upper Infos

                    HStack(alignment: .firstTextBaseline) {
                        Text(post.authorName)
                            .bold()
                        if let postDate = post.createdAt {
                            Text(FormatHelpers.calculateTimeDifference(from: postDate))
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                    }
                    Text(post.content)
                        .lineLimit(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()

                    // MARK: - Post Quick Actions

                    HStack(alignment: .lastTextBaseline, spacing: 16) {
                        // MARK: - Repost

                        HStack(spacing: 4) {
                            Image(systemName: "arrow.2.squarepath")
                                .frame(width: 16)
                                .fontWeight(.semibold)
                            Text(post.numberOfReposts.description)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.green)

                        // MARK: - Like

                        HStack(spacing: 4) {
                            Image(systemName: "heart")
                                .frame(width: 16)
                                .fontWeight(.semibold)
                            Text(post.numberOfLikes.description)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.red)

                        // MARK: - Comment

                        HStack(spacing: 4) {
                            Image(systemName: "bubble.right")
                                .frame(width: 16)
                                .fontWeight(.semibold)
                            Text(post.numberOfComments.description)
                        }
                        .font(.subheadline)
                    }
                } //: VStack
            } //: HStack
            .padding(4)
        } //: VStack
    }
}
