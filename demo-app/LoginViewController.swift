//
//  LoginViewController.swift
//  demo-app
//
//  Created by Josh Payne on 6/14/17.
//  Copyright © 2017 R|TRIBE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift


class LoginViewController: UIViewController {
    var authtoken = String();
    let keychain = KeychainSwift()
    var toggleSelected = 0;
    var inputContainerHeightConstraint: NSLayoutConstraint?
    var nameHeightConstraint: NSLayoutConstraint?
    var emailHeightConstraint: NSLayoutConstraint?
    var baseURL: String = "https://ios-starter-backend.herokuapp.com/"
    var params = Dictionary<String, String>();
    override func viewDidLoad() {
        super.viewDidLoad()
        if (keychain.get(emailTF.text!) == nil) {
            setupContainer()
        }
        else {
            segueToProducts()
        }
    }
    
    func segueToProducts() {
        let productsVC = ProductsViewController()
        self.navigationController?.present(productsVC, animated: true, completion: nil)
    }
    
    func gatherLoginInfo() {
        if (isValidEmail(emailStr: emailTF.text!) && passwordTF.text != "") {
            if (toggleSelected == 0) {
                postToDB(dbURL: "api/v1/users/sign_up")
            }
            if (toggleSelected == 1) {
                postToDB(dbURL: "api/v1/users/sign_in")
            }
        }
    }
    
    func postToDB(dbURL: String) {
        params = [
            "password":passwordTF.text!,
            "email":emailTF.text!
        ]
        Alamofire.request(baseURL + dbURL, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON {
            response in let _:Error? //error handled with .failure case
            switch response.result {
            case .success(let json):
                print(json)
                let parseable = JSON(json)
                self.keychain.set(self.passwordTF.text!, forKey: parseable["auth_token"].stringValue)
                // update UI on main thread
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Welcome!", message: nil, preferredStyle: .alert);
                    alertController.addAction(UIAlertAction(title: "Thanks!", style: .default,handler: nil));
                    self.present(alertController, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func keyStore() {
        //try Locksmith.saveData(["auth_token": "authtoken"], forUserAccount: params)
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: emailStr)
    }
    
    var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 90/255, green: 100/255, blue: 200/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(gatherLoginInfo), for: .touchUpInside)
        return button
    }()
    
    let emailTF: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let emailLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTF: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        return field
    }()
    
    let pwLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints =  false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterToggle: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(registerLoginSwitch), for: UIControlEvents.valueChanged)
        return sc
    }()
    
    func registerLoginSwitch () {
        let title = loginRegisterToggle.titleForSegment(at: loginRegisterToggle.selectedSegmentIndex)
        toggleSelected = loginRegisterToggle.selectedSegmentIndex
        loginRegisterButton.setTitle(title, for: .normal)
        emailHeightConstraint = emailTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: loginRegisterToggle.selectedSegmentIndex == 0 ? 0 : 1/2)
        emailHeightConstraint?.isActive = false
    }
    
    func setupContainer() {
        
        view.backgroundColor = UIColor(red: 50/255, green: 70/255, blue: 150/255, alpha: 1)
        
        //text input, toggle setup
        view.addSubview(loginRegisterToggle)
        view.addSubview(inputContainer)
        
        //text input constraints
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        inputContainerHeightConstraint = inputContainer.heightAnchor.constraint(equalToConstant: 100)
        inputContainerHeightConstraint?.isActive = true
        
        //views setup
        inputContainer.addSubview(emailTF)
        inputContainer.addSubview(emailLine)
        inputContainer.addSubview(passwordTF)
        
        //toggle constraints
        loginRegisterToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterToggle.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -12).isActive = true
        loginRegisterToggle.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginRegisterToggle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //email text field constraints
        emailHeightConstraint = emailTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/2)
        emailTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailHeightConstraint?.isActive = true
        
        //email line constraints
        emailLine.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        emailLine.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        emailLine.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password text field constraints
        passwordTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        passwordTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/2).isActive = true
        
        //login / registration button setup and constraints
        view.addSubview(loginRegisterButton)
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
