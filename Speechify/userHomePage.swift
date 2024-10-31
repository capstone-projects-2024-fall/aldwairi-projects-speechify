//
//  userHomePage.swift
//  Speechify
//
//  Created by Oladapo Oladele on 2024/10/26.
//

import SwiftUI

struct userHomePage: View{
    @State private var isUserName: String = ""
    @State private var hasUserImage: Bool = false
    @State private var viewSettings: Bool = false
    
    var body: some View{
        NavigationStack{
            VStack(){
                HStack{
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
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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

struct userProfileView: View{
    var body: some View{
        VStack{
            Text("User Profile")
        }
    }
}

struct userFavouriteCardsView: View{
    @State private var isFavouriteWords: [String] = ["Text1", "Text2", "Text3", "Text4", "Text5"]
    
    var body: some View{
        ScrollView{
            VStack{
                Text("Favourite Words").font(.largeTitle).padding(.top, 10)
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
            }.frame(width: 325, height: 175).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
            VStack{
                Text("Information")
            }.frame(width: 375, height: 500).background(Color(UIColor.systemGray3)).clipShape(RoundedRectangle(cornerRadius: 5)).padding(.top, 10)
        }
    }
}

struct userThemeSelectionView: View{
    @State private var themeOptions: [String] = ["Category1", "Category2", "Category3", "Category4", "Category5", "Category6", "Category7", "Category8", "Category9"]
    @State private var isGridColumn = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    
    var body: some View{
        ScrollView{
            VStack{
                Text("Theme").font(.largeTitle).padding(.top, 10)
                LazyVGrid(columns: isGridColumn, spacing: 5){
                    ForEach(themeOptions, id: \.self){ isTheme in
                        VStack{
                            Image(systemName: "arrow.left").resizable().scaledToFit().frame(width: 170, height: 170)
                            Text("\(isTheme)")
                        }.padding(10).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))//.padding(.horizontal, 10)
                    }
                }
            }.background(Color.green)
        }
    }
}


#Preview {
    isFavouriteCardView()
}
