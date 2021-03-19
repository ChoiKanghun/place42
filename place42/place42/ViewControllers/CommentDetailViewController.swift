//
//  CommentDetailViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/16.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class CommentDetailViewController: UIViewController {

    var image: UIImage?
    var sliderValue: Float?
    var commentLabelText: String?
    var userLabelText: String?
    
    @IBOutlet weak var commentDetailImageView: UIImageView!
    @IBOutlet weak var commentDetailUserIdLabel: UILabel!
    @IBOutlet weak var commentDetailStarSlider: CustomUISlider!
    @IBOutlet weak var commentDetailCommentLabel: UILabel!
    @IBOutlet weak var commentDetailRatingLabel: UILabel!

    
    func setStarImages() {
        let floatValue = floor(self.commentDetailStarSlider.value * 10) / 10
        
        for index in 1...5 {
            if let starImage = view.viewWithTag(index) as? UIImageView {
                if Float(index) <= floatValue {
                    starImage.image = UIImage(named: "star_full")
                }
                else if (Float(index) - floatValue) <= 0.5 {
                    starImage.image = UIImage(named: "star_half")
                }
                else {
                    starImage.image = UIImage(named:"star_empty")
                }
            }
        }
        
        self.commentDetailRatingLabel?.text = String(floatValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentDetailStarSlider.minimumTrackTintColor = .clear
        self.commentDetailStarSlider.maximumTrackTintColor = .clear
        self.commentDetailStarSlider.thumbTintColor = .clear
        self.commentDetailStarSlider.isUserInteractionEnabled = false
        
        // Do any additional setup after loading the view.
        self.commentDetailCommentLabel?.text = self.commentLabelText
        self.commentDetailStarSlider?.value = self.sliderValue!
        self.commentDetailUserIdLabel?.text = self.userLabelText
        self.commentDetailImageView?.image = self.image
        self.commentDetailUserIdLabel.backgroundColor = .systemGray5
        self.commentDetailCommentLabel.backgroundColor = .systemGray6
        setStarImages()

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
