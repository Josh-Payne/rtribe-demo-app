//
//  ProductsViewController.swift
//  demo-app
//
//  Created by Josh Payne on 7/1/17.
//  Copyright © 2017 R|TRIBE. All rights reserved.
//

import UIKit

class ProductsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products"
        collectionView?.backgroundColor = UIColor.gray
    }
    
}
