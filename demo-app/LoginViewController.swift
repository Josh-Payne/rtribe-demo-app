//
//  LoginViewController.swift
//  demo-app
//
//  Created by Josh Payne on 6/14/17.
//  Copyright © 2017 R|TRIBE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainer()
        
    }
    
    func setupContainer() {
        view.backgroundColor = UIColor(red: 50/255, green: 70/255, blue: 150/255, alpha: 1)
        let inputContainer = UIView()
        inputContainer.backgroundColor = UIColor.white
        view.addSubview(inputContainer)
        inputContainer.translatesAutoresizingMaskIntoConstraints =  false
        inputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        inputContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        inputContainer.layer.cornerRadius = 5
        inputContainer.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
