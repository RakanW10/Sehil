//
//  SignUpView.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = SignUpViewModel()
    @State var isDatePickerShowing = false
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Create your account")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)

                AuthTextField(placeholder: "Name", text: $vm.nameTextField, isLoading: .constant(false))

                AuthTextField(placeholder: "Date of Birth", text: $vm.dateOfBirthTextField, isLoading: .constant(false))
                    .onTapGesture {
                        isDatePickerShowing.toggle()
                    }

                AuthTextField(placeholder: "Email", keyboardType: .emailAddress, text: $vm.emailTextField, isLoading: $vm.isEmailLoading) {
                    await vm.emailValidator(email: vm.emailTextField)
                }
                
                AuthTextField(placeholder: "Password", isSecure: true, text: $vm.passwordTextField, isLoading: .constant(false)) {
                    vm.passwordValidator(password: vm.passwordTextField)
                }
            } //: VStack
        } //: ScrollView
        .overlay {
            VStack {
                Spacer()
                MainButton(isFill: true, title: "Sign up") {
                    Task {
                        await vm.signUp()
                    }
                }
                .padding(32)
            }
        }
        .sheet(isPresented: $isDatePickerShowing, content: {
            DatePicker("TestTitle", selection: $vm.dateOfBirth, displayedComponents: .date)
                .padding()
                .tint(Color(.primary))
                .presentationDetents([.fraction(0.5)])
                .datePickerStyle(.graphical)
                .onChange(of: vm.dateOfBirth, { _, _ in
                    isDatePickerShowing.toggle()
                })
                .onChange(of: vm.dateOfBirth) { _, _ in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMMM yyyy"
                    let dateString = dateFormatter.string(from: vm.dateOfBirth)
                    vm.dateOfBirthTextField = dateString
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
    SignUpView()
}
