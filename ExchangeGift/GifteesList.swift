//
//  GifteesList.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/22.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct GifteesList: View {
    @EnvironmentObject var friendsData: FriendsData
    var giftees: [Friend] {
        friendsData.friends.filter {
            $0.gotGift
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                SnowView()
                ScrollView(.horizontal) {
                    HStack(spacing: 40) {
                        ForEach(giftees) { (friend) in
                            VStack {
                                Text(friend.name)
                                Image(systemName: "gift")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                Text("與") + Text("\(friend.gifter!.name)").font(.largeTitle).foregroundColor(Color(red: 1, green: 0, blue: 0)) + Text("相遇好幸運")
                                
                            }
                            .padding()
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(20)
                            .rotation3DEffect(Angle(degrees: 10), axis: (x: 10, y: 10, z: 10))
                        }
                    }
                    .padding(50)
                }
                .navigationBarTitle("Giftees")
            }
        }
    }
}

struct GifteesList_Previews: PreviewProvider {
    static var previews: some View {
        let friendsData = FriendsData(from: "gift")
        for _ in 1...3 {
            friendsData.getNextGifter()
            friendsData.exchangeGift()
        }
        return GifteesList()
            .environmentObject(friendsData)
        
    }
}
