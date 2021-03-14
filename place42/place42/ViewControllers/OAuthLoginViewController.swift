//
//  OAuthLoginViewController.swift
//  place42
//
//  Created by 최강훈 on 2021/03/14.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class OAuthLoginViewController: UIViewController {


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
            if let nextViewController = storyBoard.instantiateViewController(identifier: "PlacesViewController")
                as? PlacesViewController {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
        }
    }
    
    // listener 분리
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }


}
