//
//  Utils.swift
//  place42
//
//  Created by 최강훈 on 2021/03/15.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static let shared = Utils()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        // Create an indicator.
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: ScreenSize.shared.screenWidth / 2, height: ScreenSize.shared.screenHeight / 2)
        activityIndicator.center = .init(x: ScreenSize.shared.screenWidth / 2, y: ScreenSize.shared.screenHeight / 2)
        activityIndicator.color = UIColor.red
        // Also show the indicator even when the animation is stopped.
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        // Start animation.
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    func startLoading(view: UIView, activityIndicator: UIActivityIndicatorView) {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        // 아래는 포스팅 할 때 쓰기
//        UIApplication.shared.endIgnoringInteractionEvents() //터치 활성화
//        UIApplication.shared.beginIgnoringInteractionEvents() // 터치 비활성화
    }
    
    func stopLoading(view: UIView, activityIndicator: UIActivityIndicatorView) {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
}
