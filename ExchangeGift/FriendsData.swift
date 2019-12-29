//
//  Friend.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/22.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation

class FriendsData: ObservableObject {
    
    @Published var friends = [Friend]()
    @Published var currentGifter: Friend?
    var nextGifter: Friend?
    var firstGifter: Friend?
    
    func getNextGifter() {
        nextGifter = friends.filter {
            !$0.gotGift && $0.id != firstGifter?.id
        }.randomElement()
        if nextGifter == nil {
            nextGifter = firstGifter
        }
    }
    
    func exchangeGift() {
        // nextGifter 將得到 currentGifter 的禮物
        currentGifter?.giftee = nextGifter
        nextGifter?.gifter = currentGifter
        // 抽到的人將成為下一個送出禮物的人
        currentGifter = nextGifter
    }
    
    
    init(from file: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json"), let data = try? Data(contentsOf: url), let array = try? JSONDecoder().decode([Friend].self, from: data) else {
            return
        }
        self.friends = array
        self.currentGifter = self.friends.randomElement()
        self.firstGifter = self.currentGifter
    }
    
    init() {
        URLSession.shared.dataTask(with: URL(string: "https://sheetdb.io/api/v1/0zilt1bxh10jf")!) { data, response, error in
            guard let data = data, let array = try? JSONDecoder().decode([Friend].self, from: data) else {
                print(String(describing: error))
                return
            }
            DispatchQueue.main.async {
                self.friends = array
                self.currentGifter = self.friends.randomElement()
                self.firstGifter = self.currentGifter
            }
            
        }.resume()
    }
    
}

class Friend: Codable, Identifiable {
    // JSON field
    let name: String
    
    /* non JSON field, id 是宣告時就指定內容的常數，
     因此不需要包含在 JSON 的欄位裡，
     另外 App 將使用到 gifter & giftee，
     它們都是 optional，跟 JSON 無關 */
    let id = UUID()
    // 給禮物的人，從 gifter 得到禮物
    var gifter: Friend?
    // 收到禮物的人，將禮物送給 giftee
    var giftee: Friend?
    
    // 是否已送出禮物
    var gaveGift: Bool {
        giftee != nil
    }
    // 是否已得到禮物
    var gotGift: Bool {
        gifter != nil
    }
}
