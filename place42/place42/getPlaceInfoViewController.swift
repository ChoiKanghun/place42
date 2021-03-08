//
//  getPlaceInfoViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/08.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase

class getPlaceInfoViewController: UIViewController {

    @IBOutlet weak var placeTableView: UITableView!
    
    let storage = Storage.storage()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.placeTableView.delegate = self
        self.placeTableView.dataSource = self
    }
    

}

extension getPlaceInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
