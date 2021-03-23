//
//  DetailPlaceViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/05.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


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
    @IBOutlet weak var toPostCommentButton: UIButton!
    @IBOutlet weak var placeInfoView: UIView!
    
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewHeightConstant: NSLayoutConstraint!
    
    let tableViewCellIdentifier: String = "commentTableViewCell"

    var ref: DatabaseReference!
    let storage = Storage.storage()
    
    // 화면이 완전히 로딩되기 전까지 로딩 이미지를 표시함.
    lazy var activityIndicator = Utils.shared.activityIndicator
    
    var maxTopHeight: CGFloat = 380
    var minTopHeight: CGFloat = 50
    
    @IBAction func touchUpImageView(_ sender: UITapGestureRecognizer) {
        self.viewTopHeight.constant = maxTopHeight
        self.commentsTableView.contentOffset.y = 0
    }
    
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
    
    @objc func didReceivePostCommentNotification(_ noti: Notification) {
        // 데이터를 다시 가져옴
        
        guard let placeKey = PlaceInfo.shared.placeKey
        else {
            print("cannot get placeKey")
            return
        }
        self.ref.child("places/\(placeKey)/user_comments").observeSingleEvent(of: .value, andPreviousSiblingKeyWith: {
            (snapshot, error) in
            let commentsInfo = snapshot.value as? [String:AnyObject] ?? [:]
            let commentsInfoArray = Array(commentsInfo)
            self.commentsArray = commentsInfoArray
        })
        
        DispatchQueue.main.async {
            self.commentsTableView.reloadData()
        } // 이건 꼭 해줘야. 메인쓰레드에서 하지 않으면 에러
        
        // 아래는 토스트 메시지 출력
        let width_variable:CGFloat = 10
        let toastLabel = UILabel(frame: CGRect(x: width_variable,y:self.view.frame.size.height-100,width:view.frame.size.width-2*width_variable, height: 35))
        // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는양쪽에10만큼 여백을 가지며, 높이는 35로
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = "업로드 성공"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1,options:.curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func setLayers() {
        self.toPostCommentButton.layer.cornerRadius = self.view.frame.width / 20
        self.placeInfoView.layer.shadowColor = UIColor.black.cgColor
        self.placeInfoView.layer.masksToBounds = false
        self.placeInfoView.layer.shadowOffset = CGSize(width: 0, height: 4) // 반경에 대해서 너무 적용이 되어서 4point 정도 내림.
        self.placeInfoView.layer.shadowRadius = 8 // 반경?
        self.placeInfoView.layer.shadowOpacity = 0.3 // alpha값입니다.
    }
    
    func ifDeviceIpad() {
        if ScreenSize.shared.screenHeight > 1000 {
            self.viewTopHeight.constant = 540
            self.maxTopHeight = 540
            self.minTopHeight = self.minTopHeight * 1.5
            self.imageViewHeightConstant.constant = 380
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ref = Database.database().reference()
        self.commentsTableView.delegate     = self
        self.commentsTableView.dataSource   = self
        
        self.view.addSubview(self.activityIndicator)
        
        self.commentsTableView.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceivePostCommentNotification), name: DidReceivePostCommentOccuredNotification, object: nil)
        self.commentsTableView.sectionIndexBackgroundColor = .gray

        ifDeviceIpad()
        setLayers()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        
        self.placeNameLabel?.text           = self.placeNameText
        self.categoryLabel?.text            = self.categoryText
        self.ratingLabel?.text              = "\(self.ratingText ?? "") (\(String(self.commentsArray?.count ?? 0)))"
        self.addressLabel?.text             = "\(self.addressText ?? "")"
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
        guard let cell = self.commentsTableView.cellForRow(at: indexPath) as? CommentTableViewCell
        else {
            print("can't get indexPath's cell")
            return
        }
        cell.isSelected = false
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyBoard.instantiateViewController(identifier: "CommentDetailViewController") as? CommentDetailViewController {
            DispatchQueue.main.async {
                guard let ratingText = cell.ratingLabel.text
                else {
                    print("cannot convert ratingLabelText -> ratingText")
                    return
                }
                guard let rating = Float(ratingText)
                else {
                    print("cannot covnert ratingText -> rating")
                    return
                }
                
                nextViewController.image = cell.commentImageView?.image
                nextViewController.sliderValue =
                    rating
                nextViewController.commentLabelText =
                    cell.commentLabel?.text
                nextViewController.userLabelText =
                    cell.userIdLabel?.text
            // placeKey는 PostCommentViewController에서 씀.
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
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
                
                Utils.shared.startLoading(view: self.view, activityIndicator: self.activityIndicator)
                
                let imageReference = storageImagesReference.child("\(commentImageAddress)")

                imageReference.downloadURL {
                    (url, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        DispatchQueue.main.async {
                            if let cellIndex: IndexPath = self.commentsTableView.indexPath(for: cell) {
                                if cellIndex.row == indexPath.row {
                                    cell.commentImageView.sd_setImage(with: url!, completed: nil)
                                    Utils.shared.stopLoading(view: self.view, activityIndicator: self.activityIndicator)
                                }
                            }
                        }
                    }
                }
                cell.userIdLabel?.text = commentUserIdText
                cell.commentLabel?.text = commentCommentText
                cell.ratingLabel?.text =
                    String(commentRatingDouble)
                
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}

extension DetailPlaceViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // 현재 스크롤의 위치 (최상단 = 0)
            let y: CGFloat = scrollView.contentOffset.y
            
            //변경될 최상단 뷰의 높이
            let ModifiedTopHeight: CGFloat = viewTopHeight.constant - y
            
            // *** 변경될 높이가 최댓값을 초과함
            if(ModifiedTopHeight > maxTopHeight)
            {
                //현재 최상단뷰의 높이를 최댓값(250)으로 설정
                viewTopHeight.constant = maxTopHeight
            }// *** 변경될 높이가 최솟값 미만임
            else if(ModifiedTopHeight < minTopHeight)
            {
                //현재 최상단뷰의 높이를 최솟값(50+상태바높이)으로 설정
                viewTopHeight.constant = minTopHeight
            }// *** 변경될 높이가 최솟값(50+상태바높이)과 최댓값(250) 사이임
            else
            {
                //현재 최상단 뷰 높이를 변경함
                viewTopHeight.constant = ModifiedTopHeight
                scrollView.contentOffset.y = 0
            }
    }
}
