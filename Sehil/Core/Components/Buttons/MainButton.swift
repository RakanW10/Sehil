//
//  MainButton.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 17/05/1445 AH.
//

import SwiftUI

struct MainButton: View {
    let isFill: Bool
    var leadingImageName: String? = nil
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 16) {
                if let imageName = leadingImageName{
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
            .background(Capsule().stroke(lineWidth:2))
            .clipShape(Capsule())
        })
        .tint(isFill ? .white : Color(.primary))
    }
}

#Preview {
    MainButton(isFill: false, leadingImageName: "google_logo", title: "Contiue with Google") {
    }
}
