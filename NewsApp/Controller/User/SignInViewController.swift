//
//  SignInViewController.swift
//  NewsApp
//
//  Created by Adi on 1/5/20.
//  Copyright © 2020 Aditya. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
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
        usernameIcon.tintColor = Color.appMainColor
        
        passwordIcon.image = UIImage(named: "Password")!.withRenderingMode(.alwaysTemplate)
        passwordIcon.tintColor = Color.appMainColor
        
        loginBtn.layer.cornerRadius = 6
        loginBtn.clipsToBounds = true
    }
    
    
    //MARK:- Empty/Incorrect Data Validation Methods
    func checkForValidation() -> Bool{
        if usernameTextField.text == "" || passwordTextField.text == ""{
            return false
        }
        
        return true
    }

    
    func checkKeychainData() -> Bool{
        if let receivedUsernameData = KeychainService.load(key: "Username"), let receivedPasswordData = KeychainService.load(key: "Password") {

            if (usernameTextField.text != receivedUsernameData.to(type: String.self)) || (passwordTextField.text != receivedPasswordData.to(type: String.self)){
                return false
            }else{
                return true
            }
        }
        
        return false
    }
    
    
    //MARK:- Button Actions
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
        dismissKeyBoard()
        if !(checkForValidation()){
            let alertController = UIAlertController(title: "Oops!!", message: "Please fill all fields", preferredStyle: .alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            
            self.present(alertController, animated: true, completion: nil)
        }else if !(checkKeychainData()){
            let alertController = UIAlertController(title: "Oops!!", message: "Incorrect Credentials", preferredStyle: .alert)
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
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        dismissKeyBoard()
        let  signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        signUpViewController?.modalPresentationStyle = .fullScreen
        self.present(signUpViewController!, animated: false, completion: nil)
    }
    
    
    //MARK:- Dismiss Keypad function
    func dismissKeyBoard(){
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
