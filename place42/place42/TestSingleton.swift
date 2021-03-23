//
//  TestSingleton.swift
//  place42
//
//  Created by 최강훈 on 2021/03/23.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import UIKit

class TestSingleton {
    static let shared = TestSingleton()
    
    var singletonKeywords: Array<String> = Array<String>()
}
