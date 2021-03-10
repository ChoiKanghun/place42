//
//  PostCommentViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/09.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class PostCommentViewController: UIViewController {

    
    @IBOutlet weak var userCommentImageView: UIImageView!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    let alertController
        = UIAlertController(title: "올릴 방식을 선택하세요", message: "사진 찍기 또는 앨범에서 선택", preferredStyle: .actionSheet)
    let warningAlertController
        = UIAlertController(title: "id와 코멘트를 모두 채워주세요", message: "확인을 눌러주세요", preferredStyle: .alert)
    let imagePickerController = UIImagePickerController()
    
    var defaultImage: UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self

        setDefaultImageAndAddGestureRecognizer()
        setPlaceholderOnTextView()
        enrollAlertEvent()
        enrollWarningAlert()
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
    
    
    
    @objc func tappedUIImageView(_ gesture: UITapGestureRecognizer) {
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func touchUpSubmitButton(_ sender: UIBarButtonItem) {
        if self.userIdTextField?.text == "" {
            self.present(self.warningAlertController, animated: true, completion: nil)
        }
        else if self.commentTextView?.text == "한줄평을 입력하세요" {
            self.present(self.warningAlertController, animated: true, completion: nil)
            
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
