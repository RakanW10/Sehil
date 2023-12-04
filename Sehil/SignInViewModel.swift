//
//  SignInViewModel.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import Foundation

class SignInViewModel: ObservableObject{
    @Published var emailTextField: String = "Rakan@test.com"
    @Published var passwordTextField: String = "qwer4321"
    @Published var isEmailLoading: Bool = false
    @Published var isSignInLoading: Bool = false
    @Published var goToRootView: Bool = false
    @Published var appUser: AppUser? = nil
    private let authApi: AuthApiProtocol = AuthApi(client: Shared.client)
    private let databaseApi: DatabaseApiProtocol = DatabaseApi(client: Shared.client)
    
    func signIn() {
        DispatchQueue.main.async {
            self.isSignInLoading = true
        }
        Task{
            if await emailValidator(email: emailTextField).0 {
                do {
                    let uuid = try await authApi.signIn(email: emailTextField, password: passwordTextField)
                    let appUser = try await databaseApi.getUser(userId: uuid)
                    DispatchQueue.main.async {
                        self.isSignInLoading = false
                        self.appUser = appUser
                        self.goToRootView = true
                    }
                } catch {
                    print("SignInViewModel-signIn: \(error)")
                }
            }
        }
    }
    
    
    func emailValidator(email: String) async -> (Bool, String) {
        DispatchQueue.main.async {
            self.isEmailLoading = true
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailPredicate.evaluate(with: email) {
            // Check email is not already taken
            let isRegistered = await authApi.isEmailTaken(email: email)
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            if isRegistered {
                return (true, "")
            } else {
                return (false, "Email not found.")
            }
        } else {
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            return (false, "Not valid email.")
        }
    }
}
