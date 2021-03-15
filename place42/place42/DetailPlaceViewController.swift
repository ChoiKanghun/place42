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
    
    // 화면이 완전히 로딩되기 전까지 로딩 이미지를 표시함.
    lazy var activityIndicator = Utils.shared.activityIndicator
    
    // 지도에서 위치 확인
    @IBAction func checkLocation(_ sender: UIButton) {
        guard let placeString = self.placeNameText
        else {return}
        // url 인코딩.
        guard let urlEncodedSring = placeString.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        else {
            print("url encoding failure")
            return
        }
        if UIApplication.shared.canOpenURL(URL(string:"https://m.map.naver.com/search2/search.naver?query=" + urlEncodedSring)!) {
            UIApplication.shared.open(URL(string:"https://m.map.naver.com/search2/search.naver?query=" + urlEncodedSring + "#/map")!, completionHandler: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentsTableView.delegate     = self
        self.commentsTableView.dataSource   = self
        
        self.view.addSubview(self.activityIndicator)

    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.placeNameLabel?.text           = self.placeNameText
        self.categoryLabel?.text            = self.categoryText
        self.ratingLabel?.text              = self.ratingText
        self.addressLabel?.text             = self.addressText
        self.placeImageView?.image          = self.placeImage
        DispatchQueue.main.async {
            self.commentsTableView?.reloadData()
        }
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: PostCommentViewController
                = segue.destination as? PostCommentViewController
        else {return}
        
        guard let commentsArray = self.commentsArray
        else {
            print("getting comments array failure")
            return
        }
        nextViewController.countOfComments = Double(commentsArray.count)
        guard let rating = Double(self.ratingText!)
        else {
            print("getting self.ratingText failure")
            return
        }
        nextViewController.placeRating = rating
    }
    

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
//                print(comment)
//                print(comment.value)
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
                Utils.shared.startLoading(view: self.view, activityIndicator: self.activityIndicator)

                imageReference.getData(maxSize: 10 * 1024 * 1024, completion: {
                    (data, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        DispatchQueue.main.async {
                            if let cellIndex: IndexPath = self.commentsTableView.indexPath(for: cell) {
                                if cellIndex.row == indexPath.row {
                                    let image = UIImage(data: data!)
                                    cell.commentImageView?.image = image
                                    
                                    Utils.shared.stopLoading(view: self.view, activityIndicator: self.activityIndicator)
                                }
                            }
                        }
                    }
                })
                cell.userIdLabel?.text = commentUserIdText
                cell.commentLabel?.text = commentCommentText
                cell.ratingLabel?.text =
                    String(commentRatingDouble)
                
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
