//
//  CarrotMarketAlarmViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/05/12.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation
import MapKit


class CarrotMarketAlarmViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rangeInMeterUILabel: UILabel!
    
    let userNotificationCenter = UNUserNotificationCenter.current()

    var locationRangeInMeter: Double = 0
    
    // 개포 2동 개포초등학교
    let location1: CLLocation = CLLocation.init(latitude: 37.486569, longitude: 127.070270)
    // 개포 4동 구룡초등학교
    let location2: CLLocation = CLLocation.init(latitude: 37.480766, longitude: 127.051563)
    

    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // desiredAccuracy는 위치의 정확도를 설정함.
        // 높으면 배터리 많이 닳음.
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.startUpdatingLocation()
        return manager
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNotificationCenter.delegate = self
        
        requestNotificationAuthorization()
        getLocationUsagePermission()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // xcode 종료 후 어플을 다시 실행했을 때 뜨는 오류 방지.
        self.mapView.mapType = MKMapType.standard
        // 지도에 내 위치 표시
        mapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임.
        self.mapView.setUserTrackingMode(.follow, animated: true)

        self.mapView.isZoomEnabled = true
        
        let point1 = MKPointAnnotation()

        point1.coordinate =
            CLLocationCoordinate2DMake(
                self.location1.coordinate.latitude,
                self.location1.coordinate.longitude)

        point1.title = "개포초등학교"
        point1.subtitle = "가까운 곳"

        let point2 = MKPointAnnotation()
        point2.coordinate =
            CLLocationCoordinate2DMake(
                self.location2.coordinate.latitude,
                self.location2.coordinate.longitude)
        
        point2.title = "구룡초등학교"
        point2.subtitle = "먼 곳"
        
        mapView.addAnnotation(point1)
        mapView.addAnnotation(point2)
        
        self.locationRangeInMeter = 2000.00 // 1km
        self.rangeInMeterUILabel?.text
            = "알림을 받을 범위: " +
            String(self.locationRangeInMeter) +
            "m 이내"
    }


    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func sendNotification(seconds: Double, distance: CLLocationDistance) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "내 주변에서 게시글이 등록되었어요!"
        notificationContent.body =
            "내 위치로부터의 거리: "
            + "\(Int(floor(distance)))"
            + "m"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    @IBAction func touchUpNearLocationButton(_ sender: Any) {
        if let distance =
            locationManager.location?.distance(from: self.location1) {
            if distance < self.locationRangeInMeter {
                sendNotification(seconds: 2, distance: distance)
            }
            
        }
        
    }
    
    @IBAction func touchUpFarLocationButton(_ sender: Any) {
        if let distance =
            locationManager.location?.distance(from: self.location2) {
            if distance < self.locationRangeInMeter {
                sendNotification(seconds: 2, distance: distance)
            }
        }
    }
}

extension CarrotMarketAlarmViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

extension CarrotMarketAlarmViewController: CLLocationManagerDelegate {
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //location5
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
        default:
            print("GPS: Default")
        }
    }
}
