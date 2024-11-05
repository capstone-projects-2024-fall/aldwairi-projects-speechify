//
//  loginPage.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct loginPageView: View{
    @State private var isUserEmail: String = ""
    @FocusState private var isEmailFocus: Bool
    @State private var isEmailError: Bool = false
    @State private var emailErrorMessage: String = ""
    @State private var isUserPassword: String = ""
    @FocusState private var isPasswordFocus: Bool
    @State private var isPasswordVisible: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var passwordErrorMessage: String = ""
    @State private var isUserValid: Bool = false
    @State private var isLoginError: Bool = false
    @State private var isPasswordReset: Bool = false
    @State private var isResetEdit: String = ""
    @FocusState private var resetEditFocus: Bool
    @State private var resetEditError: Bool = false
    @State private var resetEditErrorMessage: String = ""
    @State private var isResetResult: Bool = false
    @State private var isResetMessage: String = ""
    @State private var isResetValid: Bool = false
    
    
    init(){
        self.isEmailFocus = false
        self.isPasswordFocus = false
        self.resetEditFocus = false
    }
    
    var body: some View{
        NavigationStack{
            ZStack{
                VStack{
                    Text("Login").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                    Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "envelope.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                        TextField("Email Address", text: $isUserEmail).focused($isEmailFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                            isPasswordFocus = true
                            if !isUserEmail.isEmpty && emailErrorMessage.contains("enter") && isEmailError{
                                isEmailError.toggle()
                            }
                        }.onChange(of: isEmailFocus, {
                            if !isEmailFocus{
                                if !isUserEmail.isEmpty && emailErrorMessage.contains("enter") && isEmailError{
                                    isEmailError.toggle()
                                }
                            }
                        })
                    }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                    if isEmailError{
                        Text(emailErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                    }
                    Text("Password").frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.gray)
                        if(!isPasswordVisible){
                            SecureField("Password", text: $isUserPassword).focused($isPasswordFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                if !isUserPassword.isEmpty && isPasswordError{
                                    isPasswordError.toggle()
                                }
                            }.onChange(of: isPasswordFocus, {
                                if !isPasswordFocus{
                                    if !isUserPassword.isEmpty && isPasswordError{
                                        isPasswordError.toggle()
                                    }
                                }
                            })
                        } else{
                            TextField("Password", text: $isUserPassword).focused($isPasswordFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                if !isUserPassword.isEmpty && isPasswordError{
                                    isPasswordError.toggle()
                                }
                            }.onChange(of: isPasswordFocus, {
                                if !isPasswordFocus{
                                    if !isUserPassword.isEmpty && isPasswordError{
                                        isPasswordError.toggle()
                                    }
                                }
                            })
                        }
                        Button(action:{isPasswordVisible.toggle()}){
                            Image(systemName: !isPasswordVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                        }
                    }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                    if isPasswordError{
                        Text(passwordErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                    }
                    Text("Login").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                        if isUserEmail.isEmpty{
                            emailErrorMessage = "Please enter your email address"
                            isEmailError = true
                        } else{
                            let isEmailRegex: String = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
                            let isEmailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", isEmailRegex)
                            let isValidAddress = isEmailPredicate.evaluate(with: isUserEmail)
                            if !isValidAddress{
                                emailErrorMessage = "Invalid email address"
                                isEmailError = true
                            }
                            if isValidAddress && isEmailError{
                                isEmailError.toggle()
                            }
                        }
                        if isUserPassword.isEmpty{
                            passwordErrorMessage = "Please enter your password"
                            isPasswordError = true
                        } else if !isUserPassword.isEmpty && isPasswordError{
                            isPasswordError = false
                        }
                        if !isEmailError && !isPasswordError{
                            _ = Task{
                                isUserValid = await validateCredentials(userEmail: isUserEmail, userPassword: isUserPassword)
                            }
                        }
                    }.padding(10).navigationDestination(isPresented: $isUserValid){
                        userHomePageView()
                    }
                    if isLoginError{
                        Text("Invalid Email Or Password").foregroundColor(.red).padding(.top, 5)
                    }
                    Text("Forgot Password?").onTapGesture{ // highlight blue on hover
                        isPasswordReset.toggle()
                    }
                    HStack{
                        Text("Don't have an account? ")
                        NavigationLink(destination: signUpPageView()){
                            Text("Sign Up")
                        }
                    }
                }.padding(15).onTapGesture{
                    isEmailFocus = false
                    isPasswordFocus = false
                }
            }.overlay(alignment: .center){
                if isPasswordReset{
                    VStack{
                        ZStack{
                            HStack{
                                Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                isPasswordReset.toggle()
                                isResetEdit = ""
                                resetEditError = false
                                resetEditErrorMessage = ""
                            }
                        }
                        Text("Reset Password")
                        Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Image(systemName: "envelope.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                            TextField("Email Address", text: $isResetEdit).focused($resetEditFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                if !isResetEdit.isEmpty && resetEditErrorMessage.contains("enter") && resetEditError{
                                    resetEditError.toggle()
                                }
                            }.onChange(of: resetEditFocus, {
                                if !resetEditFocus{
                                    if !isResetEdit.isEmpty && resetEditErrorMessage.contains("enter") && resetEditError{
                                        resetEditError = false
                                    }
                                }
                                if resetEditFocus && isResetResult{
                                    isResetResult.toggle()
                                }
                            })
                        }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                        if resetEditError{
                            Text(resetEditErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                        }
                        Text("Confirm").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                            resetEditFocus = false
                            if isResetEdit.isEmpty{
                                resetEditErrorMessage = "Please enter your email address"
                                resetEditError = true
                            } else{
                                let isEmailRegex: String = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
                                let isEmailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", isEmailRegex)
                                let isValidAddress = isEmailPredicate.evaluate(with: isResetEdit)
                                if !isValidAddress{
                                    resetEditErrorMessage = "Invalid email address"
                                    resetEditError = true
                                }
                                if isValidAddress && resetEditError{
                                    resetEditError.toggle()
                                }
                                if !resetEditError{
                                    _ = Task{
                                        isResetValid = await userPasswordReset()
                                        isResetResult.toggle()
                                    }
                                    if isResetValid{
                                        isResetEdit = ""
                                        resetEditError = false
                                        resetEditErrorMessage = ""
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {isResetResult.toggle()})
                                }
                            }
                        }
                        if isResetResult{
                            Text(isResetMessage).foregroundColor(.green).padding(.top, 5)
                        }
                    }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                        resetEditFocus = false
                    }
                }
            }
        }
    }
    
    private func validateCredentials(userEmail: String, userPassword: String) async-> Bool{
        do{
            var areCredentialsValid: Bool = false
            try await Auth.auth().signIn(withEmail: isUserEmail, password: isUserPassword){
                authResult, error in
                if error != nil{
                    isLoginError.toggle()
                } else{
                    if isLoginError {isLoginError.toggle()}
                    areCredentialsValid.toggle()
                }
            }
            return areCredentialsValid
        } catch{
            print("API Call Failed")
        }
    }
    
    private func userPasswordReset() async ->Bool{
        do{
            var isResetPasswordSent: Bool = false
            try await Auth.auth().sendPasswordReset(withEmail: isResetEdit){ // Doesnt check if email is part of the databse
                error in
                if let passwordResetError = error{
                    isResetMessage = passwordResetError.localizedDescription
                    print(isResetMessage)
                } else{
                    isResetMessage = "Email Successfully Sent"
                    isResetPasswordSent.toggle()
                }
            }
            return isResetPasswordSent
        } catch{
            print("API Call Failed")
        }
    }
}

#Preview {
    loginPageView()
}
