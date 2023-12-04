//
//  SignUpViewModel.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import Foundation
import Supabase

class SignUpViewModel: ObservableObject {
    @Published var nameTextField: String = ""
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var dateOfBirthTextField: String = ""
    @Published var isEmailLoading: Bool = false
    @Published var isSignUpLoading: Bool = false
    @Published var goToRootView: Bool = false
    @Published var dateOfBirth: Date = Date.now
    @Published var appUser: AppUser? = nil
    private let authApi: AuthApiProtocol = AuthApi(client: Shared.client)
    private let databaseApi: DatabaseApiProtocol = DatabaseApi(client: Shared.client)

    func signUp() {
        self.isSignUpLoading = true
        Task{
            if await isFormValid() {
                do {
                    let userUuid = try await authApi.signUp(email: emailTextField, password: passwordTextField)
                    let tempAppUser = AppUser(id: userUuid, name: nameTextField, email: emailTextField.lowercased(), dateOfBirth: dateOfBirth, createdAt: Date.now)
                    try await databaseApi.addNewUser(user: tempAppUser)
                    DispatchQueue.main.async {
                        self.isSignUpLoading = false
                        self.appUser = tempAppUser
                        self.goToRootView = true
                    }
                } catch {
                    // TODO: handle error
                    print("SignUpViewModel-signUp: \(error)")
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
            let isTaken = await authApi.isEmailTaken(email: email)
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            if isTaken {
                return (false, "Email already registered")
            } else {
                return (true, "")
            }
        } else {
            DispatchQueue.main.async {
                self.isEmailLoading = false
            }
            return (false, "Not valid email.")
        }
    }

    func passwordValidator(password: String) -> (Bool, String) {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if passwordPredicate.evaluate(with: password) {
            return (true, "")
        }
        return (false, "Password should contain:\n\t- 8 Characters.\n\t- At least one digit")
    }

    private func isFormValid() async -> Bool {
        let isEmailValid = await emailValidator(email: emailTextField).0
        let isPasswordValid = passwordValidator(password: passwordTextField).0
        return !nameTextField.isEmpty && isEmailValid && isPasswordValid && dateOfBirth != Date.now
    }
    
}
