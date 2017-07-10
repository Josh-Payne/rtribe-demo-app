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
    
    var userToken = String()
    let baseURL = "https://ios-starter-backend.herokuapp.com"
    let imageURL = "/api/v1/products"
    var pageNumber = String()
    
    var collectionView: UICollectionView!
    
    var json: JSON!
    let cellIdentifier = "CollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products"
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.0 - 16, height: UIScreen.main.bounds.width / 2.0 - 16)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        let header: HTTPHeaders = [
        "key":userToken
        ]
        let params = ["page":pageNumber,
                      "per_page":"6",
                          ]
        Alamofire.request(self.baseURL + self.imageURL, parameters: params, headers: header).responseJSON { (response) in
            guard let object = response.result.value else {
                return
            }
            self.json = JSON(object)
            self.collectionView.backgroundColor = UIColor.white
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.view.addSubview(self.collectionView)
        }
    }
}

extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = UIScreen.main.bounds.width / 2.0
//        let height: CGFloat = width
//        return CGSize(width: width, height: height)
//    }
//    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 32
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, refe indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2.0
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension ProductsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let _ = self.json {
            return 2 //self.json["result"]["photos"].count
        }else{
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        
//        let params = ["maxwidth":"800",
//                          "photoreference":self.json["result"]["photos"][indexPath.row]["photo_reference"].stringValue,
//                          "key":userToken]
//        
//        Alamofire.request(self.baseURL + self.imageURL, method: .get, parameters: params).responseImage(completionHandler: { (response) in
//            
//            guard let image = response.result.value else {
//                return
//            }
//            
            //cell.image = #imageLiteral(resourceName: "sus")
        //            cell.label.text = "Item "// + String(indexPath.row + 1)
//
//        })
        cell.backgroundColor = UIColor.orange
        
        return cell
        
    }
    
    
    
}



class CollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var label: UILabel!
}
