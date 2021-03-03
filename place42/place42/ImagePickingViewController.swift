//
//  ImagePickingViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/03.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Photos

class ImagePickingViewController: UIViewController, UICollectionViewDelegate
{
    let half: Double = Double(UIScreen.main.bounds.width / 2.0 - 1.5)

    // MARK: - getting images
    
    var fetchResult: PHFetchResult<PHAsset>!
    // imageManager는 애셋을 가지고 이미지를 로드해오는 역할을 한다.
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    let imageCollectionViewIdentifier: String = "imageCollectionViewIdentifier"
    @IBOutlet var imageCollectionView: UICollectionView!
    
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection>
            = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)

        
        let reversedDateOrderFetchOptions = PHFetchOptions()
        reversedDateOrderFetchOptions.sortDescriptors =
            [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        guard let album: PHAssetCollection =
            cameraRoll.firstObject
            else {return}
        
        fetchResult = PHAsset.fetchAssets(in: album, options: reversedDateOrderFetchOptions)
        self.imageCollectionView.reloadData()
//        guard let cameraRollCollection = cameraRoll.firstObject
//            else {return}
//
//
//
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
//        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection,options: fetchOptions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.requestCollection()
        
        let flowLayout = UICollectionViewFlowLayout()
        let availableWidth = self.imageCollectionView.bounds.inset(by: imageCollectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / 2)
        let cellWidth
            = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        flowLayout.itemSize = CGSize(width: half, height: half)
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        flowLayout.sectionInsetReference = .fromSafeArea
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 3
        self.imageCollectionView.setCollectionViewLayout(flowLayout, animated: true)

        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가됨")
        case .denied:
            print("사용자가 불허함")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch photoAuthorizationStatus {
                case .authorized:
                    print("접근 허가됨")
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        default: break
        }
        
    }
    
    
}
extension ImagePickingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        if let imageCount: Int = self.fetchResult?.count {
            return imageCount
        }
        return (0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AlbumImageCollectionViewCell =
            imageCollectionView.dequeueReusableCell(withReuseIdentifier: self.imageCollectionViewIdentifier, for: indexPath)
                as? AlbumImageCollectionViewCell
            else {return UICollectionViewCell()}
        
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        imageManager.requestImage(for: asset, targetSize: CGSize(width: half, height: half), contentMode: .aspectFill, options: nil, resultHandler: { (image, _) in
            cell.albumImageView?.image = image
        })
        
        
        return cell
    }
    

}
