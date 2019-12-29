//
//  SnowView.swift
//  ExchangeGift
//
//  Created by SHIH-YING PAN on 2019/12/25.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct SnowView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<SnowView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        let snowEmitterCell = CAEmitterCell()
        snowEmitterCell.contents = UIImage(named: "snow")?.cgImage
        snowEmitterCell.birthRate = 1
        snowEmitterCell.lifetime = 20
        snowEmitterCell.velocity = 100
        snowEmitterCell.scaleSpeed = -0.02
        snowEmitterCell.scale = 0.8
        snowEmitterCell.scaleRange = 0.2
        snowEmitterCell.spin = 0.5
        snowEmitterCell.spinRange = 1
        snowEmitterCell.emissionLongitude = CGFloat.pi
        snowEmitterCell.emissionRange = CGFloat.pi / 4
        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        snowEmitterLayer.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = .line
        snowEmitterLayer.emitterCells = [snowEmitterCell]
        view.layer.addSublayer(snowEmitterLayer)
        view.clipsToBounds = true
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SnowView>) {
        
    }
    
    typealias UIViewType = UIView
    
    
}
