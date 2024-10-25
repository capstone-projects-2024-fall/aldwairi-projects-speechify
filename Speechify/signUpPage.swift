//
//  signUpPage.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//

import SwiftUI

struct signUpPageView: View{
    @State private var isUserName: String = ""
    @FocusState private var isNameFocus: Bool
    @State private var isNameError: Bool = false
    @State private var nameErrorMessage: String = ""
    @State private var isUserEmail: String = ""
    @FocusState private var isEmailFocused: Bool
    @State private var isEmailError: Bool = false
    @State private var emailErrorMessage: String = ""
    @State private var isUserPassword: String = ""
    @FocusState private var isPasswordFocus: Bool
    @State private var isPasswordVisible: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var passwordErrorMessage: String = ""
    @State private var isUserPasswordConfirm: String = ""
    @FocusState private var isPasswordConfirmFocus: Bool
    @State private var isPasswordConfirmVisible: Bool = false
    @State private var isPasswordConfirmError: Bool = false
    @State private var passwordConfirmErrorMessage: String = ""

    init(){
        self.isNameFocus = false
        self.isEmailFocused = false
        self.isPasswordFocus = false
        self.isPasswordConfirmFocus = false
    }

    var body: some View{
        NavigationView{
            VStack{
                Text("Sign-Up").font(.largeTitle).multilineTextAlignment(.center).padding(10)
                Text("Username").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "person.circle.fill")
                    TextField("Username", text: $isUserName).textFieldStyle(.roundedBorder).focused($isNameFocus)
                    .onSubmit{
                        isEmailFocused = true
                        if isUserName.isEmpty{
                            nameErrorMessage = "Please enter your username"
                            isNameError = true
                        }
                    }
                }
                if isNameError{
                    Text(nameErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "envelope.fill")
                    TextField("Email Address", text: $isUserEmail).textFieldStyle(.roundedBorder).focused($isEmailFocused)
                    .onSubmit{
                        isPasswordFocus = true
                        if isUserEmail.isEmpty{
                            emailErrorMessage = "Please enter your email address"
                            isEmailError = true
                        } else{
                            let isEmailRegex: String = ""
                            emailErrorMessage = "Invalid email address"
                            isEmailError = true
                        }
                    }
                }
                if isEmailError{
                    Text(emailErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Password").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "lock.fill")
                    if(!isPasswordVisible){
                        SecureField("Password", text: $isUserPassword).textFieldStyle(.roundedBorder).focused($isPasswordFocus)
                        .onSubmit{
                            if isUserPassword.isEmpty{
                                passwordErrorMessage = "Please enter your password"
                                isPasswordError = true
                            }
                        }
                    } else{
                        TextField("Password", text: $isUserPassword).textFieldStyle(.roundedBorder).focused($isPasswordFocus)
                        .onSubmit{
                            if isUserPassword.isEmpty{
                                passwordErrorMessage = "Please enter your password"
                                isPasswordError = true
                            }
                        }
                    }
                }
                if isPasswordError{
                    Text(passwordErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Confirm Password").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "lock.fill")
                    if(!isPasswordConfirmVisible){
                        SecureField("Confirm Password", text: $isUserPasswordConfirm).textFieldStyle(.roundedBorder).focused($isPasswordConfirmFocus)
                        .onSubmit{
                            if isUserPasswordConfirm.isEmpty{
                                passwordConfirmErrorMessage = "Please enter your password"
                                isPasswordConfirmError = true
                            }
                        }
                    } else{
                        TextField("Password", text: $isUserPasswordConfirm).textFieldStyle(.roundedBorder).focused($isPasswordFocus)
                        .onSubmit{
                            if isUserPasswordConfirm.isEmpty{
                                passwordConfirmErrorMessage = "Please enter your password"
                                isPasswordConfirmError = true
                            }
                        }
                    }
                }
                if isPasswordConfirmError{
                    Text(passwordConfirmErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading)
                }
                Button("Sign Up"){
                    //Action To Perform
                }
                .buttonStyle(.bordered).buttonBorderShape(.roundedRectangle(radius: 5)).padding(10)
                Text("Forgot Password?") // Execute a function
            }.padding(15)
            HStack{
                Text("Already have an account? ")
                NavigationLink(destination: loginPageView()){
                    Text("Login")
                }
            }
        }
    }

    private func validateAndRegisterUser(){}
}

struct initialUserConfiguration: View{
    @State private var languageOptionSelection: [String: Bool] = ["----" : false, "Arabic" : false, "Dutch" : false, "English" : false, "French" : false, "German" : false, "Italian" : false, "Japanese" : false, "Korean" : false, "Portuguese" : false, "Spanish" : false]
    @State private var themeOptionSelection: [String: Bool] = ["Randomize" : false, "Greetings" : false, "Culture" : false]
    @State private var selectedNativeLanguage: [String] = []
    @State private var selectedLearnLanguage: [String] = []
    @State private var selectedLanguageThemes: [String] = []
    
    var body: some View{
        VStack{
            Text("Select Your native language")
            Menu("Language"){
                for(isKey, isValue) in languageOptionSelection{ // Cant use for loop inside menu
                    Button(action: {
                        languageOptionSelection[isKey].toggle()
                        selectedNativeLanguage.append(isKey)
                    }){
                        HStack{
                            Image(systemName: languageOptionSelection[isKey] ? "checkmark.circle.fill" : "circle").foregroundColor(languageOptionSelection[isKey] ? .gray : .white)
                        }
                    }
                }
            }.buttonStyle(.bordered).cornerRadius(10)
            Text("What language do you want to learn?")
            Menu("Language"){
                for(isKey, isValue) in languageOptionSelection{
                    Button(action: {
                        languageOptionSelection[isKey].toggle()
                        selectedLearnLanguage.append(isKey)
                    }){
                        HStack{
                            Image(systemName: languageOptionSelection[isKey] ? "checkmark.circle.fill" : "circle").foregroundColor(languageOptionSelection[isKey] ? .gray : .white)
                        }
                    }
                }
            }.buttonStyle(.bordered).cornerRadius(10)
            Text("Select a language theme")
            Menu("Theme"){
                for(isKey, isValue) in themeOptionSelection{
                    Button(action: {
                        themeOptionSelection[isKey].toggle()
                        selectedLanguageThemes.append(isKey)
                    }){
                        HStack{
                            Image(systemName: themeOptionSelection[isKey] ? "checkmark.circle.fill" : "circle").foregroundColor(themeOptionSelection[isKey] ? .gray : .white)
                        }
                    }
                }
            }.buttonStyle(.bordered).cornerRadius(10)
        }
    }
}


#Preview {
    signUpPageView()
}
