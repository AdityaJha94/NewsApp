//
//  SignUpViewController.swift
//  NewsApp
//
//  Created by Adi on 1/5/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    //MARK:- ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    
    //MARK:- UI Setup Method
    func setUpUI(){
        usernameIcon.image = UIImage(named: "Email")!.withRenderingMode(.alwaysTemplate)
        usernameIcon.tintColor = UIColor(red:1.00, green:0.32, blue:0.21, alpha:1.0)
        
        passwordIcon.image = UIImage(named: "Password")!.withRenderingMode(.alwaysTemplate)
        passwordIcon.tintColor = UIColor(red:1.00, green:0.32, blue:0.21, alpha:1.0)
        
        registerBtn.layer.cornerRadius = 6
        registerBtn.clipsToBounds = true
    }
    
    
    //MARK:- Empty/Saved Data Validation Methods
    func checkForValidation() -> Bool{
        if usernameTextField.text == "" || passwordTextField.text == ""{
            return false
        }
        return true
    }
    
    func savedToKeychain() -> Bool{
        let usernameData = Data(from: usernameTextField.text)
        let status1 = KeychainService.save(key: "Username", data: usernameData)
        print("status: ", status1)
        
        let passwordData = Data(from: passwordTextField.text)
        let status2 = KeychainService.save(key: "Password", data: passwordData)
        print("status: ", status2)
        
        if let receivedUsernameData = KeychainService.load(key: "Username"), let receivedPasswordData = KeychainService.load(key: "Password") {
//            let result = receivedPasswordData.to(type: String.self)
//            print("result: ", result)
            print("Username: ", receivedUsernameData.to(type: String.self))
            print("Password: ", receivedPasswordData.to(type: String.self))
            return true
        }
        
        return false
    }
    
    //MARK:- Button Actions
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        //Set NewsListViewController as Root ViewController
        
        if !(checkForValidation()){
            
            let alertController = UIAlertController(title: "Oops!!", message: "Please fill all fields", preferredStyle: .alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        }else if !(savedToKeychain()){
            let alertController = UIAlertController(title: "Oops!!", message: "Error Saving Data", preferredStyle: .alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let newsListVC = storyBoard.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
            let navigationController = UINavigationController(rootViewController: newsListVC)
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window!.rootViewController = navigationController
        }
        
    }
    
    
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        let  signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        signInViewController?.modalPresentationStyle = .fullScreen
        self.present(signInViewController!, animated: false, completion: nil)
        
    }
    
}
