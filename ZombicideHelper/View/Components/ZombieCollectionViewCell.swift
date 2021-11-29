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
        zombieUIImage.layer.cornerRadius = 10
        return zombieUIImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.systemGray.withAlphaComponent(0.9)
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 5
        return nameLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundView = zombieImageView
        contentView.addSubview(nameLabel)
        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:5),
            nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo:self.centerXAnchor , constant: 0)
        ])
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
