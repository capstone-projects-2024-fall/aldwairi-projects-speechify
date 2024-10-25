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
    @State private var isUserValid: Bool = false
    
    init(){
        self.isEmailFocused = false
        self.isPasswordFocus = false
    }
    
    var body: some View{
        NavigationView{
            VStack{
                Text("Login").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "envelope.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                    TextField("Email Address", text: $isUserEmail).focused($isEmailFocused).background(Color.white).frame(height:30).onSubmit{
                        isPasswordFocus = true
                        if isUserEmail.isEmpty{
                            emailErrorMessage = "Please enter your email address"
                            isEmailError = true
                        } else{
                            let isEmailRegex: String = "[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
                            let isEmailPredicate = NSPredicate(format: "SELF MATCHES %@", isEmailRegex)
                            let isValidAddress = isEmailPredicate.evaluate(with: isUserEmail)
                            if isValidAddress{
                                emailErrorMessage = "Invalid email address"
                            }
                            isEmailError = true
                        }
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isEmailError{
                    Text(emailErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                }
                Text("Password").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.gray)
                    if(!isPasswordVisible){
                        SecureField("Password", text: $isUserPassword).focused($isPasswordFocus).background(Color.white).frame(height:30).onSubmit{
                            if isUserPassword.isEmpty{
                                passwordErrorMessage = "Please enter your password"
                                isPasswordError = true
                            }
                        }
                    } else{
                        TextField("Password", text: $isUserPassword).focused($isPasswordFocus).background(Color.white).frame(height:30).onSubmit{
                            if isUserPassword.isEmpty{
                                passwordErrorMessage = "Please enter your password"
                                isPasswordError = true
                            }
                        }
                    }
                    Button(action:{isPasswordVisible.toggle()}){
                        Image(systemName: !isPasswordVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isPasswordError{
                    Text(passwordErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                }
                Text("Login").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity).onTapGesture{
                    if isUserEmail.isEmpty || isUserPassword.isEmpty{
                        if isUserEmail.isEmpty{
                            emailErrorMessage = "Please enter your email address"
                            isEmailError = true
                        }
                        if isUserPassword.isEmpty{
                            passwordErrorMessage = "Please enter your password"
                            isPasswordError = true
                        }
                    } else{
                        isUserValid = validateCredentials(userEmail: isUserEmail, userPassword: isUserPassword)
                    }
                }.padding(10)
                /*NavigationLink(destination: passwordReset()){
                    Text("Forgot Password?") // highlight blue on hover
                }*/ //In development
                HStack{
                    Text("Don't have an account? ")
                    NavigationLink(destination: signUpPageView()){
                        Text("Sign Up")
                    }
                }
            }.padding(15)
        }
    }
    
    private func validateCredentials(userEmail: String, userPassword: String)-> Bool{
        print("Test")
        return false
    }
}

#Preview {
    loginPageView()
}
