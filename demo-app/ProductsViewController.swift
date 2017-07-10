//
//  ProductsViewController.swift
//  demo-app
//
//  Created by Josh Payne on 7/1/17.
//  Copyright © 2017 R|TRIBE. All rights reserved.
//
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ProductsViewController: UIViewController {
    
    struct Products {
        let id: Int
        let name: String
        let overview: String
        let price: String
        let image_url: String
        let created_at: Int64
        let updated_at: Int64
    }
    
    var productList = Array<Products>()
    var userToken = String()
    let baseURL = "https://ios-starter-backend.herokuapp.com"
    let imageURL = "/api/v1/products"
    var pageNumber = String()
    var productResponse = ProductsViewController.Products.init(id: 0, name: "", overview: "", price: "", image_url: "", created_at: 0, updated_at: 0);
    var collectionView: UICollectionView!
    var items = Int()
    var json: JSON!
    let cellIdentifier = "CollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //These don't show
        navigationItem.title = "Products"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func logout() {
        let newController = LoginViewController()
        self.present(newController, animated: true, completion: nil)
    }
    
    func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 16, height: UIScreen.main.bounds.width - 16)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 60), collectionViewLayout: layout)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        let header: HTTPHeaders = [
        "token":userToken
        ]
        let params = ["page":pageNumber,
                      "per_page":"6",
                          ]
        Alamofire.request(self.baseURL + self.imageURL, parameters: params, headers: header).responseJSON { (response) in
            guard let object = response.result.value else {
                return
            }
            self.json = JSON(object)
            print(self.json)
            self.items = self.json.count-1
            let arrayID = self.json.arrayValue.map({$0["id"].intValue})
            let arrayName = self.json.arrayValue.map({$0["name"].stringValue})
            let arrayOverview = self.json.arrayValue.map({$0["overview"].stringValue})
            let arrayPrice = self.json.arrayValue.map({$0["price"].stringValue})
            let arrayImageURL = self.json.arrayValue.map({$0["image_url"].stringValue})
            let arrayCreatedAt = self.json.arrayValue.map({$0["created_at"].int64Value})
            let arrayUpdatedAt = self.json.arrayValue.map({$0["updated_at"].int64Value})
            for item in 0...(self.items) {
                self.productResponse = Products(id: arrayID[item], name: arrayName[item], overview: arrayOverview[item], price: arrayPrice[item], image_url: arrayImageURL[item], created_at: arrayCreatedAt[item], updated_at: arrayUpdatedAt[item])
                self.productList.append(self.productResponse)
            }
            self.collectionView.backgroundColor = UIColor.white
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.view.addSubview(self.collectionView)
        }
    }
}

extension ProductsViewController: UICollectionViewDelegate {
    //Didn't have time
}

extension ProductsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let _ = self.json {
            print(self.items)
            return self.items + 1
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        let imageString = productList[indexPath[0]].image_url
        let nameString = productList[indexPath[0]].name
        let priceString = productList[indexPath[0]].price
        let nameLabel = UILabel()
        nameLabel.text = nameString
        nameLabel.adjustsFontSizeToFitWidth = true
        let priceLabel = UILabel()
        priceLabel.text = priceString
        DispatchQueue.main.async(execute: {
            Alamofire.request(imageString, method: .get).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else {
                    return
                }
                let imageview: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                imageview.image = image
                cell.contentView.addSubview(imageview)
            })
        })
        cell.contentView.addSubview(nameLabel)
        cell.contentView.addSubview(priceLabel)
        return cell
    }
}
