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

    var inputContainerHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainer()
        
    }
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 90/255, green: 100/255, blue: 200/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let nameTF: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let nameLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        loginRegisterButton.setTitle(title, for: .normal)
        var selected : CGFloat;
        selected = loginRegisterToggle.selectedSegmentIndex == 0 ? 100 : 150
        inputContainerHeightConstraint?.constant = selected
        
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
        inputContainerHeightConstraint = inputContainer.heightAnchor.constraint(equalToConstant: 150)
        inputContainerHeightConstraint?.isActive = true
        
        //views setup
        inputContainer.addSubview(nameTF)
        inputContainer.addSubview(nameLine)
        inputContainer.addSubview(emailTF)
        inputContainer.addSubview(emailLine)
        inputContainer.addSubview(passwordTF)
        
        //toggle constraints
        loginRegisterToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterToggle.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -12).isActive = true
        loginRegisterToggle.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        loginRegisterToggle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //name text field constraints
        nameTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        nameTF.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        nameTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        nameTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true
        //name line constraints
        nameLine.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        nameLine.topAnchor.constraint(equalTo: nameTF.bottomAnchor).isActive = true
        nameLine.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        nameLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //email text field constraints
        emailTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true
        //email line constraints
        emailLine.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        emailLine.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        emailLine.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        emailLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password text field constraints
        passwordTF.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 12).isActive = true
        passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        passwordTF.heightAnchor.constraint(equalTo: inputContainer.heightAnchor, multiplier: 1/3).isActive = true

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
