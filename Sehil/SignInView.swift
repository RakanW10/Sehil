//
//  SignInView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = SignInViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Welcome back, to Sehil")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)

                AuthTextField(placeholder: "Email", text: $vm.emailTextField, isLoading: $vm.isEmailLoading) {
                    await vm.emailValidator(email: vm.emailTextField)
                }
                
                AuthTextField(placeholder: "Password", isSecure: true, text: $vm.passwordTextField, isLoading: .constant(false))
                Button(action: {
                    //TODO: Forgot Password
                }, label: {
                    Text("Forgot password?")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
                .padding(.horizontal, 32)
                
            }
        }
        .overlay(content: {
            VStack {
                Spacer()
                NavigationAsyncButton(isFill: true, title: "Sign in", isActive: $vm.goToHome, isLoading: $vm.isSignInLoading, action: vm.signIn
                    , destination: {
                    RootView(vm: RootViewModel(userId: vm.userId))
                        //TODO: HomeView(HomeViewModel(forUser: id))
                    })
                    .padding(.horizontal, 32)
            }
        })
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .tint(Color(.primary))
            }
            ToolbarItem(placement: .principal) {
                MainLogo()
            }
        })
    }
}

#Preview {
    SignInView()
}
