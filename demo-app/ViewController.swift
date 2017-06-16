//
//  ViewController.swift
//  demo-app
//
//  Created by Josh Payne on 6/14/17.
//  Copyright © 2017 R|TRIBE. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }

    func logout() {
        present(LoginViewController, animated: true, completion: nil)
    }
    
}

