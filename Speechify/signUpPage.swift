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
    @State private var isValidRegister: Bool = false
    
    init(){
        self.isNameFocus = false
        self.isEmailFocused = false
        self.isPasswordFocus = false
        self.isPasswordConfirmFocus = false
    }

    var body: some View{
        NavigationView{
            VStack{
                Text("Sign-Up").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                Text("Username").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                    TextField("Username", text: $isUserName).focused($isNameFocus).background(Color.white).frame(height:30).onSubmit{
                        isEmailFocused = true
                        if isUserName.isEmpty{
                            nameErrorMessage = "Please enter your username"
                            isNameError = true
                        }
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isNameError{
                    Text(nameErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                }
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
                            isPasswordConfirmFocus = true
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
                Text("Confirm Password").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.gray)
                    if(!isPasswordConfirmVisible){
                        SecureField("Confirm Password", text: $isUserPasswordConfirm).focused($isPasswordConfirmFocus).background(Color.white).frame(height:30).onSubmit{
                            if isUserPasswordConfirm.isEmpty{
                                passwordConfirmErrorMessage = "Please enter your password"
                                isPasswordConfirmError = true
                            } else if isUserPasswordConfirm != isUserPassword{
                                passwordConfirmErrorMessage = "Passwords dont match"
                                isPasswordConfirmError = true
                            }
                        }
                    } else{
                        TextField("Confirm Password", text: $isUserPasswordConfirm).focused($isPasswordFocus).background(Color.white).frame(height:30).onSubmit{
                            if isUserPasswordConfirm.isEmpty{
                                passwordConfirmErrorMessage = "Please enter your password"
                                isPasswordConfirmError = true
                            } else if isUserPasswordConfirm != isUserPassword{
                                passwordConfirmErrorMessage = "Passwords dont match"
                                isPasswordConfirmError = true
                            }
                        }
                    }
                    Button(action:{isPasswordConfirmVisible.toggle()}){
                        Image(systemName: !isPasswordConfirmVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isPasswordConfirmError{
                    Text(passwordConfirmErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                }
                Text("Sign Up").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity).onTapGesture{
                    if isUserName.isEmpty || isUserEmail.isEmpty || isUserPassword.isEmpty || isUserPasswordConfirm.isEmpty{
                        if isUserName.isEmpty{
                            nameErrorMessage = "Please enter your username"
                            isNameError = true
                        }
                        if isUserEmail.isEmpty{
                            emailErrorMessage = "Please enter your email address"
                            isEmailError = true
                        }
                        if isUserPassword.isEmpty{
                            passwordErrorMessage = "Please enter your password"
                            isPasswordError = true
                        }
                        if isUserPasswordConfirm.isEmpty{
                            passwordConfirmErrorMessage = "Please enter your password"
                            isPasswordConfirmError = true
                        }
                    } else{
                        isValidRegister = validateAndRegisterUser()
                    }
                }.padding(10)
                HStack{
                    Text("Already have an account? ")
                    NavigationLink(destination: loginPageView()){
                        Text("Login")
                    }
                }
            }.padding(15)
        }
    }

    private func validateAndRegisterUser() -> Bool{
        return false
    }
}

struct initialUserConfiguration: View{
    @State private var languageOptionSelection: [String: Bool] = ["Arabic" : false, "Dutch" : false, "English" : false, "French" : false, "German" : false, "Italian" : false, "Japanese" : false, "Korean" : false, "Portuguese" : false, "Spanish" : false]
    @State private var themeOptionSelection: [String: Bool] = ["Randomize" : false, "Greetings" : false, "Culture" : false]
    @State private var selectedNativeLanguage: [String] = []
    @State private var selectedLearnLanguage: [String] = []
    @State private var selectedLanguageThemes: [String] = []
    @State private var isNativeMenuOpen: Bool = false
    @State private var isLearningMenuOpen: Bool = false
    @State private var isThemeOpen: Bool = false
    
    var body: some View{
        VStack(){
            Text("Select your native language(s)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
            Menu{
                ForEach(languageOptionSelection.keys.sorted(), id: \.self){ key in 
                    Button(action: {
                        if let isSelectionState = languageOptionSelection[key]{
                            languageOptionSelection[key] = !isSelectionState
                        }
                        selectedNativeLanguage.append(key)
                    }){
                        HStack{
                            Text("\(key)")
                            if let isSelectionState = languageOptionSelection[key]{
                                Image(systemName: isSelectionState ? "checkmark.circle.fill" : "circle")
                            }
                        }
                    }
                }
            }label: {
                HStack{
                    Text("Language")
                    Image(systemName: "arrowtriangle.down.square").rotationEffect(.degrees(isNativeMenuOpen ? 180 : 0))
                }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
            Text("Select language(s) do you want to learn?").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
            Menu{
                ForEach(languageOptionSelection.keys.sorted(), id: \.self){key in
                    Button(action: {
                        if let isSelectionState = languageOptionSelection[key]{
                            languageOptionSelection[key] = !isSelectionState
                        }
                        selectedLearnLanguage.append(key)
                    }){
                        HStack{
                            Text("\(key)")
                            if let isSelectionState = languageOptionSelection[key]{
                                Image(systemName: isSelectionState ? "checkmark.circle.fill" : "circle")
                            }
                        }
                    }
                }
            }label: {
                HStack{
                    Text("Language")
                    Image(systemName: "arrowtriangle.down.square")
                }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
            Text("Select language theme(s)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
            Menu{
                ForEach(themeOptionSelection.keys.sorted(), id: \.self){key in
                    Button(action: {
                        if let isSelectionState = themeOptionSelection[key]{
                            themeOptionSelection[key] = !isSelectionState
                        }
                        selectedLanguageThemes.append(key)
                    }){
                        HStack{
                            Text("\(key)")
                            if let isSelectionState = themeOptionSelection[key]{
                                Image(systemName: isSelectionState ? "checkmark.circle.fill" : "circle")
                            }
                        }
                    }
                }
            }label: {
                HStack{
                    Text("Theme")
                    Image(systemName: "arrowtriangle.down.square")
                }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
            }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
        }
    }
}

#Preview {
    initialUserConfiguration()
}
