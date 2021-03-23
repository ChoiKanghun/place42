//
//  AppPushTestSecondViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/23.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

let DidReceiveEnrollGoodsNotification: Notification.Name
    = Notification.Name("DidReceiveEnrollGoods")

class AppPushTestSecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpEnrollGoodsButton(_ sender: UIBarButtonItem) {
        guard let textFieldText = self.textField.text
        else {return}
        guard let textViewText = self.textView.text
        else {return}
        NotificationCenter.default.post(name: DidReceiveEnrollGoodsNotification, object: nil, userInfo: ["enrollGoods":"\(textFieldText) \(textViewText)"])
        
        self.navigationController?.popViewController(animated: true)
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
