//
//  PlacesDataModel.swift
//  place42
//
//  Created by 최강훈 on 2021/03/08.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation

struct PlacesDataModel: Codable {
    let place: [PlaceDataModel]
    enum CodingKeys: String, CodingKey {
        case place
    }
}
struct UserComment:Codable {
    let commentRating: Double
    let commentImageAddress: String //comment_image_address
    let userId: String //user_id
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case commentRating = "comment_rating"
        case commentImageAddress = "comment_image_address"
        case userId = "user_id"
        case comment
    }
}

struct UserComments: Codable {
//    let userComments: [UserComment]
    let userComments: [UserComment]
    
    enum CodingKeys: String, CodingKey {
        case userComments = "user_comments"
    }
}

struct PlaceDataModel: Codable {
    
    

    let addressKorean: String //address_korean
    let addressLatitude: Double //address_latitude
    let addressLongtitude: Double //address_longtitude
    let category: String
    let imageAddress: String //image_address
    let placeName: String //place_name
    let rating: Double
    let userComments: Dictionary<String, UserComment>

    enum CodingKeys: String, CodingKey {
        case addressKorean = "address_korean"
        case addressLatitude = "address_latitude"
        case addressLongtitude = "address_longtitude"
        case category
        case imageAddress = "image_address"
        case placeName = "place_name"
        case rating
        case userComments = "user_comments"
    }
}

