//
//  GetImageViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/03.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class GetImageViewController: UIViewController {
    
    let picker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageAddAction(_ sender: Any) {
        let alert = UIAlertController(title: "올릴 방식을 선택하세요", message: "사진 찍기 또는 앨범에서 선택", preferredStyle: .actionSheet)
        let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) { (action) in
            self.openLibrary()
        }
        
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) {(action) in
            self.openCamera()
        }
        
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(photoLibraryAlertAction)
        alert.addAction(cameraAlertAction)
        alert.addAction(cancelAlertAction)
        
        self.present(alert, animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GetImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView?.image = image
            let imageData = image.jpegData(compressionQuality: 0.75)
            try! imageData?.write(to: imagePath!)
            print(imagePath)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
