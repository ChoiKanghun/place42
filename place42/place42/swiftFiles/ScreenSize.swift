//
//  ScreenSize.swift
//  place42
//
//  Created by 최강훈 on 2021/03/15.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import UIKit

class ScreenSize {
    static let shared = ScreenSize()
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}
