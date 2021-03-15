//
//  PostCommentViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/09.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase

let DidReceivePostCommentOccuredNotification: Notification.Name
    = Notification.Name("DidReceivePostCommentOccured")

class PostCommentViewController: UIViewController {

    let storage = Storage.storage()
    var ref: DatabaseReference!
    var countOfComments: Double = 0
    var placeRating: Double = 0
    
    @IBOutlet weak var userCommentImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var userLoginEmailLabel: UILabel!
    
    let alertController
        = UIAlertController(title: "올릴 방식을 선택하세요", message: "사진 찍기 또는 앨범에서 선택", preferredStyle: .actionSheet)
    let warningAlertController
        = UIAlertController(title: "id와 코멘트를 모두 채워주세요", message: "확인을 눌러주세요", preferredStyle: .alert)
    let imagePickerController = UIImagePickerController()
    var defaultImage: UIImage?
    
    
    
    @IBAction func onDragStarSlider(_ sender: UISlider) {
        let floatValue = floor(sender.value * 10) / 10
        
        for index in 1...5 {
            if let starImage = view.viewWithTag(index) as? UIImageView {
                if Float(index) <= floatValue {
                    starImage.image = UIImage(named: "star_full")
                }
                else if (Float(index) - floatValue) <= 0.5 {
                    starImage.image = UIImage(named: "star_half")
                }
                else {
                    starImage.image = UIImage(named: "star_empty")
                }
            }
        }
        self.ratingLabel?.text = String(floatValue)
    }
    
    
    func enrollWarningAlert() {
        let warningAlertAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
            self.dismiss(animated: true, completion: nil)
        }
        self.warningAlertController.addAction(warningAlertAction)
        guard let warningAlertControllerPopoverPresentationController
                = warningAlertController.popoverPresentationController
        else {return}
        prepareForPopoverPresentation(warningAlertControllerPopoverPresentationController)
    }
    
    func enrollAlertEvent() {
        let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) {
            (action) in
            self.openAlbum()
        }
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) {(action) in
            self.openCamera()
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        self.alertController.addAction(photoLibraryAlertAction)
        self.alertController.addAction(cameraAlertAction)
        self.alertController.addAction(cancelAlertAction)
        guard let alertControllerPopoverPresentationController
                = alertController.popoverPresentationController
        else {return}
        prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
    @objc func tappedUIImageView(_ gesture: UITapGestureRecognizer) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setDefaultImageAndAddGestureRecognizer() {
        guard let defaultImage = UIImage(named: "no_image_img")
        else {
            print("getting default uiimage failure")
            return
        }
        self.defaultImage = defaultImage
        self.userCommentImageView?.image = defaultImage
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedUIImageView(_:)))
        self.userCommentImageView.addGestureRecognizer(tapGestureRecognizer)
        self.userCommentImageView.isUserInteractionEnabled = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        ref = Database.database().reference()

        guard let userEmail = UserOAuthInfo.shared.userEmail
        else {
            print("can't get UserOAUTH email on PostCommentVC")
            return
        }
        self.userLoginEmailLabel?.text = userEmail
        
        setDefaultImageAndAddGestureRecognizer()
        setPlaceholderOnTextView()
        enrollAlertEvent()
        enrollWarningAlert()
        
        self.starSlider.minimumTrackTintColor = .clear
        self.starSlider.maximumTrackTintColor = .clear
        self.starSlider.thumbTintColor = .clear
        
    }
 
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss_SSSS"
        return (formatter.string(from: date))
    }
    
    func uploadImage(image: UIImage) -> String {
        var isSuccess: Bool = true
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = "image" + dateToString(Date())
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child("images").child(filePath).putData(data, metadata: metaData) {
            (metaData, error) in
            if let error = error {
                print(error)
                isSuccess = false
                return
            } else {
                print("이미지 업로드 성공")
                isSuccess = true
            }
        }
        if (isSuccess == false) { return ("fail") }
        else { return (filePath) }
    }
    
   
    
    @IBAction func touchUpSubmitButton(_ sender: UIBarButtonItem) {
        
        var imagePath: String?
        guard let userEmailTruncated = UserOAuthInfo.shared.getTruncatedUserEmail()
        else {return}
        guard let commentTextViewText = self.commentTextView?.text
        else {return}
        guard let commentRating = Double((self.ratingLabel?.text)!)
        else {return}
        guard let commentImage: UIImage = self.userCommentImageView?.image
        else {return}
        
        // textView가 비었는지 확인
        if commentTextViewText == "한줄평을 입력하세요" {
            self.present(self.warningAlertController, animated: true, completion: nil)
            return
        }
        // 이미지가 default 이미지와 같다면 미리 지정해둔 이미지를 올립니다.
        // 그게 아니라면 사용자의 이미지를 uploadImage함수를 통해 올립니다.
        if commentImage == self.defaultImage {
            imagePath = "default_image.png"
        }
        else {
            imagePath = uploadImage(image: commentImage)
            if imagePath == "fail" {
                print("uploading image has been failed")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        // 저장해두었던 현재 place의 Key를 가져옵니다.
        guard let placeKey: String = PlaceInfo.shared.placeKey
            else {
                print("getting placeInfo.shared.placeKey error")
                return
            }
        
        self.ref.child("places/\(placeKey)/user_comments").childByAutoId().setValue([
            "comment":"\(commentTextViewText)",
            "user_id":"\(userEmailTruncated)",
            "comment_rating": commentRating,
            "comment_image_address": "\(imagePath!)"
        ])
        
        let placeRatingRawValue: Double
            = (self.countOfComments * self.placeRating + commentRating) / (self.countOfComments + 1)
        let placeRating: Double = floor(placeRatingRawValue * 10) / 10
        self.ref.child("places/\(placeKey)").updateChildValues(["rating":placeRating])
        
        self.navigationController?.popViewController(animated:true)
        NotificationCenter.default.post(name:DidReceivePostCommentOccuredNotification, object:nil, userInfo: nil)
    }
    
}
extension PostCommentViewController: UITextViewDelegate {
    func setPlaceholderOnTextView() {
        self.commentTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        commentTextView.text = "한줄평을 입력하세요"
        commentTextView.textColor = UIColor.lightGray
        commentTextView.backgroundColor = UIColor.systemGray6
    }
        
        // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = nil
            commentTextView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text.isEmpty {
            commentTextView.text = "한줄평을 입력하세요"
            commentTextView.textColor = UIColor.lightGray
        }
    }
}

extension PostCommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openAlbum() {
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: false, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.imagePickerController.sourceType = .camera
            present(self.imagePickerController, animated: false, completion: nil)
        }
        else {
            print ("Camera's not available as for now.")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            userCommentImageView?.image = image
        }
        else {
            print("error detected in didFinishPickinMediaWithInfo method")
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostCommentViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController = self.alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}
