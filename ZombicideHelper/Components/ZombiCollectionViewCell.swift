//
//  ZombiCellCollectionViewCell.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ZombiCollectionViewCell: UICollectionViewCell {
    var zombiImage : UIImage?
    var zombiName : String?
    static let indentifier = "ZombiCell"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let nameLabel = UILabel()
        nameLabel.text = zombiName
        nameLabel.textColor = .green
        self.backgroundColor = .blue
        self.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        nameLabel.leftAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
