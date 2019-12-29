//
//  MusicBar.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/23.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI
import AVFoundation

struct MusicBar: View {
    
    @State var isPlay = false
    let player = AVQueuePlayer()
    @State var looper: AVPlayerLooper?
    
    var body: some View {
        HStack {
            Text("last christmas")
                .bold()
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                self.isPlay.toggle()
                if self.isPlay {
                    self.player.play()
                } else {
                    self.player.pause()
                }
            }) {
                Image(systemName: isPlay ? "pause.fill" : "play.fill")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            
        }
        .padding()
        .background(
            Image("snow")
                .resizable(resizingMode: .tile)
                .opacity(0.8))
            .background(Color.black)
            .onAppear {
                
                let item = AVPlayerItem(url:  Bundle.main.url(forResource: "music", withExtension: "mp4")!)
                
                self.looper = AVPlayerLooper(player: self.player, templateItem: item)
        }
    }
}

struct MusicBar_Previews: PreviewProvider {
    static var previews: some View {
        MusicBar()
    }
}
