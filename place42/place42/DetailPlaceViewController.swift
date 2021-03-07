//
//  DetailPlaceViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/05.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase

class DetailPlaceViewController: UIViewController {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var commentsTableView: UITableView!
    let tableViewCellIdentifier: String = "commentTableViewCell"

    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.placeNameLabel?.text = PlaceInfo.shared.placeName
        self.categoryLabel?.text = PlaceInfo.shared.placeCategory
        self.addressLabel?.text = PlaceInfo.shared.placeAddress
        self.ratingLabel?.text = PlaceInfo.shared.placeRating
        self.placeImageView?.image = PlaceInfo.shared.placeImage
        self.commentsTableView.delegate = self
        self.commentsTableView.dataSource = self
        
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

extension DetailPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let commentsNSDictionary = PlaceInfo.shared.commentsNSDictionary
        else {return 0}
        
        return commentsNSDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CommentTableViewCell = self.commentsTableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier) as? CommentTableViewCell
        else {return UITableViewCell()}
        
        guard let commentsNSDictionary = PlaceInfo.shared.commentsNSDictionary
        else {
            print ("getting comments from singleton comments")
            return UITableViewCell()
        }
        
        let commentSwiftDeferredNSDictionary = commentsNSDictionary.allValues[indexPath.row]
//        print(commentSwiftDeferredNSDictionary)
        let comment = commentSwiftDeferredNSDictionary as! Dictionary<String, Any>
        print(comment)
        print(type(of: comment))
        
        let storageReference = storage.reference(withPath: "images")
        
        for item in comment {
            if (item.key == "comment") {
                cell.commentLabel?.text = String(describing: item.value)
            }
            else if (item.key == "rating") {
                cell.ratingLabel?.text = String(describing: item.value)
            }
            else if (item.key == "user_id") {
                cell.userIdLabel?.text = String(describing: item.value)
            }
            else if (item.key == "comment_image_address") {
                let imageAddress = String(describing: item.value)
                let imageRef = storageReference.child(imageAddress)
                
                // 1024 * 1024 * 10 = 10MB
                imageRef.getData(maxSize: 10 * 1024 * 1024, completion: {
                    (data, error) in
                    if let error = error {
                        print (error)
                    }
                    else {
                        let image = UIImage(data: data!)
                        cell.commentImageView?.image = image
                    }
                })
            }
            
        }
        
        
        
//        print("comments: \(comments.keys)")
//        print("comments keys count : \(commentsCount)")
////        print("comments.count:\(comments.count)")
//        for index in 0..<commentsCount {
//            if index == indexPath.row {
////                print("index:\(index), indexPath.row:\(indexPath.row)")
//                let comment = Array(comments)[index].value
//
                // 지금 여기서 comment.key 는 comment_someone
//                print(comment)
                


//                for i in 0..<commentsCount {
//                    if comment[i].key == "rating" {
//                        print(type(of: comment[i].value))
//                    }
//                    else if (comment[i].key == "comment") {
//                        DispatchQueue.main.async {
//                            cell.commentLabel?.text = comment[i].value as? String
//
//                        }
//                    }
//                    else if (comment[i].key == "user_id") {
//                    }
//                    else if (comment[i].key == "image_address") {
//                    }
//                }
//                for comment in comments {
//                    guard let userComment = comment.value as? [String: Any]
//                    else {return UITableViewCell()}
//
//                    print (userComment)
//                    print (userComment.keys)
//
//                }
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
