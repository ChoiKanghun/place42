//
//  DatabaseViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/02.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import Photos
import CodableFirebase

class DatabaseViewController: UIViewController, UICollectionViewDelegate {
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        self.ref.child("places").child("autoid2").child("user_comments").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                print("type: \(type(of: snapshot.value!))")
                
                guard let value = snapshot.value else {return}
                do {
                    let userComments = try FirebaseDecoder().decode(Dictionary<String, UserComment>.self, from: value)
                    print(userComments)
                } catch let err {
                    print (err)
                }
                
            }
            else {

                print("No data available")
            }
        }
        
        
    }


}
