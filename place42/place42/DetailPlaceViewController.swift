//
//  DetailPlaceViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/05.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class DetailPlaceViewController: UIViewController {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.placeNameLabel?.text = PlaceInfo.shared.placeName
        self.categoryLabel?.text = PlaceInfo.shared.placeCategory
        self.addressLabel?.text = PlaceInfo.shared.placeAddress
        self.ratingLabel?.text = PlaceInfo.shared.placeRating
        self.placeImageView?.image = PlaceInfo.shared.placeImage
        self.commentsTableView.delegate = self
        self.commentsTableView.dataSource = self
        
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

extension DetailPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
