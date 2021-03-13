//
//  oAuthTestViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/13.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase


class oAuthTestViewController: UIViewController {

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    var handle: AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn() // 자동 로그인

    }
    
    // listener 연결.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
            if let user = user {
                
                var multiFactorString = "MutlFactor: "
                for info in user.multiFactor.enrolledFactors {
                    multiFactorString += info.displayName ?? "[DisplayName]"
                    multiFactorString += " "
                }
                print(multiFactorString)
            }
            guard let uid = user?.uid, let email = user?.email, let photoURL = user?.photoURL
            else {
                print("converting user.uid->uid failure")
                return
            }
            
            print("user.uid = \(uid)")
            print("user.email = \(email)")
            print("user.photoURL = \(photoURL.absoluteString)")
            UserOAuthInfo.shared.userEmail = email
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let nextViewController = storyBoard.instantiateViewController(identifier: "CheckOauthLoginViewController")
                as? CheckOauthLoginViewController {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            
            
        }
    }
    
    // listenr 분리
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
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
