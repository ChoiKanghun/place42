//
//  AppPushNotificationViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/22.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class AppPushNotificationViewController: UIViewController {

    let userNotificationCenter = UNUserNotificationCenter.current()
    var keywords: Array<String> = Array<String>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var keywordInputTextField: UITextField!
    
    
    @objc func observeEnrollGoods(_ noti: Notification) {
        guard let enrollGoodsText: String = noti.userInfo?["enrollGoods"] as? String
        else {return}
        print(type(of: enrollGoodsText))
        for item in TestSingleton.shared.singletonKeywords {
            if enrollGoodsText.contains(item) {
                self.sendNotification(seconds: 3, subtitle: item, body: enrollGoodsText)
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.keywords = TestSingleton.shared.singletonKeywords
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.observeEnrollGoods(_:)), name: DidReceiveEnrollGoodsNotification, object: nil)
        
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        // section의 inset (섹션의 인셋)을 없애라.
        // 인셋이 뭔지 모르면 검색!
               // 공식문서의 정의:The margins used to lay out content in a section.
        flowLayout.minimumLineSpacing = 10
        // 라인 간의 거리
        flowLayout.minimumInteritemSpacing = 10
        // 아이템 간의 거리
        
        let halfWidth: CGFloat = UIScreen.main.bounds.width / 4.0
        
        flowLayout.itemSize = CGSize(width: halfWidth - 30, height: 150)
        // 가로는 30 작게, 높이는 90정도로 하면 좋겠다.
        // 내 예상 이 정도 될 것 같으니 알아서 잘 배치해봐라. 라는 뜻임.
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    func requestNotificationAuthorization() {
        
    }
    
    
    
    func sendNotification(seconds: Double, subtitle: String, body: String) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "당근마켓 키워드 알림"
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        userNotificationCenter.add(request) {
            error in
            if let error = error {
                print("notification Error: \(error)")
            }
        }
    }
    
    @IBAction func touchUpButton(_ sender: UIButton) {
        if self.keywordInputTextField.text == "" {
            return
        }
        self.keywords.append(self.keywordInputTextField.text ?? "no data")
        TestSingleton.shared.singletonKeywords = self.keywords
        self.collectionView.reloadData()
    }
    

}

extension AppPushNotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.keywords.isEmpty == true {
            return 0
        }
        else {
            return self.keywords.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AppPushCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: AppPushCollectionViewCell.identifier, for: indexPath) as? AppPushCollectionViewCell
        else {return UICollectionViewCell()}
        
        cell.keywordLabel.text = self.keywords[indexPath.row]
        
        return cell
    }
}

