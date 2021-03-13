//
//  CheckOauthLoginViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/13.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import Firebase

class CheckOauthLoginViewController: UIViewController {

    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBAction func signOutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("sign out!")
            self.navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error Signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userEmailString: String = UserOAuthInfo.shared.userEmail
        else {return}
        let startIndex = userEmailString.startIndex
        let endIndex = userEmailString.index(userEmailString.startIndex, offsetBy: 5)
        let indexRange = startIndex...endIndex
        let truncatedUserEmailString = userEmailString[indexRange]
        self.userEmailLabel?.text = truncatedUserEmailString + "***"
        
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
