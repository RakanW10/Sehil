//
//  NavigationMainButton.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import SwiftUI

struct NavigationMainButton<NextView: View>: View {
    let isFill: Bool
    var leadingImageName: String? = nil
    let title: String
    let destination: () -> NextView
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HStack(spacing: 16) {
                if let imageName = leadingImageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                }
                Text(title)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(isFill ? Color(.primary) : Color(.clear))
            .background(Capsule().stroke(lineWidth: 2))
            .clipShape(Capsule())
        }
        .tint(isFill ? .white : Color(.primary))
    }
}

#Preview {
    NavigationMainButton(isFill: false, leadingImageName: "google_logo", title: "Contiue with Google") {
        Text("Test")
    }
}
