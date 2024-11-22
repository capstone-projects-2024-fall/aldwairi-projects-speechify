//
//  SpeechifyApp.swift
//  Speechify
//
//  Created by Oladapo Oladele on 2024/11/08.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import AVFoundation
import Speech

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        FirebaseApp.configure()
        return true
    }
}

@main
struct SpeechifyApp: App{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene{
        WindowGroup{
            contentPageView()
        }
    }
}

struct contentPageView: View{
    @State var loginNavigate: Bool = false
    @State var signupNavigate: Bool = false
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("Speechify").font(.largeTitle).multilineTextAlignment(.center).padding(10)
                Text("Login").font(.title).padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{loginNavigate.toggle()}.navigationDestination(isPresented: $loginNavigate){
                    authenticationView().navigationBarBackButtonHidden(true)
                }
                Text("Sign-Up").font(.title).padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{signupNavigate.toggle()}.navigationDestination(isPresented: $signupNavigate){
                    registrationView().navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct registrationView: View{
    @State private var isUserName: String = ""
    @FocusState private var isNameFocus: Bool
    @State private var isNameError: Bool = false
    @State private var nameErrorMessage: String = ""
    @State private var isUserEmail: String = ""
    @FocusState private var isEmailFocus: Bool
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
    @State private var isRegistrationValid: Bool = false
    
    init(){
        self.isNameFocus = false
        self.isEmailFocus = false
        self.isPasswordFocus = false
        self.isPasswordConfirmFocus = false
    }
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("Sign-Up").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                Text("Username").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                    TextField("Username", text: $isUserName).focused($isNameFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                        isEmailFocus = true
                        if !isUserName.isEmpty && isNameError{
                            isNameError.toggle()
                        }
                    }.onChange(of: isNameFocus, {
                        if !isNameFocus{
                            if !isUserName.isEmpty && isNameError{
                                isNameError.toggle()
                            }
                        }
                    })
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isNameError{
                    Text(nameErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                }
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
                            isPasswordConfirmFocus = true
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
                            isPasswordConfirmFocus = true
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
                Text("Confirm Password").frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.gray)
                    if(!isPasswordConfirmVisible){
                        SecureField("Confirm Password", text: $isUserPasswordConfirm).focused($isPasswordConfirmFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                            if !isUserPasswordConfirm.isEmpty && passwordConfirmErrorMessage.contains("enter") && isPasswordConfirmError{
                                isPasswordConfirmError.toggle()
                            }
                            if isUserPasswordConfirm == isUserPassword && passwordConfirmErrorMessage.contains("match") && isPasswordConfirmError{
                                isPasswordConfirmError.toggle()
                            }
                        }.onChange(of: isPasswordConfirmFocus, {
                            if !isPasswordConfirmFocus{
                                if !isUserPasswordConfirm.isEmpty && passwordConfirmErrorMessage.contains("enter") && isPasswordConfirmError{
                                    isPasswordConfirmError.toggle()
                                }
                                if isUserPasswordConfirm == isUserPassword && passwordConfirmErrorMessage.contains("match") && isPasswordConfirmError{
                                    isPasswordConfirmError.toggle()
                                }
                            }
                        })
                    } else{
                        TextField("Confirm Password", text: $isUserPasswordConfirm).focused($isPasswordConfirmFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                            if !isUserPasswordConfirm.isEmpty && passwordConfirmErrorMessage.contains("enter") && isPasswordConfirmError{
                                isPasswordConfirmError.toggle()
                            }
                            if isUserPasswordConfirm == isUserPassword && passwordConfirmErrorMessage.contains("match") && isPasswordConfirmError{
                                isPasswordConfirmError.toggle()
                            }
                        }.onChange(of: isPasswordConfirmFocus, {
                            if !isPasswordConfirmFocus{
                                if !isUserPasswordConfirm.isEmpty && passwordConfirmErrorMessage.contains("enter") && isPasswordConfirmError{
                                    isPasswordConfirmError.toggle()
                                }
                                if isUserPasswordConfirm == isUserPassword && passwordConfirmErrorMessage.contains("match") && isPasswordConfirmError{
                                    isPasswordConfirmError.toggle()
                                }
                            }
                        })
                    }
                    Button(action:{isPasswordConfirmVisible.toggle()}){
                        Image(systemName: !isPasswordConfirmVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                if isPasswordConfirmError{
                    Text(passwordConfirmErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                }
                Text("Sign Up").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                    if isUserName.isEmpty{
                        nameErrorMessage = "Please enter your username"
                        isNameError = true
                    }
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
                        if isValidAddress && emailErrorMessage.contains("Invalid") && isEmailError{
                            isEmailError.toggle()
                        }
                    }
                    if isUserPassword.isEmpty{
                        passwordErrorMessage = "Please enter your password"
                        isPasswordError = true
                    }
                    if isUserPasswordConfirm.isEmpty{
                        passwordConfirmErrorMessage = "Please enter your password"
                        isPasswordConfirmError = true
                    } else if isUserPasswordConfirm != isUserPassword{
                        passwordConfirmErrorMessage = "Passwords dont match"
                        isPasswordConfirmError = true
                    }
                    if !isNameError && !isEmailError && !isPasswordError && !isPasswordConfirmError{
                        _ = Task{
                            isRegistrationValid = await registerCredentials()
                        }
                    }
                }.padding(10).navigationDestination(isPresented: $isRegistrationValid){
                    initialUserConfigurationView().navigationBarBackButtonHidden(true)
                }
                HStack{
                    Text("Already have an account? ")
                    NavigationLink(destination: authenticationView().navigationBarBackButtonHidden(true)){
                        Text("Login")
                    }
                }
            }.padding(15).onTapGesture{
                isNameFocus = false
                isEmailFocus = false
                isPasswordFocus = false
                isPasswordConfirmFocus = false
            }
        }
    }
    
    private func registerCredentials() async -> Bool{
        var isValidRegistration: Bool = false
        do{
            let authResult = try await Auth.auth().createUser(withEmail: isUserEmail, password: isUserPassword)
            let isUserProfile = authResult.user.createProfileChangeRequest()
            isUserProfile.displayName = isUserName
            try await isUserProfile.commitChanges()
            try await Firestore.firestore().collection("users").document(authResult.user.uid).setData(["userName": isUserName])
            isValidRegistration.toggle()
        } catch{
            print(error.localizedDescription)
        }
        return isValidRegistration
    }
}

struct initialUserConfigurationView: View{
    private let ISO639_3: [String:String] = ["Arabic":"ara", "Bengali":"ben", "Bulgarian":"bul", "Czech":"ces", "Dutch":"nid", "English (UK)":"eng_UK", "English (US)":"eng_US", "French":"fra", "German":"deu", "Hindi":"hin", "Indonesian":"ind", "Irish":"gle", "Italian":"ita", "Japanese":"jpn", "Korean":"kor", "Portuguese":"por", "Spanish":"spa", "Russian":"rus", "Swedish":"swe", "Vietnamese":"vie"]
    @State private var genderOptionSelection: [String:Bool] = ["Female":false, "Male":false, "Other":false]
    private let dateMonthSelection: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    @State private var nativeOptionSelection: [String: Bool] = ["Arabic":false, "Dutch":false, "English (UK)":false, "English (US)":false, "French":false, "German":false, "Hindi":false, "Italian":false, "Japanese":false, "Korean":false, "Portuguese":false, "Spanish":false, "Russian":false]
    @State private var learnOptionSelection: [String: Bool] = ["Arabic":false, "Dutch":false, "English (UK)":false, "English (US)":false, "French":false, "German":false, "Hindi":false, "Italian":false, "Japanese":false, "Korean":false, "Portuguese":false, "Spanish":false, "Russian":false]
    @State private var themeOptionSelection: [String: Bool] = ["Randomize":false, "Greetings":false, "Culture":false]
    private let dateDaySelection: Range<Int> = 1..<32
    private var dateYearSelection: Range<Int> = 1900..<2025
    @State private var selectedGender: String = ""
    @State private var isGenderInput: String = ""
    @State private var selectedDay: String = ""
    @State private var selectedMonth: String = ""
    @State private var selectedYear: String = ""
    @State private var selectedBirthday = ""
    @State private var selectedNativeLanguage: [String] = []
    @State private var selectedLearningLanguage: [String] = []
    @State private var selectedLanguageTheme: [String] = []
    @State private var isGenderMenuOpen: Bool = false
    @State private var isDayMenuOpen: Bool = false
    @State private var isMonthMenuOpen: Bool = false
    @State private var isYearMenuOpen: Bool = false
    @State private var isNativeMenuOpen: Bool = false
    @State private var isLearningMenuOpen: Bool = false
    @State private var isThemeMenuOpen: Bool = false
    @State private var showOverlay: Bool = false
    @State private var isLayoutChange: Bool = false
    @State private var hasUserSettings: Bool = false
    @State private var hasSettingError: Bool = false
    @State private var isErrorMessage: String = ""
    
    var body: some View{
        NavigationStack{
            ZStack{
                VStack{
                    Text("Select Your Gender").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    HStack{
                        Text(selectedGender.isEmpty ? "Gender" : selectedGender).foregroundStyle(.blue).frame(width: 65, height: 20, alignment: .leading)
                        Image(systemName: selectedGender.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isGenderMenuOpen ? 180 : 0))
                    }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                        if showOverlay{
                            backgroundOverlayCollapse()
                        } else{
                            isGenderMenuOpen.toggle()
                            showOverlay.toggle()
                        }
                    }
                    if selectedGender == "Other"{
                        HStack{
                            TextField("Enter Your Gender", text: $isGenderInput).background(Color.white).frame(width: 300, height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                        }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }
                    Text("Enter Your Date Of Birth").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    HStack{
                        HStack{
                            Text(selectedDay.isEmpty ? "DD" : selectedDay).foregroundStyle(.blue).frame(width: 30, height: 20, alignment: .leading)
                            Image(systemName: selectedDay.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isDayMenuOpen ? 180 : 0))
                        }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                            if showOverlay{
                                backgroundOverlayCollapse()
                            } else{
                                isDayMenuOpen.toggle()
                                showOverlay.toggle()
                            }
                        }
                        HStack{
                            Text(selectedMonth.isEmpty ? "MM" : selectedMonth).foregroundStyle(.blue).frame(width: 35, height: 20, alignment: .leading)
                            Image(systemName: selectedMonth.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isMonthMenuOpen ? 180 : 0))
                        }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                            if showOverlay{
                                backgroundOverlayCollapse()
                            } else{
                                isMonthMenuOpen.toggle()
                                showOverlay.toggle()
                            }
                        }
                        HStack{
                            Text(selectedYear.isEmpty ? "YYYY" : selectedYear).foregroundStyle(.blue).frame(width: 45, height: 20, alignment: .leading)
                            Image(systemName: selectedYear.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isYearMenuOpen ? 180 : 0))
                        }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                            if showOverlay{
                                backgroundOverlayCollapse()
                            } else{
                                isYearMenuOpen.toggle()
                                showOverlay.toggle()
                            }
                        }
                    }
                    Text("Select Your Native Language(s)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    HStack{
                        Text("Language").foregroundStyle(.blue).frame(width: 125, height: 20, alignment: .leading)
                        Image(systemName: selectedNativeLanguage.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isNativeMenuOpen ? 180 : 0))
                    }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                        if showOverlay{
                            backgroundOverlayCollapse()
                        } else{
                            isNativeMenuOpen.toggle()
                            showOverlay.toggle()
                        }
                    }
                    Text("Select Language(s) To Learn").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    HStack{
                        Text("Language").foregroundStyle(.blue).frame(width: 125, height: 20, alignment: .leading)
                        Image(systemName: selectedLearningLanguage.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isLearningMenuOpen ? 180 : 0))
                    }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                        if showOverlay{
                            backgroundOverlayCollapse()
                        } else{
                            isLearningMenuOpen.toggle()
                            showOverlay.toggle()
                        }
                    }
                    Text("Select Language Theme(s)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    HStack{
                        Text("Theme").foregroundStyle(.blue).frame(width: 125, height: 20, alignment: .leading)
                        Image(systemName: selectedLanguageTheme.isEmpty ? "chevron.down" : "chevron.down.circle.fill").rotationEffect(.degrees(isThemeMenuOpen ? 180 : 0))
                    }.padding(10).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                        if showOverlay{
                            backgroundOverlayCollapse()
                        } else{
                            isThemeMenuOpen.toggle()
                            showOverlay.toggle()
                        }
                    }
                    Text("Finish").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.top, 65).onTapGesture{
                        isErrorMessage = ""
                        if selectedGender.isEmpty{
                            isErrorMessage.append("Gender")
                        } else if !selectedGender.isEmpty && selectedGender == "Other" && isGenderInput.isEmpty{
                            isErrorMessage.append("Gender")
                        }
                        if selectedDay.isEmpty{
                            isErrorMessage.append(isErrorMessage.isEmpty ? "Day Of Birth" : ", Day Of Birth")
                        }
                        if selectedMonth.isEmpty{
                            isErrorMessage.append(isErrorMessage.isEmpty ? "Month Of Birth": ", Month Of Birth")
                        }
                        if selectedYear.isEmpty{
                            isErrorMessage.append(isErrorMessage.isEmpty ? "Year Of Birth" : ", Year Of Birth")
                        }
                        if selectedNativeLanguage.isEmpty{
                            isErrorMessage.append(isErrorMessage.isEmpty ? "Native Language" : ", Native Language")
                        }
                        if selectedLearningLanguage.isEmpty{
                            isErrorMessage.append(isErrorMessage.isEmpty ? "Leaning Languages" : ", Learning Languages")
                        }
                        if selectedLanguageTheme.isEmpty{
                            isErrorMessage.append(isErrorMessage.isEmpty ? "Language Theme" : ", Language Theme")
                        }
                        if isErrorMessage.isEmpty{
                            _ = Task{hasUserSettings = await storeUserSettings()}
                        } else{
                            hasSettingError.toggle()
                        }
                    }.navigationDestination(isPresented: $hasUserSettings){userHomeView().navigationBarBackButtonHidden(true)}
                }.onTapGesture{backgroundOverlayCollapse()}
                if hasSettingError{
                    VStack{
                        Text("Please Select: \(isErrorMessage)").font(.title3)
                    }.padding(5).background(Color(UIColor.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 5)).offset(y: 300)
                }
            }.overlay(alignment: .leading){
                if isGenderMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(genderOptionSelection.keys.sorted(), id: \.self){ key in
                                HStack{
                                    Text("\(key)").foregroundStyle(.blue).frame(width: 65, height: 20, alignment: .leading)
                                    if let isSelected = genderOptionSelection[key]{
                                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    }
                                }.padding(5).onTapGesture{
                                    genderOptionSelection.forEach{ isKey, isValue in
                                        if isKey != key{
                                            genderOptionSelection[isKey] = false
                                        }
                                    }
                                    if let isSelected = genderOptionSelection[key]{
                                        genderOptionSelection[key] = !isSelected // Make it so that only one can be selected
                                        if !isSelected{
                                            selectedGender = key
                                        } else{
                                            selectedGender = ""
                                        }
                                    }
                                    isGenderMenuOpen.toggle()
                                    if selectedGender != "Other" && isLayoutChange{
                                        isLayoutChange.toggle()
                                    } else if selectedGender == "Other" && !isLayoutChange{
                                        isLayoutChange.toggle()
                                    }
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(y: isLayoutChange ? -143 : -124).frame(height: 100)
                }
                if isDayMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(dateDaySelection, id: \.self){ day in
                                HStack{
                                    Text("\(day)").foregroundStyle(.blue).frame(width: 30, height: 20, alignment: .leading)
                                    Image(systemName: Int(selectedDay) == day  ? "checkmark.circle.fill" : "circle")
                                }.padding(5).onTapGesture{
                                    if !selectedDay.isEmpty && Int(selectedDay) != day{
                                        selectedDay = ""
                                    }
                                    if selectedDay.isEmpty{
                                        selectedDay = String(day)
                                    } else{
                                        selectedDay = ""
                                    }
                                    isDayMenuOpen.toggle()
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(y: isLayoutChange ? -28 : -47).frame(height: 100)
                }
                if isMonthMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(dateMonthSelection, id: \.self){ month in
                                HStack{
                                    Text("\(month)").foregroundStyle(.blue).frame(width: 35, height: 20, alignment: .leading)
                                    Image(systemName: selectedMonth == month  ? "checkmark.circle.fill" : "circle")
                                }.padding(5).onTapGesture{
                                    if !selectedMonth.isEmpty && selectedMonth != month{
                                        selectedMonth = ""
                                    }
                                    if selectedMonth.isEmpty{
                                        selectedMonth = month
                                    } else{
                                        selectedMonth = ""
                                    }
                                    isMonthMenuOpen.toggle()
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(x: 133, y: isLayoutChange ? -28 : -47).frame(height: 100)
                }
                if isYearMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(dateYearSelection, id: \.self){ year in
                                HStack{
                                    Text(String(year)).foregroundStyle(.blue).frame(width: 45, height: 20, alignment: .leading)
                                    Image(systemName: Int(selectedYear) == year  ? "checkmark.circle.fill" : "circle")
                                }.padding(5).onTapGesture{
                                    if !selectedYear.isEmpty && Int(selectedYear) != year{
                                        selectedYear = ""
                                    }
                                    if selectedYear.isEmpty{
                                        selectedYear = String(year)
                                    } else{
                                        selectedYear = ""
                                    }
                                    isYearMenuOpen.toggle()
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(x: 267, y: isLayoutChange ? -28 : -47).frame(height: 100)
                }
                if isNativeMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(nativeOptionSelection.keys.sorted(), id: \.self){ key in
                                HStack{
                                    Text("\(key)").foregroundStyle(.blue).frame(width: 125, height: 20, alignment: .leading)
                                    if let isSelected = nativeOptionSelection[key]{
                                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    }
                                }.padding(5).onTapGesture{
                                    if let isSelected = nativeOptionSelection[key]{
                                        nativeOptionSelection[key] = !isSelected
                                        guard let isISO639_3 = ISO639_3[key]else{return}
                                        if !isSelected{
                                            selectedNativeLanguage.append(isISO639_3)
                                        } else{
                                            if let index = selectedNativeLanguage.firstIndex(of: isISO639_3){
                                                selectedNativeLanguage.remove(at: index)
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(y: isLayoutChange ? 49 : 30).frame(height: 100)
                }
                if isLearningMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(learnOptionSelection.keys.sorted(), id: \.self){ key in
                                HStack{
                                    Text("\(key)").foregroundStyle(.blue).frame(width: 125, height: 20, alignment: .leading)
                                    if let isSelected = learnOptionSelection[key]{
                                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    }
                                }.padding(5).onTapGesture{
                                    if let isSelected = learnOptionSelection[key]{
                                        learnOptionSelection[key] = !isSelected
                                        guard let isISO639_3 = ISO639_3[key]else{return}
                                        if !isSelected{
                                            selectedLearningLanguage.append(isISO639_3)
                                        } else{
                                            if let index = selectedLearningLanguage.firstIndex(of: isISO639_3){
                                                selectedLearningLanguage.remove(at: index)
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(y: isLayoutChange ? 127 : 108).frame(height: 100)
                }
                if isThemeMenuOpen{
                    ScrollView{
                        VStack{
                            ForEach(themeOptionSelection.keys.sorted(), id: \.self){ key in
                                HStack{
                                    Text("\(key)").foregroundStyle(.blue).frame(width: 125, height: 20, alignment: .leading)
                                    if let isSelected = themeOptionSelection[key]{
                                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                    }
                                }.padding(5).onTapGesture{
                                    if let isSelected = themeOptionSelection[key]{
                                        themeOptionSelection[key] = !isSelected
                                        if !isSelected{
                                            selectedLanguageTheme.append(key)
                                        } else{
                                            if let index = selectedLanguageTheme.firstIndex(of: key){
                                                selectedLanguageTheme.remove(at: index)
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(5).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.offset(y: isLayoutChange ? 204 : 185).frame(height: 100)
                }
            }
        }
    }
    
    private func storeUserSettings() async -> Bool{
        var isSettingStored: Bool = false
        do{
            let isDataBase = Firestore.firestore()
            guard let isUserID = Auth.auth().currentUser?.uid else{return false}
            selectedBirthday = "\(selectedDay) \(selectedMonth) \(selectedYear)"
            let isUserSetting: [String: Any] = ["gender" : selectedGender, "birthday" : selectedBirthday, "nativeLanguage" : selectedNativeLanguage, "learnLanguage" : selectedLearningLanguage, "languageTheme" : selectedLanguageTheme]
            try await isDataBase.collection("users").document(isUserID).setData(isUserSetting, merge: true)
            isSettingStored = true
        } catch{
            print(error.localizedDescription)
        }
        return isSettingStored
    }
    
    private func backgroundOverlayCollapse(){
        if showOverlay{
            if isGenderMenuOpen{isGenderMenuOpen.toggle()}
            if isDayMenuOpen{isDayMenuOpen.toggle()}
            if isMonthMenuOpen{isMonthMenuOpen.toggle()}
            if isYearMenuOpen{isYearMenuOpen.toggle()}
            if isNativeMenuOpen{isNativeMenuOpen.toggle()}
            if isLearningMenuOpen{isLearningMenuOpen.toggle()}
            if isThemeMenuOpen{isThemeMenuOpen.toggle()}
        }
        showOverlay.toggle()
    }
}

struct authenticationView: View{
    @State private var isUserEmail: String = ""
    @State private var isUserPassword: String = ""
    @State private var isResetEdit: String = ""
    @FocusState private var isEmailFocus: Bool
    @FocusState private var isPasswordFocus: Bool
    @FocusState private var resetEditFocus: Bool
    @State private var isPasswordVisible: Bool = false
    @State private var isPasswordReset: Bool = false
    @State private var isEmailError: Bool = false
    @State private var isLoginError: Bool = false
    @State private var isPasswordError: Bool = false
    @State private var resetEditError: Bool = false
    @State private var emailErrorMessage: String = ""
    @State private var passwordErrorMessage: String = ""
    @State private var resetEditErrorMessage: String = ""
    @State private var isResetResult: Bool = false
    @State private var isResetMessage: String = ""
    @State private var isResetValid: Bool = false
    @State private var isUserValid: Bool = false
    
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
                            print("login reached")
                            _ = Task{isUserValid = await validateCredentials()}
                        }
                    }.padding(10).navigationDestination(isPresented: $isUserValid){
                        userHomeView().navigationBarBackButtonHidden(true)
                    }
                    if isLoginError{
                        Text("Invalid Email Or Password").foregroundColor(.red).padding(.top, 5)
                    }
                    Text("Forgot Password?").onTapGesture{ // highlight blue on hover
                        isPasswordReset.toggle()
                    }
                    HStack{
                        Text("Don't have an account? ")
                        NavigationLink(destination: registrationView().navigationBarBackButtonHidden(true)){
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
                                    _ = Task{isResetValid = await userPasswordReset()}
                                    if isResetValid{
                                        isResetEdit = ""
                                        resetEditError = false
                                        resetEditErrorMessage = ""
                                    }
                                    isResetResult.toggle()
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
    
    private func validateCredentials() async-> Bool{
        var isCredentialValid: Bool = false
        do{
            try await Auth.auth().signIn(withEmail: isUserEmail, password: isUserPassword)
            if isLoginError {isLoginError.toggle()}
            isCredentialValid.toggle()
        } catch{
            isLoginError.toggle()
            print(error.localizedDescription)
        }
        return isCredentialValid
    }
    
    private func userPasswordReset() async ->Bool{
        var isResetPasswordSent: Bool = false
        do{
            try await Auth.auth().sendPasswordReset(withEmail: isResetEdit) // Doesnt check if email is part of the databse
            isResetMessage = "Email Successfully Sent"
            isResetPasswordSent.toggle()
        } catch{
            isResetMessage = error.localizedDescription
        }
        return isResetPasswordSent
    }
}

class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate{
    var onPlayCompletion: (()->Void)?
    var onErrorOccurence: ((Error)->Void)?
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        onPlayCompletion?()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: (any Error)?){
        if let hasError = error{
            print("Audio player decode error: \(error?.localizedDescription ?? "Unknown Error")")
            onErrorOccurence?(hasError)
        }
    }
}

struct userHomeView: View{
    @State private var isInitialLoad = true
    static let isUser = Auth.auth().currentUser
    @State private var isErrorOccurrence: Bool = false
    @State private var isCardWord: Bool = true
    @State private var isFavourite: Bool = false
    @State private var isLearnLanguages: [String] = []
    @State private var isWordLanguage: String = ""
    @State private var isWord: String = "Word"
    @State private var isPhonetic: String = "Phonetic-Spelling"
    @State private var isPronunciation: String = ""
    @State private var isLanguageEntryID: Int = 0
    @State private var isPreviousWords: [String:[Int]] = [:]
    @State private var indexingPreviousWords: (isLanguage: String, isIndex: Int, isCurrent: Bool) = ("", -1, true)
    @State private var isLanguageIndex: Int = -1
    @State private var isSpeechSynthesizer: AVSpeechSynthesizer?
    @State private var speechSynthesizerLanguages: [String] = []
    
    
    @State private var hasUserImage: Bool = false
    @State private var viewSettings: Bool = false
    @State private var isProfileNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isSettingNavigation: Bool = false
    @State private var signOutNavigation: Bool = false
    @State private var isThemeNavigation: Bool = false
    @State private var hasMicrophoneAccess: Bool = false
    @State private var isAudioRecording: Bool = false
    @State private var hasRecorderError: Bool = false
    @State private var isAudioRecorder: AVAudioRecorder?
    @State private var isAudioSession: AVAudioSession?
    @State private var isAudioURL: URL?
    @State private var isAudioPlayer: AVAudioPlayer?
    @State private var isAudioPlaying: Bool = false
    @State private var hasPlayerError: Bool = false
    @State private var hasSpeechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en_US"))
    @State private var hasSpeechRecognizerAccess: Bool = false
    @State private var isAudioEngine = AVAudioEngine()
    @State private var speechRecognitionTask: SFSpeechRecognitionTask?
    @State private var isBufferRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    @State private var isAudioText: String = ""
    @State private var isAudioDelegate: AudioPlayerDelegate?
    
    @State private var isWordInputNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    init(){
        guard userHomeView.isUser != nil else{
            isErrorOccurrence.toggle()
            return
        }
    }
    
    var body: some View{
        NavigationStack{
            ZStack{
                VStack{
                    HStack{
                        HStack{
                            Image(systemName:"square.grid.2x2.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{isThemeNavigation.toggle()}.navigationDestination(isPresented: $isThemeNavigation){languageThemeView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"person.circle.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 10).onTapGesture{viewSettings.toggle()}
                    }.frame(maxHeight: .infinity, alignment:.top).padding(.top, 10)
                    VStack{
                        VStack{
                            HStack{
                                if isCardWord{
                                    Image(systemName: isFavourite ? "star.fill" : "star").resizable().scaledToFit().frame(width: 25, height: 25).padding(.top, 5).onTapGesture{
                                        _ = Task{ _ = await isWordFavourite()}
                                    }
                                }
                            }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                        }.frame(maxHeight: .infinity, alignment: .top)
                        Text(isCardWord ? "\(isWord)" : "\(isPhonetic)").rotation3DEffect(.degrees(isCardWord ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                        VStack{
                            HStack{
                                if isCardWord{
                                    Image(systemName: "speaker.wave.3.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.bottom, 5)
                                }
                            }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                        }.frame(maxHeight: .infinity, alignment: .bottom)
                    }.frame(width: 375, height: 200).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10)).rotation3DEffect(.degrees(isCardWord ? 0 : 180), axis: (x: 0, y: 1, z: 0)).onTapGesture{
                        withAnimation(.linear(duration: 1)){isCardWord.toggle()}
                    }.padding(.vertical, 10)
                    HStack{ //Will extend more on pausing and handling interruptions later.
                        HStack{
                            Image(systemName: "arrowshape.left.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).onTapGesture{
                            _ = Task{_ = await navigateWordSelection(navigationChoice: "preceding")}
                        }
                        HStack{
                            Image(systemName: isAudioPlaying ? "play.circle.fill" : "play.circle").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.onTapGesture{
                            if isAudioPlaying{
                                //isAudioPlayer?.pause()
                            } else{
                                hasPlayerError = playUserRecording()
                            }
                        }
                        HStack{
                            Image(systemName: "stop.circle").resizable().scaledToFit().frame(width: 50, height: 50)
                        }
                        HStack{
                            Image(systemName: isAudioRecording ? "mic.circle.fill" : "mic.circle").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.onTapGesture{
                            if isAudioRecording{
                                isAudioRecorder?.stop()
                                isAudioRecording.toggle()
                                var isTranslation = speechToText()
                            } else{
                                _ = Task{hasRecorderError = await getUserRecording()}
                            }
                        }
                        HStack{
                            Image(systemName: "arrowshape.right.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 10).onTapGesture{
                            _ = Task{_ = await navigateWordSelection(navigationChoice: "proceeding")}
                        }
                    }.padding(.vertical, 10)
                    VStack{
                        Text("Transcribed Audio: \(isAudioText)")
                    }.frame(width: 375, height: 275).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.vertical, 10)
                    HStack{
                        HStack{
                            Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10)
                        HStack{
                            Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                        HStack{
                            Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
                    }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
                }.navigationDestination(isPresented: $isErrorOccurrence){errorView().navigationBarBackButtonHidden(true)}.navigationDestination(isPresented: $signOutNavigation){contentPageView().navigationBarBackButtonHidden(true)}.task{
                    if isInitialLoad{
                        do{
                            _ = try await initialLoading()
                            isInitialLoad.toggle()
                        } catch{
                            print(error.localizedDescription)
                            isErrorOccurrence.toggle()
                        }
                    }
                }
            }.overlay{
                if viewSettings{
                    VStack{
                        HStack{
                            Image(systemName:"person.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            Text("Profile").font(.title2)
                        }.onTapGesture{isProfileNavigation.toggle()}.navigationDestination(isPresented: $isProfileNavigation){userProfileView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName: "cart.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            Text("Store").font(.title2)
                        }.onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"star.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            Text("Favourites").font(.title2)
                        }.onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName: "gear").resizable().scaledToFit().frame(width: 25, height: 25)
                            Text("Setting").font(.title2)
                        }.onTapGesture{isSettingNavigation.toggle()}.navigationDestination(isPresented: $isSettingNavigation){userSettingView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"rectangle.portrait.and.arrow.right").resizable().scaledToFit().frame(width: 25, height: 25)
                            Text("Sign Out").font(.title2)
                        }.onTapGesture{signOutNavigation = userSignOut()}
                    }.padding(10).background(Color(UIColor.systemGray4)).clipShape(RoundedRectangle(cornerRadius: 5))/*.frame(maxWidth: .infinity, alignment: .trailing)*/.padding(.trailing, 5).offset(y: -215)
                }
            }
        }
    }
    
    private func initialLoading()async throws->Bool{
        var isPropertySet: Bool = false
        guard let isUserID = userHomeView.isUser?.uid else{return false}
        do{
            let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
            guard isUserDocument.exists else{return false}
            guard let getLearnLanguageField = isUserDocument.data()?["learnLanguage"] as? [String] else{return false}
            isLearnLanguages = getLearnLanguageField
            guard let getWordLanguage = getLearnLanguageField.randomElement() else{return false}
            isWordLanguage = getWordLanguage
            let isEntriesCount = 39849 + 1 // get actual size
            let isRandomID = Int.random(in: 0...isEntriesCount)
            let isRandomEntry = try await Firestore.firestore().collection(isWordLanguage).document(String(isRandomID)).getDocument()
            guard isRandomEntry.exists else{return false}
            isLanguageEntryID = isRandomID
            guard let getWordField = isRandomEntry.data()?["isWord"] as? String else{return false}
            isWord = getWordField
            guard let getPhoneticField = isRandomEntry.data()?["isPhonetic"] as? String else{return false}
            isPhonetic = getPhoneticField
            guard let getPronunciationField = isRandomEntry.data()?["isPronunciation"] as? String else{return false}
            isPronunciation = getPronunciationField
            isPropertySet.toggle()
        } catch{
            print(error.localizedDescription)
        }
        //let isLanguageEntries = try await isDataBase.collection("en_US").getDocuments()
        //let isEntriesCount = isLanguageEntries.count
        return isPropertySet
    }

    private func isWordFavourite() async -> Bool{
        var isFavouriteSet: Bool = false
        var hasFavouriteField: Bool = false
        guard let isUserID = userHomeView.isUser?.uid else{return false}
        do{
            let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
            guard isUserDocument.exists else{return false}
            if isUserDocument.data()?.keys.contains("favouriteWords") ?? false{
                hasFavouriteField.toggle()
            }
            if hasFavouriteField{
                guard var isLanguageFavourites = isUserDocument.data()?["favouriteWords"] as? [String:[Int]] else{return false}
                if var hasLanguageEntry = isLanguageFavourites[isWordLanguage]{
                    if hasLanguageEntry.contains(isLanguageEntryID){
                        let languageEntryCount = hasLanguageEntry.count
                        hasLanguageEntry.removeAll{ $0 == isLanguageEntryID}
                        isLanguageFavourites[isWordLanguage] = hasLanguageEntry
                        try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords":isLanguageFavourites], merge: true)
                        if languageEntryCount == 1{
                            isLanguageFavourites.removeValue(forKey: isWordLanguage)
                            try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords": isLanguageFavourites], merge: true)
                        }
                    } else{
                        hasLanguageEntry.append(isLanguageEntryID)
                        isLanguageFavourites[isWordLanguage] = hasLanguageEntry
                        try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords":isLanguageFavourites], merge: true)
                    }
                } else{
                    let isUserWord: [String:[Int]] = [isWordLanguage : [isLanguageEntryID]]
                    try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords": isUserWord], merge: true)
                }
            } else{
                let isUserWord: [String:[Int]] = [isWordLanguage : [isLanguageEntryID]]
                try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords": isUserWord], merge: true)
            }
            isFavourite.toggle()
            isFavouriteSet.toggle()
        } catch{
            print(error.localizedDescription)
        }
        return isFavouriteSet
    }
    
    private func navigateWordSelection(navigationChoice: String)async->Bool{ // check favourites
        if isFavourite {isFavourite.toggle()}
        var hasNavigated: Bool = false
        if navigationChoice == "preceding"{
            if indexingPreviousWords.isCurrent {indexingPreviousWords.isCurrent.toggle()}
            if indexingPreviousWords.isLanguage == ""{
                isLanguageIndex = isPreviousWords.count - 1
                indexingPreviousWords.isLanguage = Array(isPreviousWords.keys)[isLanguageIndex]
                indexingPreviousWords.isIndex = (isPreviousWords[indexingPreviousWords.isLanguage]?.count ?? -1) - 1
            } else{
                indexingPreviousWords.isIndex -= (indexingPreviousWords.isIndex >= 0) ? 1 : 0
                if indexingPreviousWords.isIndex == -1 && isLanguageIndex == 0 {return true}
                if indexingPreviousWords.isIndex == -1 && isLanguageIndex > 0{
                    isLanguageIndex -= 1
                    indexingPreviousWords.isLanguage = Array(isPreviousWords.keys)[isLanguageIndex ]
                    indexingPreviousWords.isIndex = (isPreviousWords[indexingPreviousWords.isLanguage]?.count ?? -1) - 1
                }
            }
            guard let wordIndexReference = isPreviousWords[indexingPreviousWords.isLanguage]?[indexingPreviousWords.isIndex] else{return false}
            do{
                let isPreviousEntry = try await Firestore.firestore().collection(indexingPreviousWords.isLanguage).document(String(wordIndexReference)).getDocument()
                guard isPreviousEntry.exists else{return false}
                guard let getWordField = isPreviousEntry.data()?["isWord"] as? String else{return false}
                isWord = getWordField
                guard let getPhoneticField = isPreviousEntry.data()?["isPhonetic"] as? String else{return false}
                isPhonetic = getPhoneticField
                //guard let getPronunciationField = isPreviousEntry.data()?["isPronunciation"] as? String else{return false}
                //isPronunciation = getPronunciationField
                hasNavigated.toggle()
            } catch{
                print(error.localizedDescription)
            }
            guard let isUserID = userHomeView.isUser?.uid else{return false}
            do{
                let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
                guard isUserDocument.exists else{return false}
                guard let isLanguageFavourites = isUserDocument.data()?["favouriteWords"] as? [String:[Int]] else{return false}
                if isLanguageFavourites[indexingPreviousWords.isLanguage]?.contains(wordIndexReference) ?? false{
                    isFavourite.toggle()
                }
            } catch{
                print(error.localizedDescription)
            }
        } else if navigationChoice == "proceeding"{
            if indexingPreviousWords.isCurrent{
                let isPreviousCount = isPreviousWords.values.reduce(0){$0 + $1.count}
                if isPreviousCount == 10{
                    guard let firstEntry = isPreviousWords.keys.first else{return false}
                    guard var entryIndexes = isPreviousWords[firstEntry] else{return false}
                    entryIndexes.removeFirst()
                    isPreviousWords[firstEntry] = entryIndexes
                }
                if var isIndexes = isPreviousWords[isWordLanguage]{
                    isIndexes.append(isLanguageEntryID)
                    isPreviousWords[isWordLanguage] = isIndexes
                } else{
                    isPreviousWords[isWordLanguage] = [isLanguageEntryID]
                }
                do{
                    guard let getLanguage = isLearnLanguages.randomElement() else{return false}
                    isWordLanguage = getLanguage
                    let isEntriesCount = 39849 + 1
                    let isRandomID = Int.random(in: 0...isEntriesCount)
                    let isRandomEntry = try await Firestore.firestore().collection(isWordLanguage).document(String(isRandomID)).getDocument()
                    guard isRandomEntry.exists else{return false}
                    isLanguageEntryID = isRandomID
                    guard let getWordField = isRandomEntry.data()?["isWord"] as? String else{return false}
                    isWord = getWordField
                    guard let getPhoneticField = isRandomEntry.data()?["isPhonetic"] as? String else{return false}
                    isPhonetic = getPhoneticField
                    //guard let getPronunciationField = isRandomEntry.data()?["isPronunciation"] as? String else{return false}
                    //isPronunciation = getPronunciationField
                    hasNavigated.toggle()
                } catch{
                    print(error.localizedDescription)
                }
                guard let isUserID = userHomeView.isUser?.uid else{return false}
                do{
                    let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
                    guard isUserDocument.exists else{return false}
                    guard let isLanguageFavourites = isUserDocument.data()?["favouriteWords"] as? [String:[Int]] else{return false}
                    if isLanguageFavourites[isWordLanguage]?.contains(isLanguageEntryID) ?? false{
                        isFavourite.toggle()
                    }
                } catch{
                    print(error.localizedDescription)
                }
            } else{
                var getCurrentWord: Bool = false
                indexingPreviousWords.isIndex += (indexingPreviousWords.isIndex == -1) ? 2 : (indexingPreviousWords.isIndex < isPreviousWords[indexingPreviousWords.isLanguage]?.count ?? -1) ? 1 : 0
                if indexingPreviousWords.isIndex == isPreviousWords[indexingPreviousWords.isLanguage]?.count ?? -1 && isLanguageIndex >= 0{
                    if isLanguageIndex + 1 < Array(isPreviousWords.keys).count{
                        isLanguageIndex += 1
                        indexingPreviousWords.isLanguage = Array(isPreviousWords.keys)[isLanguageIndex]
                        indexingPreviousWords.isIndex = 0
                    } else{
                        getCurrentWord.toggle()
                    }
                }
                guard let wordIndexReference = getCurrentWord ? 0 : isPreviousWords[indexingPreviousWords.isLanguage]?[indexingPreviousWords.isIndex] else{return false}
                do{
                    let isPreviousEntry = try await Firestore.firestore().collection(getCurrentWord ? isWordLanguage : indexingPreviousWords.isLanguage).document(getCurrentWord ? String(isLanguageEntryID) : String(wordIndexReference)).getDocument()
                    guard isPreviousEntry.exists else{return false}
                    guard let getWordField = isPreviousEntry.data()?["isWord"] as? String else{return false}
                    isWord = getWordField
                    guard let getPhoneticField = isPreviousEntry.data()?["isPhonetic"] as? String else{return false}
                    isPhonetic = getPhoneticField
                    //guard let getPronunciationField = isPreviousEntry.data()?["isPronunciation"] as? String else{return false}
                    //isPronunciation = getPronunciationField
                    hasNavigated.toggle()
                } catch{
                    print(error.localizedDescription)
                }
                if getCurrentWord{
                    indexingPreviousWords.isLanguage = ""
                    indexingPreviousWords.isIndex = -1
                    indexingPreviousWords.isCurrent.toggle()
                }
                guard let isUserID = userHomeView.isUser?.uid else{return false}
                do{
                    let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
                    guard isUserDocument.exists else{return false}
                    guard let isLanguageFavourites = isUserDocument.data()?["favouriteWords"] as? [String:[Int]] else{return false}
                    if isLanguageFavourites[getCurrentWord ? isWordLanguage : indexingPreviousWords.isLanguage]?.contains(wordIndexReference) ?? false{
                        isFavourite.toggle()
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        return hasNavigated
    }
    
    private func accessAudioFile(){}
    
    private func generatePhoneticSpelling()->Bool{
        var isPhoneticGenerated: Bool = false
        return isPhoneticGenerated
    }
    
    private func generatePronunciation()->Bool{
        var isPronunciationGenerated: Bool = false
        return isPronunciationGenerated
    }
    
    private func textToSpeech()->Bool{ // Allow user to change male or female voice
        var isTextSynthesized: Bool = false
        let isSpeechUtterance = AVSpeechUtterance(string: isWord)
        for isVoice in AVSpeechSynthesisVoice.speechVoices(){
            if !speechSynthesizerLanguages.contains(isVoice.language){
                speechSynthesizerLanguages.append(isVoice.language)
            }
        }
        if !speechSynthesizerLanguages.contains(isWordLanguage){return false}
        isSpeechUtterance.voice = AVSpeechSynthesisVoice(language: isWordLanguage)
        isSpeechUtterance.rate = 0.5 // Add a function for user to modify
        isSpeechUtterance.pitchMultiplier = 1.0 // Add function for user to modify
        isSpeechSynthesizer = AVSpeechSynthesizer()
        isSpeechSynthesizer?.speak(isSpeechUtterance)
        isTextSynthesized.toggle()
        return isTextSynthesized
    }
    
    private func endTextToSpeech(){
        //if isSpeechSynthesizer?.isSpeaking{
            isSpeechSynthesizer?.stopSpeaking(at: .immediate)
        //}
    }
    
    private func playUserRecording()->Bool{
        var isPlayerValid: Bool = false
        if isAudioDelegate == nil{
            isAudioDelegate = AudioPlayerDelegate()
            isAudioDelegate?.onPlayCompletion = {
                self.isAudioPlaying.toggle()
            }
            isAudioDelegate?.onErrorOccurence = { error in
            //log error message
            }
        }
        do{
            guard let hasAudioURL = isAudioURL else{return false}
            isAudioPlayer = try AVAudioPlayer(contentsOf: hasAudioURL)
            isAudioPlayer?.delegate = isAudioDelegate
            isAudioPlayer?.play()
            isPlayerValid.toggle()
            isAudioPlaying.toggle()
        }
        catch{
            print("Audio Player Error")
            print(error.localizedDescription)
        }
        return isPlayerValid
    }
    
    private func getUserRecording() async->Bool{
        var isRecordingValid: Bool = false
        if await AVAudioApplication.requestRecordPermission(){
            hasMicrophoneAccess.toggle()
        }
        if !hasMicrophoneAccess{return false}
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            if authStatus == .authorized{hasSpeechRecognizerAccess = true}
        }
        if !hasSpeechRecognizerAccess {return false}
        isAudioSession = AVAudioSession.sharedInstance()
        guard let hasAudioSession = isAudioSession else{return false}
        do{
            try hasAudioSession.setCategory(.playAndRecord, mode: .default)
            try hasAudioSession.setActive(true)
            let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            isAudioURL = pathURL.appendingPathComponent("userRecording.m4a")
            let recorderSetting = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 44100, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            guard let hasAudioURL = isAudioURL else {return false}
            isAudioRecorder = try AVAudioRecorder(url: hasAudioURL, settings: recorderSetting)
            isAudioRecorder?.record()
            isRecordingValid.toggle()
            isAudioRecording.toggle()
        } catch{
            print("Audio Recording Error \(error.localizedDescription)")
        }
        return isRecordingValid
    }
    
    private func stopPlayerOrRecorder()->Bool{
        var isStopValid = false
        return isStopValid
    }
    
    private func speechToText()->Bool{ // Given an audio url it will convert it to text
        var isSpeechTranscriptionValid: Bool = false
        guard let isSpeechRecognizer = hasSpeechRecognizer else {return false}
        if !isSpeechRecognizer.isAvailable{
            print("Speech Recgonizer Not Available")
            return false
        }
        guard let hasAudioURL = isAudioURL else{return false}
        let isAudioRequest = SFSpeechURLRecognitionRequest(url: hasAudioURL)
        isSpeechRecognizer.recognitionTask(with: isAudioRequest){ result, error in
            if let isRecognizerError = error{
                print(isRecognizerError.localizedDescription)
            }
            guard let hasResult = result else {return}
            isAudioText = hasResult.bestTranscription.formattedString
            isSpeechTranscriptionValid.toggle()
        }
        return isSpeechTranscriptionValid
    }
    
    private func isRealTimeSpeechToText()->Bool{ // Not smart and outright bad to pause audio intake for this function
        var isLiveTranslation: Bool = false
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            if authStatus == .authorized{hasSpeechRecognizerAccess = true}
        }
        if !hasSpeechRecognizerAccess {return false}
        isAudioSession = AVAudioSession.sharedInstance()
        guard let hasAudioSession = isAudioSession else{return false}
        do{
            try hasAudioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try hasAudioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let isInputNode = isAudioEngine.inputNode
            isBufferRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            isBufferRecognitionRequest?.shouldReportPartialResults = true
            //isBufferRecognitionRequest?.requiresOnDeviceRecognition = true //For offline use
            guard let hasBufferRecognitionRequest = isBufferRecognitionRequest else{return false}
            speechRecognitionTask = hasSpeechRecognizer?.recognitionTask(with: hasBufferRecognitionRequest){ result, error in
                if let isRecognizerError = error{
                    print(isRecognizerError.localizedDescription)
                }
                guard let hasResult = result else {return}
                isAudioText = hasResult.bestTranscription.formattedString
            }
            isInputNode.installTap(onBus: 0, bufferSize: 1024, format: isInputNode.inputFormat(forBus: 0)){ buffer, time in // using ,outputFormat makes the this function work as translating after user audio input. Hence not in real time
                isBufferRecognitionRequest?.append(buffer)
            }
            isAudioEngine.prepare()
            try isAudioEngine.start()
            isLiveTranslation.toggle()
        } catch{
            print("Audio Recording Error \(error.localizedDescription)")
        }
        return isLiveTranslation
    }
    
    private func endLiveSpeechToText(){
        isAudioEngine.stop()
        speechRecognitionTask?.finish()
    }
    
    private func userSignOut()->Bool{
        var isSignOutValid: Bool = true
        do{
            try Auth.auth().signOut()
        } catch{
            isSignOutValid = false
            print(error.localizedDescription)
        }
        return isSignOutValid
    }
    
    private func uploadFile() async -> Bool{
        var isUploadSucess: Bool = false
        guard let sourceFileURL = Bundle.main.url(forResource: "eng_US", withExtension: "json") else{print("File not found")
        return false}
        var sourceJSONObject: [[String: Any]]?
        do{
            let isSourceData = try Data(contentsOf: sourceFileURL)
            sourceJSONObject = try JSONSerialization.jsonObject(with: isSourceData, options: []) as? [[String:Any]]
        } catch{
            print(error.localizedDescription)
        }
        guard let hasSourceJSON = sourceJSONObject else{return false}
        let isDataBase = Firestore.firestore()
        for entry in hasSourceJSON{
            guard let entryID = entry["isID"] as? Int else{break}
            let isDocumentID = String(entryID)
            do{
                try await isDataBase.collection("eng_US").document(isDocumentID).setData(entry, merge: true)
                isUploadSucess = true
            } catch{
                print(error)
            }
        }
        return isUploadSucess
    }
}

struct languageThemeView: View{
    @State private var themeOptions: [String] = ["Category1", "Category2", "Category3", "Category4", "Category5", "Category6", "Category7", "Category8", "Category9"]
    @State private var isGridColumn = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    @State private var isHomeNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    var body: some View{
        NavigationStack{
            VStack{
                ScrollView{
                    VStack{
                        Text("Theme").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                        LazyVGrid(columns: isGridColumn, spacing: 5){
                            ForEach(themeOptions, id: \.self){ isTheme in
                                VStack{
                                    Image(systemName: "arrow.left").resizable().scaledToFit().frame(width: 170, height: 170)
                                    Text("\(isTheme)")
                                }.padding(10).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))//.padding(.horizontal, 10)
                            }
                        }
                    }
                }.frame(height: 690)
                HStack{
                    HStack{
                        Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                    HStack{
                        Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
                }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
            }
        }
    }
}

struct userProfileView: View{
    let isUser = userHomeView.isUser
    enum editFocus: Hashable{
        case editName
        case editEmail
        case editPassword
        case editPasswordConfirm
    }
    @State private var isUserName: String = "Testing"
    @State private var isNameEdit: Bool = false
    @State private var isUserGender: String = "Male"
    @State private var isGenderEdit: Bool = false
    @State private var isUserBirthday: String = "1/1/2024"
    @State private var isBirthdayEdit: Bool = false
    @State private var isUserEmail: String = "demo@testing.com"
    @State private var isEmailEdit: Bool = false
    @State private var isUserPassword: String = "demo"
    @State private var isPasswordEdit: Bool = false
    @State private var isAccountDeletion: Bool = false
    
    @State private var isVerificationString: String = ""
    @FocusState private var isVerificationFocus: Bool
    @State private var isVerificationVisible: Bool = false
    @State private var isVerificationError: Bool = false
    @State private var verificationErrorMessage: String = ""
    @State private var isUserVerified: Bool = false
    @State private var isEditString: String = ""
    @State private var isEditVisible: Bool = false
    @FocusState private var isEditFocus: editFocus?
    @State private var isEditError: Bool = false
    @State private var editErrorMessage: String = ""
    @State private var isEditConfirm: String = ""
    @State private var isEditConfirmVisible: Bool = false
    @State private var isEditConfirmError: Bool = false
    @State private var editConfirmErrorMessage:String = ""
    @State private var isEditValid: Bool = false
    @State private var isEditResult: Bool = false
    @State private var isEditReport: String = ""
    @State private var isOverlayView: Bool = false
    
    @State private var isHomeNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    init(){
        self.isVerificationFocus = false
    }
    
    var body: some View{
        NavigationStack{
            ZStack{
                if isOverlayView{
                    Color.black.opacity(0.5).ignoresSafeArea(.all).onTapGesture{backgroundOverlayCollapse()}
                }
                VStack{
                    Text("User Profile").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                    ZStack(alignment: .bottomTrailing){
                        Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 150, height: 150, alignment: .center).clipShape(Circle()).overlay(Circle().stroke(.pink, lineWidth: 2))
                        Circle().fill(.blue).frame(width: 50, height: 50).overlay(Circle().stroke(.white, lineWidth: 3)).overlay(Image(systemName: "plus").resizable().scaledToFit().frame(width: 25, height: 25).padding(5).foregroundStyle(.white))//.overlay(Circle().stroke(.white, lineWidth: 3)).background(.blue)
                    }
                    HStack{
                        VStack{
                            Text("USERNAME").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                            Text("\(isUserName)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10).onTapGesture{
                        if isOverlayView{
                            backgroundOverlayCollapse()
                        } else{
                            isOverlayView.toggle()
                            isNameEdit.toggle()
                        }
                    }
                    HStack{
                        VStack{
                            Text("GENDER").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                            Text("\(isUserGender)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        }
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10).onTapGesture{
                        if isOverlayView{
                            backgroundOverlayCollapse()
                        } else{
                            isOverlayView.toggle()
                            isGenderEdit.toggle()
                        }
                    }
                    HStack{
                        VStack{
                            Text("DATE OF BIRTH").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                            Text("\(isUserBirthday)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        }
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10).onTapGesture{
                        if isOverlayView{
                            backgroundOverlayCollapse()
                        } else{
                            isOverlayView.toggle()
                            isBirthdayEdit.toggle()
                        }
                    }
                    HStack{
                        VStack{
                            Text("EMAIL ADDRESS").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                            Text("\(isUserEmail)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        }
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10).onTapGesture{
                        if isOverlayView{
                            backgroundOverlayCollapse()
                        } else{
                            isOverlayView.toggle()
                            isEmailEdit.toggle()
                        }
                    }
                    HStack{
                        VStack{
                            Text("PASSWORD").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                            Text("\(isUserPassword)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        }
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10).onTapGesture{
                        if isOverlayView{
                            backgroundOverlayCollapse()
                        } else{
                            isOverlayView.toggle()
                            isPasswordEdit.toggle()
                        }
                    }
                    HStack{
                        HStack{
                            Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                        HStack{
                            Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
                    }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
                }//.ignoresSafeArea(.all).background(.gray)
            }.overlay(alignment: .center){
                if isNameEdit{
                    VStack{
                        ZStack{
                            HStack{
                                Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                isNameEdit.toggle()
                                isOverlayView.toggle()
                                isEditString = ""
                                isEditError = false
                                editErrorMessage = ""
                            }
                        }
                        Text("Change UserName")
                        Text("Username").frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                            TextField("Username", text: $isEditString).focused($isEditFocus, equals: .editName).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                if !isEditString.isEmpty && isEditError{
                                    isEditError.toggle()
                                }
                            }.onChange(of: isEditFocus, {
                                if isEditFocus != .editName{
                                    if !isEditString.isEmpty && isEditError{
                                        isEditError.toggle()
                                    }
                                }
                            })
                        }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                        if isEditError{
                            Text(editErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                        }
                        Text("Confirm").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                            if isEditString.isEmpty{
                                editErrorMessage = "Please enter your username"
                                isEditError = true
                            } else if isEditString == isUserName{
                                editErrorMessage = "Please a new username"
                                isEditError = true
                            } else{
                                isEditValid = updateUserName()
                                isEditResult.toggle()
                                if isEditValid{
                                    isEditString = ""
                                    isEditError = false
                                    editErrorMessage = ""
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {isEditResult.toggle()})
                            }
                        }
                        if isEditResult{
                            Text(isEditReport).foregroundColor(.green).padding(.top, 5)
                        }
                    }.padding(10).background(.white).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                        isEditFocus = nil
                    }
                }
                if isGenderEdit{
                    VStack{
                        ZStack{
                            HStack{
                                Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                isGenderEdit.toggle()
                                isOverlayView.toggle()
                            }
                        }
                        Text("Change Gender")
                    }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                        isEditFocus = nil
                    }
                }
                if isBirthdayEdit{
                    VStack{
                        ZStack{
                            HStack{
                                Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                            }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                isBirthdayEdit.toggle()
                                isOverlayView.toggle()
                            }
                        }
                        Text("Change Birthday")
                    }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                        isEditFocus = nil
                    }
                }
                if isEmailEdit{
                    if !isUserVerified{
                        VStack{
                            ZStack{
                                HStack{
                                    Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                                }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                    isEmailEdit.toggle()
                                    isOverlayView.toggle()
                                    isVerificationString = ""
                                    isVerificationFocus = false
                                    isVerificationVisible = false
                                    isVerificationError = false
                                    verificationErrorMessage = ""
                                }
                            }
                            Text("Verify Password")
                            HStack{
                                Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.black)
                                if(!isVerificationVisible){
                                    SecureField("Password", text: $isVerificationString).focused($isVerificationFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isVerificationString.isEmpty && isVerificationError{
                                            isVerificationError.toggle()
                                        }
                                    }.onChange(of: isVerificationFocus, {
                                        if !isVerificationFocus{
                                            if !isVerificationString.isEmpty && isVerificationError{
                                                isVerificationError.toggle()
                                            }
                                        }
                                    })
                                } else{
                                    TextField("Password", text: $isVerificationString).focused($isVerificationFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isVerificationString.isEmpty && isVerificationError{
                                            isVerificationError.toggle()
                                        }
                                    }.onChange(of: isVerificationFocus, {
                                        if !isVerificationFocus{
                                            if !isVerificationString.isEmpty && isVerificationError{
                                                isVerificationError.toggle()
                                            }
                                        }
                                    })
                                }
                                Button(action:{isVerificationVisible.toggle()}){
                                    Image(systemName: !isVerificationVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 1))
                            if isVerificationError{
                                Text(verificationErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                            }
                            Text("Confirm Password").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                                isVerificationFocus = false
                                if isVerificationString.isEmpty{
                                    verificationErrorMessage = "Please enter your password"
                                    isVerificationError = true
                                } else if isVerificationString != isUserPassword{
                                    verificationErrorMessage = "Incorrect Password"
                                    isVerificationError = true
                                } else{
                                    isUserVerified.toggle()
                                    isVerificationString = ""
                                    isVerificationFocus = false
                                    isVerificationVisible = false
                                    isVerificationError = false
                                    verificationErrorMessage = ""
                                }
                            }
                        }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                            isVerificationFocus = false
                        }
                    } else{
                        VStack{
                            ZStack{
                                HStack{
                                    Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                                }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                    isUserVerified.toggle()
                                    isEmailEdit.toggle()
                                    isOverlayView.toggle()
                                    isEditString = ""
                                    isEditFocus = nil
                                    isEditError = false
                                    editErrorMessage = ""
                                }
                            }
                            Text("Enter A New Email Address")
                            Text("Email").frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image(systemName: "envelope.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 2).foregroundStyle(.gray)
                                TextField("Email Address", text: $isEditString).focused($isEditFocus, equals: .editEmail).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                    if !isEditString.isEmpty && editErrorMessage.contains("enter") && isEditError{
                                        isEditError.toggle()
                                    }
                                }.onChange(of: isEditFocus, {
                                    if isEditFocus != .editEmail{
                                        if !isEditString.isEmpty && editErrorMessage.contains("enter") && isEditError{
                                            isEditError.toggle()
                                        }
                                    }
                                })
                            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                            if isEditError{
                                Text(editErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                            }
                            Text("Confirm").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                                if isEditString.isEmpty{
                                    editErrorMessage = "Please enter your email address"
                                    isEditError = true
                                } else if isEditString == isUserEmail{
                                    editErrorMessage = "Please enter a new email address"
                                    isEditError = true
                                } else{
                                    let isEmailRegex: String = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
                                    let isEmailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", isEmailRegex)
                                    let isValidAddress = isEmailPredicate.evaluate(with: isEditString)
                                    if !isValidAddress{
                                        editErrorMessage = "Invalid email address"
                                        isEditError = true
                                    }
                                    if isValidAddress && isEditError{
                                        isEditError.toggle()
                                    }
                                    if !isEditError{
                                        isEditValid = updateUserEmail()
                                        isEditResult.toggle()
                                        if isEditValid{
                                            isEditString = ""
                                            isEditFocus = nil
                                            editErrorMessage = ""
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {isEditResult.toggle()})
                                    }
                                }
                            }
                            if isEditResult{
                                Text(isEditReport).foregroundColor(.green).padding(.top, 5)
                            }
                        }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                            isEditFocus = nil
                        }
                    }
                }
                if isPasswordEdit{
                    if !isUserVerified{
                        VStack{
                            ZStack{
                                HStack{
                                    Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                                }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                    isPasswordEdit.toggle()
                                    isOverlayView.toggle()
                                    isVerificationString = ""
                                    isVerificationFocus = false
                                    isVerificationVisible = false
                                    isVerificationError = false
                                    verificationErrorMessage = ""
                                }
                            }
                            Text("Verify Password")
                            HStack{
                                Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.black)
                                if(!isVerificationVisible){
                                    SecureField("Password", text: $isVerificationString).focused($isVerificationFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isVerificationString.isEmpty && isVerificationError{
                                            isVerificationError.toggle()
                                        }
                                    }.onChange(of: isVerificationFocus, {
                                        if !isVerificationFocus{
                                            if !isVerificationString.isEmpty && isVerificationError{
                                                isVerificationError.toggle()
                                            }
                                        }
                                    })
                                } else{
                                    TextField("Password", text: $isVerificationString).focused($isVerificationFocus).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isVerificationString.isEmpty && isVerificationError{
                                            isVerificationError.toggle()
                                        }
                                    }.onChange(of: isVerificationFocus, {
                                        if !isVerificationFocus{
                                            if !isVerificationString.isEmpty && isVerificationError{
                                                isVerificationError.toggle()
                                            }
                                        }
                                    })
                                }
                                Button(action:{isVerificationVisible.toggle()}){
                                    Image(systemName: !isVerificationVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 1))
                            if isVerificationError{
                                Text(verificationErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                            }
                            Text("Confirm Password").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                                isVerificationFocus = false
                                if isVerificationString.isEmpty{
                                    verificationErrorMessage = "Please enter your password"
                                    isVerificationError = true
                                } else if isVerificationString != isUserPassword{
                                    verificationErrorMessage = "Incorrect Password"
                                    isVerificationError = true
                                } else{
                                    isUserVerified.toggle()
                                    isVerificationString = ""
                                    isVerificationFocus = false
                                    isVerificationVisible = false
                                    isVerificationError = false
                                    verificationErrorMessage = ""
                                }
                            }
                        }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                            isVerificationFocus = false
                        }
                    } else{
                        VStack{
                            ZStack{
                                HStack{
                                    Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                                }.frame(maxWidth: .infinity, alignment: .topTrailing).onTapGesture{
                                    isUserVerified.toggle()
                                    isPasswordEdit.toggle()
                                    isOverlayView.toggle()
                                    isEditString = ""
                                    isEditFocus = nil
                                    isEditError = false
                                    editErrorMessage = ""
                                    isEditConfirm = ""
                                    isEditConfirmVisible = false
                                    isEditConfirmError = false
                                    editConfirmErrorMessage = ""
                                }
                            }
                            Text("Enter A New Password")
                            Text("Password").frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.gray)
                                if(!isEditVisible){
                                    SecureField("Password", text: $isEditString).focused($isEditFocus, equals: .editPassword).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isEditString.isEmpty && isEditError{
                                            isEditError.toggle()
                                        }
                                    }.onChange(of: isEditFocus, {
                                        if isEditFocus != .editPassword{
                                            if !isEditString.isEmpty && isEditError{
                                                isEditError.toggle()
                                            }
                                        }
                                    })
                                } else{
                                    TextField("Password", text: $isEditString).focused($isEditFocus, equals: .editPassword).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isEditString.isEmpty && isEditError{
                                            isEditError.toggle()
                                        }
                                    }.onChange(of: isEditFocus, {
                                        if isEditFocus != .editPassword{
                                            if !isEditString.isEmpty && isEditError{
                                                isEditError.toggle()
                                            }
                                        }
                                    })
                                }
                                Button(action:{isEditVisible.toggle()}){
                                    Image(systemName: !isEditVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                            if isEditError{
                                Text(editErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                            }
                            Text("Confirm Password").frame(maxWidth: .infinity, alignment: .leading)
                            HStack{
                                Image(systemName: "lock.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.leading, 1).foregroundStyle(.gray)
                                if(!isEditConfirmVisible){
                                    SecureField("Confirm Password", text: $isEditConfirm).focused($isEditFocus, equals: .editPasswordConfirm).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isEditConfirm.isEmpty && editConfirmErrorMessage.contains("enter") && isEditConfirmError{
                                            isEditConfirmError.toggle()
                                        }
                                        if isEditConfirm == isEditString && editConfirmErrorMessage.contains("match") && isEditConfirmError{
                                            isEditConfirmError.toggle()
                                        }
                                    }.onChange(of: isEditFocus, {
                                        if isEditFocus != .editPasswordConfirm{
                                            if !isEditConfirm.isEmpty && editConfirmErrorMessage.contains("enter") && isEditConfirmError{
                                                isEditConfirmError.toggle()
                                            }
                                            if isEditConfirm == isEditString && editConfirmErrorMessage.contains("match") && isEditConfirmError{
                                                isEditConfirmError.toggle()
                                            }
                                        }
                                    })
                                } else{
                                    TextField("Confirm Password", text: $isEditConfirm).focused($isEditFocus, equals: .editPasswordConfirm).background(Color.white).frame(height:30).textInputAutocapitalization(.never).autocorrectionDisabled(true).onSubmit{
                                        if !isEditConfirm.isEmpty && editConfirmErrorMessage.contains("enter") && isEditConfirmError{
                                            isEditConfirmError.toggle()
                                        }
                                        if isEditConfirm == isEditString && editConfirmErrorMessage.contains("match") && isEditConfirmError{
                                            isEditConfirmError.toggle()
                                        }
                                    }.onChange(of: isEditFocus, {
                                        if isEditFocus != .editPasswordConfirm{
                                            if !isEditConfirm.isEmpty && editConfirmErrorMessage.contains("enter") && isEditConfirmError{
                                                isEditConfirmError.toggle()
                                            }
                                            if isEditConfirm == isEditString && editConfirmErrorMessage.contains("match") && isEditConfirmError{
                                                isEditConfirmError.toggle()
                                            }
                                        }
                                    })
                                }
                                Button(action:{isEditConfirmVisible.toggle()}){
                                    Image(systemName: !isEditConfirmVisible ? "eye.slash" : "eye").resizable().scaledToFit().frame(width: 25, height: 25).padding(.trailing, 2).foregroundStyle(.black)
                                }
                            }.overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                            if isEditConfirmError{
                                Text(editConfirmErrorMessage).foregroundColor(.red).frame(maxWidth: .infinity, alignment: .leading).padding(5)
                            }
                            Text("Confirm").padding(10).foregroundStyle(.blue).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).onTapGesture{
                                if isEditString.isEmpty{
                                    editErrorMessage = "Please enter your password"
                                    isEditError = true
                                } else if isEditString == isUserPassword{
                                    editErrorMessage = "Please a new password"
                                    isEditError = true
                                }
                                if isEditConfirm.isEmpty{
                                    editConfirmErrorMessage = "Please enter your password"
                                    isEditConfirmError = true
                                } else if isEditConfirm != isEditString{
                                    editConfirmErrorMessage = "Passwords dont match"
                                    isEditConfirmError = true
                                }
                                if !isEditError && !isEditConfirmError{
                                    isEditValid = updateUserPassword()
                                    isEditResult.toggle()
                                    if isEditValid{
                                        isEditString = ""
                                        isEditFocus = nil
                                        editErrorMessage = ""
                                        isEditConfirm = ""
                                        isEditConfirmVisible = false
                                        isEditConfirmError = false
                                        editConfirmErrorMessage = ""
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {isEditResult.toggle()})
                                }
                            }
                            if isEditResult{
                                Text(isEditReport).foregroundColor(.green).padding(.top, 5)
                            }
                        }.padding(10).background(.white).border(.black, width: 1).clipShape(RoundedRectangle(cornerRadius: 5)).frame(width: 350).onTapGesture{
                            isEditFocus = nil
                        }
                    }
                }
            }//END
        }
    
    }
    
    private func updateUserName()->Bool{
        var isUpdateValid: Bool = true
        let isUserProfile = isUser?.createProfileChangeRequest()
        isUserProfile?.displayName = isUserName
        isUserProfile?.commitChanges{ error in
            if let userProfileError = error{
                isUpdateValid = false
                isEditReport = userProfileError.localizedDescription
                print(userProfileError)
            } else{
                isEditReport = "Set Successfully"
            }
        }
        return isUpdateValid
    }
    
    private func updateUserEmail()->Bool{
        var isUpdateValid: Bool = true
        isUser?.sendEmailVerification(beforeUpdatingEmail: isEditString){ error in
            if let updateEmailError = error{
                isUpdateValid = false
                isEditReport = updateEmailError.localizedDescription
                print(updateEmailError)
            } else{
                isEditReport = "Set Successfully"
            }
        }
        return isUpdateValid
    }
    
    private func updateUserPassword()->Bool{
        var isUpdateValid: Bool = true
        isUser?.updatePassword(to: isEditString){ error in
            if let updatePasswordError = error{
                isUpdateValid = false
                isEditReport = updatePasswordError.localizedDescription
                print(updatePasswordError)
            } else{
                isEditReport = "Set Successfully"
            }
        }
        return isUpdateValid
    }
    
    private func backgroundOverlayCollapse(){
        if isOverlayView{
            if isNameEdit{isNameEdit.toggle()}
            if isGenderEdit{isGenderEdit.toggle()}
            if isBirthdayEdit{isBirthdayEdit.toggle()}
            if isEmailEdit{isEmailEdit.toggle()}
            if isPasswordEdit{isPasswordEdit.toggle()}
        }
        isOverlayView.toggle()
    }
}

struct userStoreView: View{
    @State private var isHomeNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("Store").font(.largeTitle)
                HStack{
                    HStack{
                        Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                    HStack{
                        Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10)
                    HStack{
                        Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
                }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
            }
        }
    }
}

struct userFavouriteCardsView: View{ // add feature when user clicks the star it removes the word from favourites
    @State private var isFavouriteWords: [String:[Int]] = [:]
    @State private var getFavourtieWords: [String:String] = [:]
    @State private var isDataLoaded: Bool = false
    @State private var isHomeNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("Favourite Words").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                if isDataLoaded{
                    ScrollView{
                        VStack{
                            ForEach(isFavouriteWords.keys.sorted(), id: \.self){ hasLanguageEntry in
                                ForEach(isFavouriteWords[hasLanguageEntry] ?? [], id: \.self){ hasLanguageEntryID in
                                    VStack{
                                        ZStack{
                                            VStack{
                                                HStack{
                                                    Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.top, 5).onTapGesture{
                                                        _ = Task{
                                                            let isEntryRemoved = await removeWord(isWordLanguage: hasLanguageEntry, isLanguageEntryID: hasLanguageEntryID)
                                                            if isEntryRemoved{
                                                                isFavouriteWords[hasLanguageEntry]?.removeAll{$0 == hasLanguageEntryID}
                                                                getFavourtieWords.removeValue(forKey: "\(hasLanguageEntry)_\(hasLanguageEntryID)")
                                                            }
                                                            
                                                        }
                                                    }
                                                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                                            }.frame(maxHeight: .infinity, alignment: .top)
                                            Text(getFavourtieWords["\(hasLanguageEntry)_\(hasLanguageEntryID)"] ?? "Error)").foregroundStyle(.blue).font(.largeTitle)
                                        }
                                    }.frame(width: 350, height: 200).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.vertical, 10)
                                }
                            }
                        }
                    }.frame(height: 600)
                } else{
                    Text("Loading...").font(.headline)
                }
                HStack{
                    HStack{
                        Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10)// return to the top of current view
                    HStack{
                        Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                    HStack{
                        Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
                }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
            }.onAppear{
                _ = Task{
                    let hasLoaded = try await initialLoading()
                    if hasLoaded{
                        isDataLoaded.toggle()
                    }
                }
            }.onDisappear{if isDataLoaded{isDataLoaded.toggle()}}
        }
    }
    
    private func initialLoading()async throws->Bool{
        var hasUserFavourites: Bool = false
        guard let isUserID = userHomeView.isUser?.uid else{return false}
        do{
            let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
            guard isUserDocument.exists else{return false}
            guard let isLanguageFavourites = isUserDocument.data()?["favouriteWords"] as? [String:[Int]] else{return false}
            isFavouriteWords = isLanguageFavourites
            for (hasLanguageEntry, hasLanguageEntryReference) in isLanguageFavourites{
                for hasLanguageEntryID in hasLanguageEntryReference{
                    try await Task{
                        let isLanguageEntry = try await Firestore.firestore().collection(hasLanguageEntry).document(String(hasLanguageEntryID)).getDocument()
                        let isWordReference = "\(hasLanguageEntry)_\(hasLanguageEntryID)"
                        guard let getWordField = isLanguageEntry.data()?["isWord"] as? String else{return}
                        getFavourtieWords[isWordReference] = getWordField
                    }.value
                }
            }
            hasUserFavourites.toggle()
        } catch{
            print(error.localizedDescription)
        }
        return hasUserFavourites
    }
    
    private func removeWord(isWordLanguage: String, isLanguageEntryID: Int)async->Bool{
        var isWordRemoved: Bool = false
        guard let isUserID = userHomeView.isUser?.uid else{return false}
        do{
            let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
            guard isUserDocument.exists else{return false}
            guard var isLanguageFavourites = isUserDocument.data()?["favouriteWords"] as? [String:[Int]] else{return false}
            let isLanguageEntryCount = isLanguageFavourites[isWordLanguage]?.count
            var isLanguageEntry = isLanguageFavourites[isWordLanguage]
            isLanguageEntry?.removeAll{$0 == isLanguageEntryID}
            isLanguageFavourites[isWordLanguage] = isLanguageEntry
            try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords":isLanguageFavourites], merge: true)
            if isLanguageEntryCount == 1{
                isLanguageFavourites.removeValue(forKey: isWordLanguage)
                try await Firestore.firestore().collection("users").document(isUserID).setData(["favouriteWords": isLanguageFavourites], merge: true)
            }
            isWordRemoved.toggle()
        } catch{
            print(error.localizedDescription)
        }
        return isWordRemoved
    }
}

struct isFavouriteCardView: View{ // Add a little section at the bottom that shows the language , theme , phonetic spelling and an example of the word being used gramticaly (AI)
    @State private var isHomeNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    var body: some View{
        VStack{
            ScrollView{
                VStack{
                    HStack{
                        Image(systemName:"arrow.left.square.fill").resizable().scaledToFit().frame(width: 25, height: 25).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
                        Image(systemName:"arrow.right.square.fill").resizable().scaledToFit().frame(width: 25, height: 25).frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 15)
                    }
                    VStack{
                        ZStack{
                            VStack{
                                HStack{
                                    Image(systemName: "star.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.top, 5)
                                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                            }.frame(maxHeight: .infinity, alignment: .top)
                            Text("Word")
                            VStack{
                                HStack{
                                    Image(systemName: "speaker.wave.3.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.bottom, 5)
                                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                            }.frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }.frame(width: 350, height: 200).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack{
                        Text("Information")
                    }.frame(width: 375, height: 500).background(Color(UIColor.systemGray3)).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.top, 10)
                }
                
            }
            HStack{
                HStack{
                    Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                HStack{
                    Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                HStack{
                    Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                HStack{
                    Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                HStack{
                    Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
            }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
        }
    }
}

struct userSettingView: View{
    @State private var isHomeNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    @State private var isTaskNavigation: Bool = false
    
    var body: some View{
        NavigationStack{
            ZStack{
                VStack{
                    Text("Setting").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                    HStack{
                        Text("Language").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10)
                    HStack{
                        Text("Delete Account").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.padding(10)
                    HStack{
                        HStack{
                            Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                        HStack{
                            Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                        HStack{
                            Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                        }.padding(.horizontal, 10).onTapGesture{isTaskNavigation.toggle()}.navigationDestination(isPresented: $isTaskNavigation){userTaskView().navigationBarBackButtonHidden(true)}
                    }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
                }
            }//.overlay(alignment: .center){}
        }
    }
    
    private func userAccountDeletion()->Bool{
        var isRemovalValid: Bool = true
        userHomeView.isUser?.delete{ error in
            if let hasSignOutError = error{
                isRemovalValid.toggle()
                print(hasSignOutError.localizedDescription)
            }
        }
        return isRemovalValid
    }
}

struct userTaskView: View{
    @State private var isHomeNavigation: Bool = false
    @State private var isFavouritesNavigation: Bool = false
    @State private var isWordInputNavigation: Bool = false
    @State private var isStoreNavigation: Bool = false
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("task")
                HStack{
                    HStack{
                        Image(systemName:"house.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isHomeNavigation.toggle()}.navigationDestination(isPresented: $isHomeNavigation){userHomeView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"heart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isFavouritesNavigation.toggle()}.navigationDestination(isPresented: $isFavouritesNavigation){userFavouriteCardsView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"plus.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isWordInputNavigation.toggle()}.navigationDestination(isPresented: $isWordInputNavigation){/*languageThemeView().navigationBarBackButtonHidden(true)*/} // Dont forget to change word redirection to new word input page
                    HStack{
                        Image(systemName:"cart.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10).onTapGesture{isStoreNavigation.toggle()}.navigationDestination(isPresented: $isStoreNavigation){userStoreView().navigationBarBackButtonHidden(true)}
                    HStack{
                        Image(systemName:"sparkles").resizable().scaledToFit().frame(width: 50, height: 50)
                    }.padding(.horizontal, 10)
                }.frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 10)
            }
        }
    }
}

struct errorView: View {
    var body: some View{
        VStack{
            Text("Error")
        }
    }
}

#Preview{
    contentPageView()
}
