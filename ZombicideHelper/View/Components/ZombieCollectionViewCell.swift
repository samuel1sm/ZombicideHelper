//
//  ZombiCellCollectionViewCell.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ZombieCollectionViewCell: UICollectionViewCell {
    static let indentifier = "ZombieCell"
    
    private let zombieImageView : UIImageView = {
        let zombieUIImage = UIImageView()
        zombieUIImage.contentMode = .scaleToFill
        zombieUIImage.clipsToBounds = true
        zombieUIImage.layer.cornerRadius = 5
        return zombieUIImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .green
        nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        nameLabel.adjustsFontSizeToFitWidth = true
            
        return nameLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.layer.cornerRadius = 10
//        contentView.backgroundColor = .systemRed
        self.backgroundView = zombieImageView
//        contentView.addSubview(zombieImageView)
        contentView.addSubview(nameLabel)
        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
//        zombieImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
        
//        zombieImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
    }
    public func configure(zombieInformation: ZombieInformations) {
        nameLabel.text = zombieInformation.name
        zombieImageView.image = UIImage(named: zombieInformation.zombieArtUrl)!
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        zombieImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
