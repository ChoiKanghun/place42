//
//  ViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/02/26.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 해당 컨트롤러를 locationManager의 delegate으로 설정.
        locationManager.delegate = self
        
        // 위치 정보 사용에 동의했는지 확인 및 위치 정보 요청.
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            
            // 아래 두 줄은 파란색 점으 ㄹ화면에 표시할 것임.
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        } else {
            // 위치 정보 사용에 동의하지 않은 경우 다시 요청.
            locationManager.requestWhenInUseAuthorization()
        }
    }

    
}

extension ViewController: CLLocationManagerDelegate {
    // location permission이 승인될 때 해당 함수가 실행됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // location permission이 승인됐는지 확인하고
        guard status == .authorizedWhenInUse
            else {return}
        
        // locationManager에게 location을 물음.
        manager.requestLocation()
        
        // locatoin indicator와 location button 을 추가.
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 또다른 locationManager 메써드를 만듦.
    // CLLocation 배열을 받음.
    // 새로운 location 데이터가 들어올 때 실행되는 함수임.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first
            else {return}
        
        // map의 카메라를 유저의 현재 위치로 옮김.
        // GMSCameraPosition 클래스는 현재 카메라의 정보를 받아서 카메라를 업데이트.
        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 15,
            bearing: 0,
            viewingAngle: 0)
    }
    
    // 에러 처리.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
}
