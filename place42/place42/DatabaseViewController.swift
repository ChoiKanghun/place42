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

//        // getting one comment
//        self.ref.child("places").child("autoid2").child("user_comments").child("test").getData { (error, snapshot) in
//            if let error = error {
//                print("Error getting data \(error)")
//            }
//            else if snapshot.exists() {
//                print("Got data \(snapshot.value!)")
//
//                guard let value = snapshot.value else {return}
//                do {
//                    let userComment = try FirebaseDecoder().decode(UserComment.self, from: value)
//                    print(userComment)
//                } catch let err {
//                    print (err)
//                }
//
//            }
//            else {
//
//                print("No data available")
//            }
//        }
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
