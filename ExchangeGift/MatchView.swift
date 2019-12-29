//
//  MatchView.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/23.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct MatchView: View {
    
    @EnvironmentObject var friendsData: FriendsData
    @State var showMatchAlert = false
    
    var giftCount: Int {
        friendsData.friends.filter {
            !$0.gaveGift
        }.count
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("xmasBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Button(action: {
                        self.friendsData.getNextGifter()
                        self.showMatchAlert = true
                    }) {
                        Image(systemName: "app.gift")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color(red: 1, green: 40/255, blue: 59/255))
                            .padding(.top)
                        
                    }
                    .disabled(giftCount == 0)
                    .overlay(
                        Image(systemName: "\(giftCount).circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50), alignment: .bottomTrailing)
                    if giftCount > 0 {
                        Text("抽到") + Text("\(friendsData.currentGifter?.name ?? "")").font(.largeTitle) + Text("禮物的會是 ?")
                    }
                    Spacer()
                    
                }
                
                
            }
            .navigationBarTitle("Exchange Gift")
                
                
            .alert(isPresented: $showMatchAlert) { () -> Alert in
                
                Alert(title: Text("Xmas 交換禮物"), message: Text("\(friendsData.nextGifter?.name ?? "") 得到了\(friendsData.currentGifter?.name ?? "")的禮物"), primaryButton: .default(Text("OK"), action: {
                    self.friendsData.exchangeGift()
                }), secondaryButton: .cancel({
                    self.friendsData.friends = self.friendsData.friends.filter {
                        $0.id != self.friendsData.nextGifter?.id
                    }
                }))
            }
        }
        
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
            .environmentObject(FriendsData(from: "gift"))
    }
}
