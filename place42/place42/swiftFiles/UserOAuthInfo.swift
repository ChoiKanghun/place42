//
//  UserOAuthInfo.swift
//  place42
//
//  Created by 최강훈 on 2021/03/13.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation

class UserOAuthInfo {
    static let shared = UserOAuthInfo()
    
    var userEmail: String?
    func getTruncatedUserEmail() -> String? {
        guard let userEmailString: String = UserOAuthInfo.shared.userEmail
        else {
            print("error while unwrapping userEmailString")
            return nil
        }
        let startIndex = userEmailString.startIndex
        let endIndex = userEmailString.index(userEmailString.startIndex, offsetBy: 5)
        let indexRange = startIndex...endIndex
        let truncatedUserEmailString = userEmailString[indexRange]
        return truncatedUserEmailString + "***"
        
    }
}
