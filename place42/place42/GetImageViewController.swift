//
//  GetImageViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/03.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class GetImageViewController: UIViewController {

    let storage = Storage.storage()
    let picker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    let alertController = UIAlertController(title: "올릴 방식을 선택하세요", message: "사진 찍기 또는 앨범에서 선택", preferredStyle: .actionSheet)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) {
            (action) in
            self.openLibrary()
        }
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) {(action) in
            self.openCamera()
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(photoLibraryAlertAction)
        alertController.addAction(cameraAlertAction)
        alertController.addAction(cancelAlertAction)
        guard let alertControllerPopoverPresentationController
                = alertController.popoverPresentationController
        else {return}
        prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    

    
    @IBAction func imageAddAction(_ sender: Any) {

        self.present(alertController, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else {
            print ("Camera's not available as for now.")
        }
        
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss_SSSS"
        return (formatter.string(from: date))
    }
    
    func uploadImage(image: UIImage) -> String {
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = "image" + dateToString(Date())
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData) {
            (metaData, error) in
            if let error = error {
                print(error)
                return
            } else {
                print("업로드 성공")
            }
        }
        return ("")
    }
}

extension GetImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView?.image = image
            uploadImage(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension GetImageViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController = self.alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
    

}
