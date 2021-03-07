//
//  PlacesViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/05.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase

class PlacesViewController: UIViewController {

    let storage = Storage.storage()
    var ref: DatabaseReference!
    
    @IBOutlet weak var placesTableView: UITableView!
    let placesTableViewCellIdentifier: String = "placesTableViewCell"
    
    var placesCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        
        getPlaceInfo()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func getPlaceInfo(){
        self.ref.child("places").getData {
            (error, snapshot) in
            if let error = error {
                print ("Error on getting places API data: \(error)")
            }
            else if snapshot.exists() {
                PlaceInfo.shared.placesData = snapshot
                DispatchQueue.main.async {
                    self.placesTableView.reloadData()
                }
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
    }

}

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // tableViewCell을 총 몇 개 나타낼 지 결정하는 함수.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(PlaceInfo.shared.placesData.childrenCount)
    }
    
    // tableViewCell의 사진과 레이블을 채우는 함수.
    func setTableViewCell(cell: PlaceTableViewCell, key: String, value: String) {
        if (key == "category") {
            DispatchQueue.main.async {
                cell.categoryLabel?.text = value
            }
        }
        else if (key == "address_korean") {
            DispatchQueue.main.async {
                cell.addressLabel?.text = value
            }
        }
        else if (key == "rating") {
            DispatchQueue.main.async {
                cell.ratingLabel?.text = value
            }
        }
        else if (key == "place_name") {
            DispatchQueue.main.async {
                cell.placeNameLabel?.text = value
            }
        }
        else if (key == "image_address") {
            let pathReference = storage.reference(withPath: "images")
            let islandRef = pathReference.child(value)
            islandRef.getData(maxSize: 10 * 1024 * 1024, completion: {
                (data, error) in
                if let error = error {
                    print ("Getting image error")
                    print(error)
                }
                else {
                    let image = UIImage(data: data!)
                    DispatchQueue.main.async {
                        cell.placeImageView?.image = image
                    }
                }
            })
        }
        else {
            return
        }
    }

    // 각각의 tableViewCell에 대한 처리를 담당하는 함수.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.placesTableViewCellIdentifier, for: indexPath) as? PlaceTableViewCell
        else { return UITableViewCell() }

        guard let placeInfoDataValue = PlaceInfo.shared.placesData.value
        else { return UITableViewCell() }
        let places = placeInfoDataValue as! [String: [String: Any]]
        var index: Int = 0
        
        for place in places {
            if (index == indexPath.row) {
                for i in place.value {
                    let typeOfValue = String(describing: type(of: i.value))
                    if typeOfValue == "NSTaggedPointerString" ||
                        typeOfValue == "__NSCFString" {
                        self.setTableViewCell(cell: cell, key: i.key,value: i.value as! String)
                    }
                    else if typeOfValue == "__NSCFNumber" {
                        self.setTableViewCell(cell: cell, key: i.key,value: String(describing: i.value))
                    }
                }
            }
            index += 1
        }
        return (cell)
    }
    
    // 각 tableViewCell의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    // 각 cell을 클릭했을 때에 대한 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell: PlaceTableViewCell = self.placesTableView.cellForRow(at: indexPath) as? PlaceTableViewCell
        else {return}
        
        PlaceInfo.shared.placeName      = cell.placeNameLabel?.text
        PlaceInfo.shared.placeCategory  = cell.categoryLabel?.text
        PlaceInfo.shared.placeAddress   = cell.addressLabel?.text
        PlaceInfo.shared.placeRating    = cell.ratingLabel?.text
        PlaceInfo.shared.placeImage     = cell.placeImageView?.image
        
        guard let placeInfoDataValue = PlaceInfo.shared.placesData.value
        else {
            print ("error getting placeInfoData on didSelectRowAt")
            return
        }


        for index in 0..<PlaceInfo.shared.placesData.childrenCount {
            if index == indexPath.row {
                let places = placeInfoDataValue as! [String: [String: Any]]
                let placesArray = Array(places)
                let place = placesArray[Int(index)].value
                guard let comments = place["comments"]
                else {
                    print("getting comments of a place error")
                    return
                }
//                print (comments)
//                print (type(of: comments))
                guard let commentsNSDictionary = comments as? [String: [String:Any]]
                else {
                    print("converting to commentsNsDictionary error")
                    return
                }
                PlaceInfo.shared.commentsNSDictionary = commentsNSDictionary as NSDictionary
//                let commentsArray = Array(commentsNSDictionary)
//
//                PlaceInfo.shared.commentsArray = commentsArray
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard
                        = UIStoryboard(name: "Main", bundle: nil)
                    let nextViewController  = storyBoard.instantiateViewController(identifier: "DetailPlaceViewController") as! DetailPlaceViewController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
                return
            }
        }

            
    }
}
