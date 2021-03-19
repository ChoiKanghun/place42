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
    
    lazy var activityIndicator = Utils.shared.activityIndicator
    
    @IBAction func touchUpSignOutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("signOut success")
            self.navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error Signing out: %@", signOutError)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        self.configureNavigation()
        
        self.placesTableView.addSubview(self.activityIndicator)
        self.placesTableView.rowHeight = UITableView.automaticDimension
        getPlaceInfo()
        self.placesTableView.frame
            = CGRect(x: 0, y: 0, width: ScreenSize.shared.screenWidth, height: ScreenSize.shared.screenHeight)
        self.placesTableView.backgroundColor = .white
    }
   
   
    func configureNavigation()  {
           self.navigationItem.title = "42 Places"
           self.navigationController?.navigationBar.barTintColor = .black
           self.navigationController?.navigationBar.backgroundColor = .white
           let attributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont(name: "Verdana-bold", size: 17)]
           self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func getPlaceInfo() {
        self.ref.child("places").observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, error) in
            let places = snapshot.value as? [String:AnyObject] ?? [:]
//            print(type(of: places)) // Dictionary<String, AnyObj>
            self.placesArray = Array(places)
 
            DispatchQueue.main.async {
                self.placesTableView.reloadData()
            }
        })
    }
    
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
        
        Utils.shared.startLoading(view: self.view, activityIndicator: self.activityIndicator)
        for index in 0..<placesDataArray.count {
            if index == indexPath.row {
                let place = placesDataArray[index]
//                print(place)
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
                imageReference.downloadURL {
                    (url, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        DispatchQueue.main.async {
                            if let cellIndex: IndexPath = self.placesTableView.indexPath(for: cell) {
                                if cellIndex.row == indexPath.row {
                                    cell.placeImageView.sd_setImage(with: url!, completed: nil)
                                    Utils.shared.stopLoading(view: self.view, activityIndicator: self.activityIndicator)
                                }
                            }
                        }
                    }
                }
                cell.addressLabel?.text = addressLabelText
                cell.placeNameLabel?.text = placeNameLabelText
                cell.categoryLabel?.text = categoryLabelText
                cell.ratingLabel?.text = String(ratingLabelRawValue)
            }
            
        }
        return (cell)
    }

    // 각 tableViewCell의 높이
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 130
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
        
        cell.isSelected = false

        
        for index in 0..<placesDataArray.count {
            if index == indexPath.row {
                let place = placesDataArray[index]
//                print(place.key) // place의 key를 얻어올 수 있다.
//                print(type(of: place.key))
                self.ref.child("places/\(place.key)/user_comments").queryOrderedByKey().observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, error) in
//                    print(snapshot)
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
                            PlaceInfo.shared.placeKey = place.key
                        // placeKey는 PostCommentViewController에서 씀.
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
