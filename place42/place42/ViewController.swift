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
    @IBOutlet weak var addressLabel: UILabel!
    
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
        
        mapView.delegate = self

    }

    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        // geocoder는 위, 경도를 street 주소로 바꾸어준다.
        let geocoder = GMSGeocoder()
        
        // geocoder에게 coordinate(위, 경도 좌표)를 street 주소로 변환하라고 요청.
        // response는 변환된 주소.
        geocoder.reverseGeocodeCoordinate(coordinate) {
            response, error in
            guard let address = response?.firstResult(),
                let lines = address.lines
                else {return}
            
            // 글자를 set.
            // joined는 개행으로 구분된 문자열을 한 줄로 붙여줌.
            self.addressLabel.text = lines.joined(separator: "\n")
            
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            let topInset = self.view.safeAreaInsets.top
            
            self.mapView.padding = UIEdgeInsets(
                top: topInset,
                left: 0,
                bottom: labelHeight,
                right: 0)
            
            // 주소의 변화가 있다면 설정한 duration에 걸쳐 animate.
            UIView.animate(withDuration: 0.25) {
                
                self.view.layoutIfNeeded()
            }
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

extension ViewController: GMSMapViewDelegate {

    // 좌표가 변할 때마다 실행.
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocode(coordinate: position.target)
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {

    }
}
