//
//  FriendsList.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/22.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct FriendsList: View {
    
    @EnvironmentObject var friendsData: FriendsData
    
    var body: some View {
        NavigationView {
            
            
            List(friendsData.friends.indices, id: \.self, rowContent: { (index) in
                
                FriendRow(friend: self.friendsData.friends[index], index: index)
            })
            .onAppear(perform: {
                UITableView.appearance().separatorColor = .clear

            })
            .navigationBarTitle("Friends")
        }
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList()
            .environmentObject(FriendsData(from: "gift"))
        
    }
}

struct FriendRow: View {
    var friend: Friend
    var index: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(friend.name)
                    .font(.title)
                    .foregroundColor(.black)
                Text("giftee: \(friend.giftee?.name ?? "") gifter: \(friend.gifter?.name ?? "")")
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .overlay(Image(index.isMultiple(of: 2) ? "sock" : "mistletoe"), alignment: .topTrailing)
        
    }
}
