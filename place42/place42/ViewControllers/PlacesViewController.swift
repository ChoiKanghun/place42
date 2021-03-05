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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        
        getPlaceInfo()
        // Do any additional setup after loading the view.
    }
    
    func getPlaceInfo(){
        
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

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var placesCount = 0
//        self.ref.child("places").getData {
//            (error, snapshot) in
//            if let error = error {
//                print("getting places data error")
//                print (error)
//            }
//            else if snapshot.exists() {
//                let values = snapshot.value
//                let places = values as! [String: [String: Any]]
//                placesCount = places.count
//                print("placesCount = \(placesCount)")
//            }
//            else {
//                print("No data available")
//            }
//        }
//        print("placesCount = \(placesCount)")
//        return placesCount
        return 1
        
    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PlaceTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.placesTableViewCellIdentifier) as? PlaceTableViewCell
        else { return UITableViewCell() }
        
        self.ref.child("places").getData {
            (error, snapshot) in
            if let error = error {
                print ("Error on getting places API data: \(error)")
            }
            else if snapshot.exists() {
                let values = snapshot.value
                let places = values as! [String: [String: Any]]
                for index in places {
                    for i in index.value {
                        let typeOfValue = String(describing: type(of: i.value))
                        
                        if typeOfValue == "NSTaggedPointerString" ||
                            typeOfValue == "__NSCFString" {
                            self.setTableViewCell(cell: cell, key: i.key, value: i.value as! String)
                        }
                        if typeOfValue == "__NSCFNumber"  {
                            self.setTableViewCell(cell: cell, key: i.key, value: String(describing: i.value))
                        }
                    }
                }
            }
            else {
                print ("no data available")
            }
        }
        
        
        return (cell)
    }
}
