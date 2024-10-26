//
//  userHomePage.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//

import SwiftUI

struct userHomePage: View{
    @State private var isUserName: String = ""
    @State private var hasUserImage: Bool = false
    @State private var viewSettings: Bool = false
    
    var body: some View{
        NavigationView{
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

struct userFavouritesView: View{ // Add a little section at the bottom that shows the language , theme , phonetic spelling and an example of the word being used gramticaly (AI)
    var body: some View{
        VStack{
            VStack{
                HStack{
                    Image(systemName:"arrow.left.square.fill").resizable().scaledToFit().frame(width: 50, height: 50)
                    Text("Favourites").frame(width: 275, height: 175).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
                    Image(systemName:"arrow.right.square.fill").resizable().scaledToFit().frame(width:50, height: 50)
                }.padding()
            }.background(Color.gray)
        }
        VStack{
            HStack{
                Text("Info")
                // Display information here
            }
        }.background(Color.gray)
    }
}

struct themeView: View{ // Replace the systemImages & themes names and add some animations and stuff
    @State private var themeOptions: [String] = ["Random", "Greetings"]
    var body: some View{
        ScrollView{
            VStack{
                Text("Theme").font(.largeTitle).frame(maxWidth: .infinity, alignment: .center).padding(.top, 10)
                //ForEach(Array(themeOptions.enumerated()), id: \.element){ index, item in
                HStack{
                    VStack{
                        Image(systemName: "arrow.left").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack{
                        Image(systemName: "arrow.right").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
                }.padding(10)
                HStack{
                    VStack{
                        Image(systemName: "arrow.up").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack{
                        Image(systemName: "arrow.down").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
                }.padding(10)
                HStack{
                    VStack{
                        Image(systemName: "arrow.left").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack{
                        Image(systemName: "arrow.right").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
                }.padding(10)
                HStack{
                    VStack{
                        Image(systemName: "arrow.up").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack{
                        Image(systemName: "arrow.down").resizable().scaledToFit().frame(width: 175, height: 175)
                        Text("Theme Name")
                    }.padding(5).background(Color(UIColor.systemGray5)).clipShape(RoundedRectangle(cornerRadius: 5))
                 }.padding(10)
                    //}
                }
            }
        }
    }


#Preview {
    userFavouritesView()
}
