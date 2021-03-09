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
    
    var placesArray: Array<(key: String, value: AnyObject)>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        
        testGetPlaceInfo()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func testGetPlaceInfo() {
        self.ref.child("places").observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, error) in
            let places = snapshot.value as? [String:AnyObject] ?? [:]
//            print(type(of: places)) // Dictionary<String, AnyObj>
            self.placesArray = Array(places)
 
            DispatchQueue.main.async {
                self.placesTableView.reloadData()
            }
        })
    }
    
    func getPlaceInfo(){
        self.ref.child("places").getData {
            (error, snapshot) in
            if let error = error {
                print ("Error on getting places API data: \(error)")
            }
            else if snapshot.exists() {
                
//                PlaceInfo.shared.placesData = snapshot
            }
        }
    }
    
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//    }

}

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {

    // tableViewCell을 총 몇 개 나타낼 지 결정하는 함수.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let places = self.placesArray
        else {
            print ("error on getting placesArray")
            return 0
        }
        return places.count
    }

    // 각각의 tableViewCell에 대한 처리를 담당하는 함수.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let storageImagesReference = self.storage.reference(withPath: "images")
        
        guard let cell: PlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.placesTableViewCellIdentifier, for: indexPath) as? PlaceTableViewCell
        else { return UITableViewCell() }

        guard let placesDataArray: Array<(key: String, value: AnyObject)> = self.placesArray
        else {
            print("getting self.placesArray error")
            return UITableViewCell()
        }
        
        for index in 0..<placesDataArray.count {
            if index == indexPath.row {
                let place = placesDataArray[index]
                print(place)
                guard let addressLabelText = place.value["address_korean"]
                        as? String
                else {return UITableViewCell()}
                guard let placeNameLabelText = place.value["place_name"]
                        as? String
                else {return UITableViewCell()}
                guard let categoryLabelText = place.value["category"]
                        as? String
                else {return UITableViewCell()}
                guard let ratingLabelRawValue = place.value["rating"]
                        as? Double
                else {return UITableViewCell()}
                guard let imageAddress = place.value["image_address"]
                        as? String
                else {return UITableViewCell()}
                let imageReference = storageImagesReference.child("\(imageAddress)")
                print(imageAddress)
                imageReference.getData(maxSize: 10 * 1024 * 1024, completion: {
                    (data, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        let image = UIImage(data: data!)
                        cell.placeImageView?.image = image
                        cell.addressLabel?.text = addressLabelText
                        cell.placeNameLabel?.text = placeNameLabelText
                        cell.categoryLabel?.text = categoryLabelText
                        cell.ratingLabel?.text = String(ratingLabelRawValue)
                    }
                })
                
            }
        }
        return (cell)
    }

    // 각 tableViewCell의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }

    // 각 cell을 클릭했을 때에 대한 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        guard let placesDataArray: Array<(key: String, value: AnyObject)> = self.placesArray
        else {
            print("getting self.placesArray error on didselectRowAt")
            return
        }

        guard let cell: PlaceTableViewCell = self.placesTableView.cellForRow(at: indexPath) as? PlaceTableViewCell
        else {return}

        
        for index in 0..<placesDataArray.count {
            if index == indexPath.row {
                let place = placesDataArray[index]
//                print(place.key) // place의 key를 얻어올 수 있다.
//                print(type(of: place.key))
                self.ref.child("places/\(place.key)/user_comments").observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, error) in
                    print(snapshot)
                    let commentsInfo = snapshot.value as? [String:AnyObject] ?? [:]
                    let commentsInfoArray = Array(commentsInfo)
//                    print(type(of: placeInfoArray)) //Array<(key: String, value: AnyObject)>

                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let nextViewController = storyBoard.instantiateViewController(identifier: "DetailPlaceViewController") as? DetailPlaceViewController {
                        DispatchQueue.main.async {
                            nextViewController.commentsArray = commentsInfoArray
                            nextViewController.addressText = cell.addressLabel?.text
                            nextViewController.placeNameText =
                                cell.placeNameLabel?.text
                            nextViewController.ratingText = cell.ratingLabel?.text
                            nextViewController.categoryText = cell.categoryLabel?.text
                            nextViewController.placeImage = cell.placeImageView?.image
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }
                    else {
                        print("storyBoard instantiating failure")
                        return
                    }
                    
                })
            }
        }
        
    }
}
