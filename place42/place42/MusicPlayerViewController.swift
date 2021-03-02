//
//  MusicPlayerViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/02.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

     @IBAction func musicPlayButton(_ sender: Any) {
        MusicPlayer.shared.startBackgroundMusic()
    }
}
