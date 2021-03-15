//
//  CustomUISlider.swift
//  place42
//
//  Created by 최강훈 on 2021/03/15.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import UIKit

class CustomUISlider: UISlider {

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let fPercent = tapPoint.x/width
        let nNewValue = self.maximumValue * Float(fPercent)
        if nNewValue != self.value {
            self.value = nNewValue
        }
        return true
    }
}
