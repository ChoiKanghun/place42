//
//  GooglePlacesViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/02.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class GooglePlacesViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//        let camera = GMSCameraPosition.camera(withLatitude:  37.48917857480062, longitude: 127.06431046128272, zoom: 12.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//
//        view = mapView
//
//        let urlString = makeStringKoreanEncoded("개포동 사보르")
//        UIApplication.shared.openURL(URL(string:self.makeURL("개포동 사보르"))!)
//    }
//
//    func makeURL(_ string: String) -> String {
//        return "https://www.google.com/maps/search/?api=1&query=" + makeStringKoreanEncoded(string)
//    }
//
//    func makeStringKoreanEncoded(_ string: String) -> String {
//        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
          UIApplication.shared.openURL(URL(string:
            "comgooglemaps://?q=Pizza&center=37.759748,-122.427135")!)
        } else {
          print("Can't use comgooglemaps://");
        }
    }
}
