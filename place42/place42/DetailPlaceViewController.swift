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

    var addressText: String?
    var placeNameText: String?
    var ratingText: String?
    var categoryText: String?
    var placeImage: UIImage?
    var commentsArray: Array<(key: String, value: AnyObject)>?
    

    
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

        self.commentsTableView.delegate     = self
        self.commentsTableView.dataSource   = self
        

    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.placeNameLabel?.text           = self.placeNameText
        self.categoryLabel?.text            = self.categoryText
        self.ratingLabel?.text              = self.ratingText
        self.addressLabel?.text             = self.addressText
        self.placeImageView?.image          = self.placeImage
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

        guard let commentsArray = self.commentsArray
        else {
            print("getting self.commentsArray error on numOfRowsInSection")
            return 0
        }
        return (commentsArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let storageImagesReference = self.storage.reference(withPath: "images")

        guard let cell: CommentTableViewCell = self.commentsTableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier) as? CommentTableViewCell
        else {return UITableViewCell()}

        guard let commentsArray = self.commentsArray
        else {
            print("getting self.commentsArray error")
            return UITableViewCell()
            
        }
        for index in 0..<commentsArray.count {
            if index == indexPath.row {
                let comment = commentsArray[index]
                print("comment Info")
                print(comment)
                print(comment.value)
                guard let commentUserId = comment.value["user_id"]
                else {
                    print ("getting comment.value['user_id'] error")
                    return UITableViewCell()
                }
                guard let commentComment = comment.value["comment"]
                else {
                    print("getting comment.value['comment'] error")
                    return UITableViewCell()
                }
                guard let commentRating = comment.value["comment_rating"]
                else {
                    print("getting comment.value['comment_rating'] error")
                    return UITableViewCell()
                }
                guard let commentImageAddress = comment.value["comment_image_address"] as? String
                else {
                    print("getting comment.value['comment_image_address'] error")
                    return UITableViewCell()
                }
                guard let commentUserIdText = commentUserId as? String
                else {
                    print("unwrapping error")
                    return UITableViewCell()
                }
                guard let commentRatingDouble = commentRating as? Double
                else {
                    print("unwrapping error on commentRating to commentRatingText")
                    return UITableViewCell()
                }
                guard let commentCommentText = commentComment as? String
                else {
                    print("unwrapping error")
                    return UITableViewCell()
                }
                let imageReference = storageImagesReference.child("\(commentImageAddress)")
                imageReference.getData(maxSize: 10 * 1024 * 1024, completion: {
                    (data, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        let image = UIImage(data: data!)
                        cell.commentImageView?.image = image
                        cell.userIdLabel?.text = commentUserIdText
                        cell.commentLabel?.text = commentCommentText
                        cell.ratingLabel?.text = String(commentRatingDouble)
                    }
                })
                
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
