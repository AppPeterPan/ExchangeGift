//
//  ContentView.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/22.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FriendsList()
                .tabItem {
                    Text("Friends")
                    Image(systemName: "rectangle.stack.person.crop.fill")
            }
            .padding(.bottom, 49)
            
            MatchView()
                .tabItem {
                    Text("Match")
                    Image(systemName: "gift.fill")
            }
            GifteesList()
                .tabItem {
                    Text("Giftees")
                    Image(systemName: "person.2.fill")
            }
        }
        .accentColor(Color(red: 1, green: 215/255, blue: 0))
        .edgesIgnoringSafeArea(.top)
        .overlay(MusicBar().offset(x: 0, y: -49), alignment: .bottom)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.red 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FriendsData(from: "gift"))
    }
}
