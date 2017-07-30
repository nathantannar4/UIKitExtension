//
//  ViewController.swift
//  UIKitExtensionDemo
//
//  Created by Nathan Tannar on 7/13/17.
//  Copyright © 2017 Nathan Tannar. All rights reserved.
//

import UIKit
import UIKitExtension

class ViewController: UIDatasourceController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coffee"
        datasource = MenuDatasource()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 2, height: view.bounds.width / 2)
    }
}

class MenuDatasource: Datasource {
    
    override init() {
        super.init()
        self.objects = [#imageLiteral(resourceName: "Coffee"), #imageLiteral(resourceName: "CafeAmericano"), #imageLiteral(resourceName: "CafeLatte"), #imageLiteral(resourceName: "Cappuccino"), #imageLiteral(resourceName: "Espresso")]
    }
    
    override func cellClasses() -> [UIDatasourceViewCell.Type] {
        return [ItemViewCell.self]
    }
}

class ItemViewCell: UIDatasourceViewCell {
    
    override var datasourceItem: Any? {
        didSet {
            if let image = datasourceItem as? UIImage {
                imageView.image = image
            }
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
}


