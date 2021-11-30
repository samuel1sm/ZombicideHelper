//
//  ZombieDetailsUI.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 27/11/21.
//

import Foundation
import UIKit

extension ZombieDetailsViewController {
    func buildScreen(){
        guard let backgroundImage = UIImage(named: "backgroundImage") else {return}
        view.backgroundColor = UIColor(patternImage: backgroundImage)
        
        let zombieImage = UIImageView()
        zombieImage.image = UIImage(named: zombieInformation.zombieModelUrl)
        zombieImage.layer.cornerRadius = 10
        zombieImage.translatesAutoresizingMaskIntoConstraints = false
        zombieImage.contentMode = .scaleAspectFill
        zombieImage.clipsToBounds = true
        
        title = zombieInformation.name

        let status = zombieInformation.status
        let zombieStatus = UILabel()
        zombieStatus.numberOfLines = 0
        zombieStatus.text = "Target Priority: \(status.targetPriority)\nActions: \(status.actions)\nDamage to Destroy: \(status.minDamageDestroy)\nExperience Provided: \(status.experienceProvided)\nDamage Inflicted: \(status.damageInflicted)\nType: \(zombieInformation.zombieType)\nGame: \(zombieInformation.game)"

        let firstStack = UIStackView()
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.axis = .horizontal
        firstStack.addArrangedSubview(zombieImage)
        firstStack.addArrangedSubview(zombieStatus)
        firstStack.distribution = .fillEqually
        
        let zombieText = UILabel()
        zombieText.text =  zombieInformation.zombieText.replacingOccurrences(of: "||", with: "\n")
        zombieText.translatesAutoresizingMaskIntoConstraints = false
        zombieText.numberOfLines = 0
        
        firstStack.spacing = 3
        view.addSubview(firstStack)
        view.addSubview(zombieText)
        
        
        NSLayoutConstraint.activate([
            zombieImage.heightAnchor.constraint(equalTo: zombieImage.widthAnchor),
            firstStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            firstStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            firstStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            firstStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zombieText.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 5),
            zombieText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            zombieText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            zombieText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zombieText.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
    }
}
