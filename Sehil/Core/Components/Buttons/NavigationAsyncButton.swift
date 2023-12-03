//
//  NavigationAsyncButton.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

struct NavigationAsyncButton<NextView: View>: View {
    let isFill: Bool
    var leadingImageName: String? = nil
    let title: String
    @Binding var isActive: Bool
    @Binding var isLoading: Bool
    let action: () -> Void
    let destination: () -> NextView
    var body: some View {
        VStack {
            NavigationLink(isActive: $isActive) { destination() } label: {}
            Button(action: action, label: {
                HStack(spacing: 16) {
                    if let imageName = leadingImageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                    }
                    if isLoading {
                        ProgressView()
                    } else {
                        Text(title)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(isFill ? Color(.primary) : Color(.clear))
                .background(Capsule().stroke(lineWidth: 2))
                .clipShape(Capsule())
            })
            .tint(isFill ? .white : Color(.primary))
        }
    }
}
