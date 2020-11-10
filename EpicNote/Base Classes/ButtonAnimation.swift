//
//  ButtonAnimation.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/29/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  
  func pulsate() {
      
      let pulse = CASpringAnimation(keyPath: "transform.scale")
      pulse.duration = 0.5
      pulse.fromValue = 0.85
      pulse.toValue = 1.0
      pulse.autoreverses = false
      pulse.repeatCount = 1
      pulse.initialVelocity = 0.5
      pulse.damping = 1.0
      
      layer.add(pulse, forKey: "pulse")
  }

    func flash() {
      
      let flash = CABasicAnimation(keyPath: "opacity")
      flash.duration = 0.5
      flash.fromValue = 1
      flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      flash.autoreverses = false
      flash.repeatCount = 1
      
      layer.add(flash, forKey: nil)
  }
    
}
