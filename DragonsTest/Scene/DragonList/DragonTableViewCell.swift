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
    let hearButton = ClosureButton(.textFont, .blue, "hear")
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#file) \(#function) not implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([dragonImageView, dragonLabel, hearButton])
        contentView.backgroundColor = .white
        
        let viewsDict = [
            "dImg": dragonImageView,
            "dLbl": dragonLabel,
            "btn": hearButton,
            ]
        
        contentView.activateConstraints("H:|[dImg]|", views: viewsDict)
        contentView.activateConstraints("H:|[dLbl][btn(50)]|", views: viewsDict)
        contentView.activateConstraints("V:|[dLbl(50)][dImg]|", views: viewsDict)
        dragonLabel.equalConstraints([.centerY], to: hearButton)
    }
    
}
