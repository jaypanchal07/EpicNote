//
//  CustomViewStyleSetup.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/24/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
//Shadow view
    
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat, corners: UIRectCorner) {
//        self.layer.cornerRadius = 4.0
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
        self.layer.shadowPath = cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow2(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, size : Float, distance: Float, shadowRadius: CGFloat, shadowOpacity: CGFloat ) {
        //A negative size will make the shadow look smaller than the image. And a distance greater than 0 will make the view look distant from other views.
    let size: CGFloat = CGFloat(size)
    let distance: CGFloat = CGFloat(distance)
    let rect = CGRect(
        x: -size,
        y: self.frame.height - (size * 0.4) + distance,
        width: self.frame.width + size * 2,
        height: size
    )
        self.layer.masksToBounds = false
        self.layer.opacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius
        
        self.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
//Gradient color view
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        //https://medium.com/swlh/how-to-create-a-custom-gradient-in-swift-with-cagradientlayer-ios-swift-guide-190941cb3db2
        gradientLayer.locations = [0.9, 1]
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func setGradientBackground2(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        //https://medium.com/swlh/how-to-create-a-custom-gradient-in-swift-with-cagradientlayer-ios-swift-guide-190941cb3db2
        gradientLayer.locations = [1, 0]
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func circleButton(){

        self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        
    }
    func customRadius(a: Double){

        self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        self.layer.cornerRadius = CGFloat(a) * self.bounds.size.width
        self.clipsToBounds = true
        
    }
    func addBorder(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

