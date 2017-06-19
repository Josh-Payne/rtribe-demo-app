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

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainer()
        
    }
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 30/255, green: 35/255, blue: 100/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
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
    
    let inputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints =  false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    func setupContainer() {
        view.backgroundColor = UIColor(red: 50/255, green: 70/255, blue: 150/255, alpha: 1)
        
        //text input setup
        view.addSubview(inputContainer)
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        inputContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //views setup
        inputContainer.addSubview(emailTF)
        inputContainer.addSubview(emailLine)
        inputContainer.addSubview(passwordTF)

        //email text field
        emailTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/2).isActive = true
        //line
        emailLine.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        emailLine.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        emailLine.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password text field
        passwordTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        passwordTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/2).isActive = true

        //login / registration button setup
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
