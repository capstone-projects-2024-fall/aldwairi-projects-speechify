//
//  loginPage.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//

import SwiftUI

struct loginPageView: View{
    @State private var isUserEmail: String = ""
    @FocusState private var isEmailFocused: Bool
    @State private var isEmailError: Bool = false
    @State private var emailErrorMessage: String = ""
    @State private var isUserPassword: String = ""
    @FocusState private var isPasswordFocus: Bool
    @State private var isPasswordVisible: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var passwordErrorMessage: String = ""
    
    init(){
        self.isEmailFocused = false
        self.isPasswordFocus = false
    }
    
    var body: some View{
        NavigationView{
            VStack{
                Text("Login").font(.largeTitle).multilineTextAlignment(.center).padding(10)
                Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "envelope.fill")
                    TextField("Email Address", text: $isUserEmail).focused($isEmailFocused)
                    .onSubmit{
                        isPasswordFocus = true
                        if isUserEmail.isEmpty{
                            emailErrorMessage = "Please enter your email address"
                            isEmailError = true
                        }else{
                            let isEmailRegex: String = ""
                            emailErrorMessage = "Invalid email address"
                            isEmailError = true
                        }
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isEmailError{
                    Text(emailErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Password").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "lock.fill")
                    if(!isPasswordVisible){
                        SecureField("Password", text: $isUserPassword).focused($isPasswordFocus)
                        .onSubmit{
                            if isUserPassword.isEmpty{
                                passwordErrorMessage = "Please enter your password"
                                isPasswordError = true
                            }
                        }
                    } else{
                        TextField("Password", text: $isUserPassword).focused($isPasswordFocus)
                        .onSubmit{
                            if isUserPassword.isEmpty{
                                passwordErrorMessage = "Please enter your password"
                                isPasswordError = true
                            }
                        }
                    }
                    Button(action:{isPasswordVisible.toggle()}){
                        Image(systemName: !isPasswordVisible ? "eye.slash" : "eye")
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isPasswordError{
                    Text(passwordErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
                }
                Button("Login"){
                    //Action To Perform
                }
                .buttonStyle(.bordered).buttonBorderShape(.roundedRectangle(radius: 5)).padding(10)
                Text("Forgot Password?") // Execute a function
            }
            .padding(20) 
            HStack{
                Text("Dont have an account? ")
                NavigationLink(destination: signUpPageView()){
                    Text("Sign Up")
                }
            }
        }
    }

    private func validateCredentials(userEmail: String, userPassword: String) -> Bool{
        return true
    }
}

#Preview {
    loginPageView()
}
