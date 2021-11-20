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
        zombieUIImage.image = UIImage(systemName: "house")
        zombieUIImage.contentMode = .scaleAspectFit
        zombieUIImage.clipsToBounds = true
//        zombieUIImage.backgroundColor = .yellow
        return zombieUIImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
//        nameLabel.backgroundColor = .green
        return nameLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(zombieImageView)
        contentView.addSubview(nameLabel)
        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
        zombieImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
        
    }
    public func configure(label: String, image : UIImage) {
        nameLabel.text = label
        zombieImageView.image = image
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
