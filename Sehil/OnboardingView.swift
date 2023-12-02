//
//  OnboardingView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 17/05/1445 AH.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 8)

                MainLogo()

                Spacer()

                Text("See what's happening in the world right now.")
                    .bold()
                    .font(.title)

                Spacer()

                MainButton(isFill: false, leadingImageName: "google_logo", title: "Continue with Google") {
                    // TODO: Go to google sign in
                }
                MainButton(isFill: false, leadingImageName: "apple_black_logo", title: "Continue with Apple") {
                    // TODO: Go to apple sign in
                }

                HStack(spacing: 12) {
                    Rectangle()
                        .frame(height: 1)
                    Text("or")
                        .font(.caption)
                    Rectangle()
                        .frame(height: 1)
                }
                .foregroundColor(.gray)
                .padding(.vertical, 4)

                NavigationMainButton(isFill: true, title: "Create account") {
                    SignUpView()
                }

                .padding(.bottom, 8)

                Text("By signing up. you agree to our [Terms](https://www.google.com), [Privacy Policy](https://www.google.com), and [Cookie Use](https://www.google.com)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .fill(.clear)
                    .frame(height: 8)
                HStack(spacing: 0) {
                    Text("Have an account already?")
                    Text("Login")
                        .foregroundStyle(Color(.primary))
                        .onTapGesture {
                            // TODO: Go to login page
                        }
                }
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    OnboardingView()
}
