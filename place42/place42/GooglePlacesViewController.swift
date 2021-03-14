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

class GooglePlacesViewController: UIViewController, CLLocationManagerDelegate {

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
////        UIApplication.shared.open(URL(string:self.makeURL("개포동 사보르"))!)
//        UIApplication.shared.open(URL(string:self.makeURL("개포동 사보르"))!, completionHandler: nil)
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func makeURL(_ string: String) -> String {
//        return "https://www.google.com/maps/search/?api=1&query=" + makeStringKoreanEncoded(string)
//    }
//
//    func makeStringKoreanEncoded(_ string: String) -> String {
//        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
//    }

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//          UIApplication.shared.openURL(URL(string:
//            "comgooglemaps://?q=Pizza&center=37.759748,-122.427135?key=AIzaSyBJvaTwMGsIVqMkZ7kyN6fcvDkdBHyz9ug")!)
//        } else {
//          print("Can't use comgooglemaps://");
//        }
//    }
//
//    let locationManager = CLLocationManager()
//
//    // naver maps
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        locationManager.delegate = self
//
//
//    }
//
//    @objc func locationCheck(){
//            let status = CLLocationManager.authorizationStatus()
//
//            if status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted {
//                let locationEnableRequestAlertController =
//                    UIAlertController(
//                        title: "위치권한 설정이 '안함'으로 되어있습니다.",
//                        message: "앱 설정 화면으로 가시겠습니까? \n '아니오'를 선택하시면 앱이 종료됩니다.",
//                        preferredStyle: UIAlertController.Style.alert)
//
//                let okAction =
//                    UIAlertAction(title: "네", style: UIAlertAction.Style.default) {
//                    (action: UIAlertAction) in
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
//                    } else {
//                        UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
//                    }
//                }
//                let denyAction
//                    = UIAlertAction(title: "아니오", style: UIAlertAction.Style.destructive){
//                    (action: UIAlertAction) in
//                        self.navigationController?.popViewController(animated: true)
//                }
//                locationEnableRequestAlertController.addAction(okAction)
//                locationEnableRequestAlertController.addAction(denyAction)
//                self.present(locationEnableRequestAlertController, animated: true, completion: nil)
//            }
//        }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == CLAuthorizationStatus.denied {
//            locationCheck()
//        }
//        else if status == CLAuthorizationStatus.authorizedAlways ||
//                    status == CLAuthorizationStatus.authorizedWhenInUse {
//            let placeString = "선릉 낭만옵빠"
//            guard let urlEncodedSring = placeString.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
//            else {
//                print("url encoding failure")
//                return
//            }
//            if UIApplication.shared.canOpenURL(URL(string:"https://m.map.naver.com/search2/search.naver?query=" + urlEncodedSring)!) {
//                UIApplication.shared.open(URL(string:"https://m.map.naver.com/search2/search.naver?query=" + urlEncodedSring)!, completionHandler: nil)
//            }
//
//            if (UIApplication.shared.canOpenURL(URL(string:"nmap://map?&appname=com.kchoi.place42")!)) {
//                      UIApplication.shared.openURL(URL(string:
//                        "nmap://map?appname=com.kchoi.place42")!)
//                    } else {
//                      print("Can't use nmap://");
//                    }
//
//            let naverMapView = NMFNaverMapView(frame: view.frame)
//            naverMapView.showZoomControls = true
//            naverMapView.showLocationButton = true
//            naverMapView.positionMode = .direction
//            view.addSubview(naverMapView)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        return
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print (error)
//    }
    
}
