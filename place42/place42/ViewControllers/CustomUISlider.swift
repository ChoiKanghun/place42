//
//  CustomUISlider.swift
//  place42
//
//  Created by 최강훈 on 2021/03/11.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import UIKit

class CustomUISlider: UISlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let floatPercent = tapPoint.x / width
        let newValue = self.maximumValue * Float(floatPercent)
        if newValue != self.value {
            self.value = newValue
        }
        return true
    }
}
