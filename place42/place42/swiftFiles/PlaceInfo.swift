//
//  PlaceInfo.swift
//  place42
//
//  Created by 최강훈 on 2021/03/05.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PlaceInfo {
    static let shared = PlaceInfo()
    
    var placeName: String?
    var placeRating: String?
    var placeAddress: String?
    var placeCategory: String?
    var placeImage: UIImage!
    var placesData: DataSnapshot = DataSnapshot()
    
    var commentsNSDictionary: NSDictionary? = NSDictionary()

}
