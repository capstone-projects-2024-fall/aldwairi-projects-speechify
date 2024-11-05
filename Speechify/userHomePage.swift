//
//  userHomePage.swift
//  Speechify
//
//  Created by Oladapo Oladele on 2024/10/26.
//

import SwiftUI
import FirebaseAuth

struct userHomePageView: View{
    static let isUser = Auth.auth().currentUser
    @State private var isUserName: String = ""
    @State private var hasUserImage: Bool = false
    @State private var viewSettings: Bool = false
    @State private var hasUserAudio: Bool = false
    
    var body: some View{
        NavigationStack{ // Add user profile, avatar store , favourites, settings signout
            VStack(){
                /*HStack{
                    HStack{
                        NavigationLink(destination: loginPageView()){
                        
                            Image(systemName:"square.grid.2x2.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Menu{
                        Button(action: {
                        }){
                            HStack{
                                Image(systemName:"person.circle.fill")
                                Text("Profile")
                            }
                        }
                        Button(action: {
                        }){
                            HStack{
                                Image(systemName:"star.fill")
                                Text("Favourites")
                            }
                        }
                        Button(action: {
                        }){
                            HStack{
                                Image(systemName:"rectangle.portrait.and.arrow.right")
                                Text("Sign Out")
                            }
                        }
                    }label: {
                        HStack{
                            Text(isUserName).frame(height:25)
                            Image(systemName:"person.fill").resizable().scaledToFit().frame(width: 25, height: 25)
                        }
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)*/
                wordCard()
                HStack{
                    Image(systemName: hasUserAudio ? "mic.circle.fill" : "mic.circle").resizable().scaledToFit().frame(width: 50, height: 50)
                }.padding(10).onTapGesture {
                    hasUserAudio.toggle()
                }
            }
        }
    }
}

struct wordCard: View{
    @State private var isCardWord: Bool = true
    @State private var isFavourite: Bool = false
    @State private var isWord: String = "Word"
    @State private var isPhoneticSpelling: String = "Phonetic-Spelling"
    @State private var previousWords: [String] = []
    @State var rotation: Double = 0.0
    
    var body: some View{
        VStack{
            VStack{
                ZStack{
                    VStack{
                        HStack{
                            if isCardWord{
                                Image(systemName: isFavourite ? "star.fill" : "star").resizable().scaledToFit().frame(width: 25, height: 25).padding(.top, 5).onTapGesture{
                                    isFavourite.toggle()
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.frame(maxHeight: .infinity, alignment: .top)
                    Text(isCardWord ? "\(isWord)" : "\(isPhoneticSpelling)").rotation3DEffect(.degrees(isCardWord ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                    VStack{
                        HStack{
                            if isCardWord{
                                Image(systemName: "speaker.wave.3.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.bottom, 5)
                            }
                        }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                }
            }.frame(width: 350, height: 200).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10)).rotation3DEffect(.degrees(isCardWord ? 0 : 180), axis: (x: 0, y: 1, z: 0)).onTapGesture{
                withAnimation(.linear(duration: 1)){
                    isCardWord.toggle()
                }
            }
        }
    }
    private func initialLoading(){}
    private func retrievePreviousWord(){}
    private func expandFavourite() -> Bool{
        return true
    }
    private func accessAudioFile(){}
    private func fetchNextWord(){}
    private func generatePhoneticSpelling(){}
}

struct userThemeSelectionView: View{
    @State private var themeOptions: [String] = ["Category1", "Category2", "Category3", "Category4", "Category5", "Category6", "Category7", "Category8", "Category9"]
    @State private var isGridColumn = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    
    var body: some View{
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
        }
    }
}

struct userProfileView: View{
    let isUser = userHomePageView.isUser
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
    
    init(){
        self.isVerificationFocus = false
    }
    
    var body: some View{
        ZStack{
            if isOverlayView{
                Color.black.opacity(0.5).ignoresSafeArea(.all).onTapGesture{
                    if isNameEdit{
                        isNameEdit.toggle()
                    } else if isGenderEdit{
                        isGenderEdit.toggle()
                    } else if isBirthdayEdit{
                        isBirthdayEdit.toggle()
                    } else if isEmailEdit{
                        isEmailEdit.toggle()
                    } else if isPasswordEdit{
                        isPasswordEdit.toggle()
                    }
                    isOverlayView.toggle()
                }
            }
            VStack{
                Text("User Profile").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                ZStack(alignment: .bottomTrailing){
                    Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 150, height: 150, alignment: .center).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke(.pink, lineWidth: 2))
                    Circle().fill(.blue).frame(width: 50, height: 50).overlay(Circle().stroke(.white, lineWidth: 3)).overlay(Image(systemName: "plus").resizable().scaledToFit().frame(width: 25, height: 25).padding(5).foregroundStyle(.white))//.overlay(Circle().stroke(.white, lineWidth: 3)).background(.blue)
                }
                HStack{
                    VStack{
                        Text("USERNAME").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Text("\(isUserName)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10).onTapGesture{
                    if !isOverlayView{
                        isOverlayView.toggle()
                        isNameEdit.toggle()
                    } else{
                        if isNameEdit{
                            isNameEdit.toggle()
                        } else if isGenderEdit{
                            isGenderEdit.toggle()
                        } else if isBirthdayEdit{
                            isBirthdayEdit.toggle()
                        } else if isEmailEdit{
                            isEmailEdit.toggle()
                        } else if isPasswordEdit{
                            isPasswordEdit.toggle()
                        }
                        isOverlayView.toggle()
                    }
                }
                HStack{
                    VStack{
                        Text("GENDER").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Text("\(isUserGender)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10).onTapGesture{
                    if !isOverlayView{
                        isOverlayView.toggle()
                        isGenderEdit.toggle()
                    } else{
                        if isNameEdit{
                            isNameEdit.toggle()
                        } else if isGenderEdit{
                            isGenderEdit.toggle()
                        } else if isBirthdayEdit{
                            isBirthdayEdit.toggle()
                        } else if isEmailEdit{
                            isEmailEdit.toggle()
                        } else if isPasswordEdit{
                            isPasswordEdit.toggle()
                        }
                        isOverlayView.toggle()
                    }
                }
                HStack{
                    VStack{
                        Text("DATE OF BIRTH").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Text("\(isUserBirthday)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10).onTapGesture{
                    if !isOverlayView{
                        isOverlayView.toggle()
                        isBirthdayEdit.toggle()
                    } else{
                        if isNameEdit{
                            isNameEdit.toggle()
                        } else if isGenderEdit{
                            isGenderEdit.toggle()
                        } else if isBirthdayEdit{
                            isBirthdayEdit.toggle()
                        } else if isEmailEdit{
                            isEmailEdit.toggle()
                        } else if isPasswordEdit{
                            isPasswordEdit.toggle()
                        }
                        isOverlayView.toggle()
                    }
                }
                HStack{
                    VStack{
                        Text("EMAIL ADDRESS").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Text("\(isUserEmail)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10).onTapGesture{
                    if !isOverlayView{
                        isOverlayView.toggle()
                        isEmailEdit.toggle()
                    } else{
                        if isNameEdit{
                            isNameEdit.toggle()
                        } else if isGenderEdit{
                            isGenderEdit.toggle()
                        } else if isBirthdayEdit{
                            isBirthdayEdit.toggle()
                        } else if isEmailEdit{
                            isEmailEdit.toggle()
                        } else if isPasswordEdit{
                            isPasswordEdit.toggle()
                        }
                        isOverlayView.toggle()
                    }
                }
                HStack{
                    VStack{
                        Text("PASSWORD").font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                        Text("\(isUserPassword)").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    }
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10).onTapGesture{
                    if !isOverlayView{
                        isOverlayView.toggle()
                        isPasswordEdit.toggle()
                    } else{
                        if isNameEdit{
                            isNameEdit.toggle()
                        } else if isGenderEdit{
                            isGenderEdit.toggle()
                        } else if isBirthdayEdit{
                            isBirthdayEdit.toggle()
                        } else if isEmailEdit{
                            isEmailEdit.toggle()
                        } else if isPasswordEdit{
                            isPasswordEdit.toggle()
                        }
                        isOverlayView.toggle()
                    }
                }
                
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
}


struct userFavouriteCardsView: View{ // add feature when user clicks the star it removes the word from favourites
    @State private var isFavouriteWords: [String] = ["Text1", "Text2", "Text3", "Text4", "Text5"]
    
    var body: some View{
        ScrollView{
            VStack{
                Text("Favourite Words").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                ForEach(isFavouriteWords, id: \.self){ isWord in
                    VStack{
                        ZStack{
                            VStack{
                                HStack{
                                    Image(systemName: "x.circle.fill").resizable().scaledToFit().frame(width: 25, height: 25).padding(.top, 5).onTapGesture{
                                        if let isCardWordIndex = isFavouriteWords.firstIndex(of: isWord){
                                            isFavouriteWords.remove(at: isCardWordIndex)
                                        }
                                    }
                                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                            }.frame(maxHeight: .infinity, alignment: .top)
                            Text("\(isWord)").foregroundStyle(.blue).font(.largeTitle)
                        }
                    }.frame(width: 350, height: 200).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.vertical, 10)
                }
            }
        }
    }
}

struct isFavouriteCardView: View{ // Add a little section at the bottom that shows the language , theme , phonetic spelling and an example of the word being used gramticaly (AI)
    var body: some View{
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
    }
}

struct userSettingView: View{
    var body: some View{
        ZStack{
            VStack{
                Text("Setting").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                HStack{
                    Text("Language").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10)
                HStack{
                    Text("DELETE ACCOUNT").font(.title3).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    Image(systemName:  "chevron.right").frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 5)
                }.padding(10)
            }
        }//.overlay(alignment: .center){}
    }
}

#Preview{
    userProfileView()
}

// Perhaps .border(Color.blue, width: isTextFieldFocused ? 2 : 0)
