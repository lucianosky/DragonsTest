//
//  DragonTableViewCell.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import UIKit

class DragonTableViewCell: UITableViewCell {
    
    let dragonImageView = UIImageView.init(UIImage.init(named: "dragon")!)
    let dragonLabel = UILabel(.textFont, .black, "", .center)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#file) \(#function) not implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([dragonImageView, dragonLabel])
        contentView.backgroundColor = .white
        
        let viewsDict = [
            "dImg": dragonImageView,
            "dLbl": dragonLabel,
            ]
        
        contentView.activateConstraints("H:|[dImg]|", views: viewsDict)
        contentView.activateConstraints("H:|[dLbl]|", views: viewsDict)
        contentView.activateConstraints("V:|[dImg][dLbl(30)]|", views: viewsDict)
    }
    
    func configure(from dragon: Dragon) -> DragonTableViewCell {
        self.dragonLabel.text = dragon.title ?? "NO NAME"
        
        
        if let image = dragon.image {
            
            let dataService = DataService()
            dataService.request(image) { (result) in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async() {
                        self.dragonImageView.image = UIImage(data: data)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
        return self
    }
    
}
