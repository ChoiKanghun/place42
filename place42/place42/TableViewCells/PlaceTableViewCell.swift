//
//  PlaceTableViewCell.swift
//  place42
//
//  Created by 최강훈 on 2021/03/05.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var goToDetailUIButton: UIButton!
//
//    @IBAction func goToDetail(_ sender: UIButton) {
//        PlaceInfo.shared.placeName = self.placeNameLabel?.text
//        PlaceInfo.shared.placeCategory = self.categoryLabel?.text
//        PlaceInfo.shared.placeAddress = self.addressLabel?.text
//        PlaceInfo.shared.placeRating = self.ratingLabel?.text
//        PlaceInfo.shared.placeImage = self.placeImageView?.image
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "DetailPlaceViewController", bundle: nil)
//        let detailPlaceViewController = storyBoard.instantiateViewController(identifier: "DetailPlaceViewController") as! DetailPlaceViewController
//        self.present(detailPlaceViewController)
//
//        let newViewController: DetailPlaceViewController = DetailPlaceViewController()
//
//
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
