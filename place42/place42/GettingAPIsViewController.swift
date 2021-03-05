//
//  GettingAPIsViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/04.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase

class GettingAPIsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let storage = Storage.storage()
    var ref: DatabaseReference!
    
    func imageSetting() {
        let pathReference = storage.reference(withPath: "images")
        let islandRef = pathReference.child("image2021_03_04_21_21_33_8670")
        
        islandRef.getData(maxSize: 10 * 1024 * 1024, completion: {
            (data, error) in
            if let error = error {
                print(error)
            } else {
                let image = UIImage(data: data!)
                self.imageView?.image = image
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
//        setDbData("맛있어요 ㅎㅎ")
//        sleep(1)
//        getDbData()
        imageSetting()
    }
    
    func setDbData(_ commentString: String) {
        let commentStringData: Data = commentString.data(using: .utf8) ?? Data()
        let base64encodedString = commentStringData.base64EncodedString()
        
        self.ref.child("places/개포동 사보르/comment_kchoi2").setValue([
            "comment":"\(base64encodedString)",
            "user_id":"kchoi2",
            "rating":3.5
        ])
    }
    
    func getDbData() {
        self.ref.child("places/개포동 사보르/comment_kchoi2").getData {
            (error, snapshot) in
            if let error = error {
                print ("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let values = snapshot.value
                let dic = values as! [String: Any]
                for index in dic {
                    if (index.key == "comment") {
                        let base64encodedString = index.value as! String
                        let base64DecodedData = Data(base64Encoded: base64encodedString, options: .ignoreUnknownCharacters) ?? Data()
                        let base64DecodedString = String(data: base64DecodedData, encoding: .utf8)
                        print("comment index key")
                        print(base64DecodedString!)
                    }
                    else {
                        print(index.value)
                    }
                }
//                let base64DecodedData = Data(base64Encoded: base64encodedString, options: .ignoreUnknownCharacters) ?? Data()
//                let base64DecodedString = String(data: base64DecodedData, encoding: .utf8)
//                print(base64DecodedString!)
//                print("Got data \(snapshot.value!)")
            }
            else {
                print ("No data available")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
