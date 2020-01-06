//
//  LandingViewController.swift
//  NewsApp
//
//  Created by Adi on 1/5/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var newAccountBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK:- UI Setup Methods
    func setUpUI(){
        newAccountBtn.layer.cornerRadius = 6
        newAccountBtn.clipsToBounds = true
        
        signInBtn.layer.cornerRadius = 6
        signInBtn.clipsToBounds = true
    }
    

    //MARK:- Button Actions
    @IBAction func newAccountBtnClicked(_ sender: UIButton) {
        print("newAccountBtnClicked")
        let  signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        signUpViewController?.modalPresentationStyle = .fullScreen
        self.present(signUpViewController!, animated: false, completion: nil)
    }
    
    
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        print("signInBtnClicked")
        let  signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        signInViewController?.modalPresentationStyle = .fullScreen
        self.present(signInViewController!, animated: false, completion: nil)

    }
    

}
