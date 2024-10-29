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
                //wordCard()
            }
        }
    }
}

/*struct wordCard: View{
    /*
    struct wordCard<isFront: View, isBack: View>: View{
    let frontCard: () -> isFront
    let backCard: () -> isBack
    */
    @State private var isFaceWord: Bool = true
    @State private var isWordCardFlipped: Bool = false
    @State private var cardRotation = 0.0
    @State private var cardContentRotation = 0.0
    @State private var previousWords: [String]
    @State private var currentWord: String
    @State private var isFavouriteComponent: Bool = false
    @State private var isPhoneticSpelling: String

    init(){
        initialLoading()
    }

    var body: some View{
        ZStack{
            HStack{
                Button(action: {
                    retrievePreviousWord()
                }){
                    HStack{
                        Image(systemName:"arrow.left.square.fill")
                    }
                }
                Spacer()
                cardFace(frontCard:{Text("front"/*currentWord*/)}, backCard:{Text("Back"/*isPhoneticSpelling*/)}/*, isFaceWord: $isFaceWord*/)
                Spacer()
                Button(action: {
                    fetchNextWord()
                }){
                    HStack{
                        Image(systemName:"arrow.right.square.fill")
                    }
                }
            }
        }.rotation3DEffect(.degrees(cardRotation), axis: (x: 0, y: 1, z: 0)).frame(width: 400, height: 200).background(.white).rotation3DEffect(.degrees(cardContentRotation), axis: (x: 0, y: 1, z: 0))
            .overlay(
            Rectangle().stroke(.black, lineWidth: 2)
            VStack{
                Button(action: {
                    expandFavourites()
                }){
                    Image(systemName:"star") // Update to filled when clicked
                }
                Spacer()
                Button(action: {
                    accessAudioFile()
                }){
                    Image(systemName:"speaker.wave.3.fill")
                }
            }
        )
        .onTapGesture {
            flipWordCard()
        }
    }

    private func flipWordCard(){
        let animationDelay = 0.5
        withAnimation(.linear(duration: animationDelay)){
            cardRotation += 180
        }
        withAnimation(.linear(duration: 0.001).delay(animationDelay / 2)){
            cardContentRotation += 180
            isWordCardFlipped.toggle()
            isFaceWord.toggle()
        }
    }

    private func initialLoading(){}

    private func retrievePreviousWord(){}

    private func expandFavourites(){}

    private func accessAudioFile(){}

    private func fetchNextWord(){}

    private func generatePhoneticSpelling(){}
}

struct cardFace<isFront: View, isBack: View>: View{
    let frontCard: () -> isFront
    let backCard: () -> isBack
    @Binding var isFaceWord: Bool
    
    init(@ViewBuilder frontCard: @escaping () -> isFront, @ViewBuilder backCard: @escaping () -> isBack){
        self.frontCard = isFront()
        self.backCard = isBack()
    }

    var body: some View{
        VStack{
            isFaceWord ? frontCard() : backCard()
        }
    }
}
*/ //Card UI Loading.....

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
