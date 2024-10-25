//
//  userHomePage.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//


import SwiftUI

struct userHomePageView: View{
    @State private var isUserName: String
    @State private var hasUserImage: Bool = false
    @State private var viewSettings: Bool = false
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: loginPageView()){
                        Button(action: {
                        }){
                            HStack{
                                Image(systemName:"arrow.left.square.fill") // Find category symbol, the 4 square one
                            }
                        }
                    }
                    Spacer()
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
                    }{
                        HStack{
                            Text(isUserName)
                            Image(systemName:"person.fill").resizable()
                        }
                    }
                    .buttonStyle(.bordered).cornerRadius(10)
                    Spacer()
                }
                wordCard()
            }
            .background{
                Color(.lightGray).ignoresSafeArea()
            }
        }
    }
}

struct wordCard: View{
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
                cardFace(frontCard:{Text(currentWord)}, backCard:{Text(isPhoneticSpelling)}, isFaceWord: $isFaceWord)
                Spacer()
                Button(action: {
                    fetchNextWord()
                }){
                    HStack{
                        Image(systemName:"arrow.right.square.fill")
                    }
                }
            }
        }
        .rotation3DEffect(.degrees(cardRotation), axis: (x: 0, y: 1, z: 0))
        .frame(width: 400, height: 200).background(.white)
        .rotation3DEffect(.degrees(cardContentRotation), axis: (x: 0, y: 1, z: 0))
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

#Preview {
    userHomePageView()
}