//
//  ZombieDetailsViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 27/11/21.
//

import UIKit

class ZombieDetailsViewController: UIViewController {
    var zombieInformation: ZombieInformations!
    let scrollView: UIScrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = zombieInformation.name

        buildScreen()
    }

    func buildScreen() {
        guard let backgroundImage = UIImage(named: "backgroundImage") else {return}
        view.backgroundColor = UIColor(patternImage: backgroundImage)

        let zombieTitle = UILabel()
        zombieTitle.font = UIFont.boldSystemFont(ofSize: 30)
        zombieTitle.translatesAutoresizingMaskIntoConstraints = false
        zombieTitle.text = zombieInformation.name

        let zombieImage = UIImageView()
        zombieImage.image = UIImage(named: zombieInformation.zombieModelUrl)
        zombieImage.layer.cornerRadius = 10
        zombieImage.translatesAutoresizingMaskIntoConstraints = false
        zombieImage.contentMode = .scaleAspectFill
        zombieImage.clipsToBounds = true

        let status = zombieInformation.status
        let zombieStatus = UILabel()
        zombieStatus.numberOfLines = 0
        zombieStatus.text = """
                                Target Priority: \(status.targetPriority)
                                Actions: \(status.actions)
                                Damage to Destroy: \(status.minDamageDestroy)
                                Experience Provided: \(status.experienceProvided)
                                Damage Inflicted: \(status.damageInflicted)
                                Type: \(zombieInformation.zombieType)
                                Game: \(zombieInformation.game)
                            """

        let firstStack = UIStackView()
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.axis = .horizontal
        firstStack.addArrangedSubview(zombieImage)
        firstStack.addArrangedSubview(zombieStatus)
        firstStack.distribution = .fillEqually
        firstStack.setCustomSpacing(10, after: zombieImage)

//        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemGreen
        scrollView.isUserInteractionEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .automatic

        let zombieText = UILabel()
        zombieText.text =  zombieInformation.zombieText.replacingOccurrences(of: "||", with: "\n")
        zombieText.translatesAutoresizingMaskIntoConstraints = false
        zombieText.numberOfLines = 0
        zombieText.backgroundColor = .black

        scrollView.addSubview(zombieText)

        firstStack.spacing = 3
        view.addSubview(firstStack)
        view.addSubview(zombieTitle)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            zombieTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            zombieTitle.leadingAnchor
                .constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            zombieTitle.trailingAnchor
                .constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            zombieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zombieImage.heightAnchor.constraint(equalTo: zombieImage.widthAnchor)

        ])
        NSLayoutConstraint.activate([
            firstStack.topAnchor.constraint(equalTo: zombieTitle.bottomAnchor, constant: 10),
            firstStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            firstStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            firstStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            zombieText.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 10),
            zombieText.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            zombieText.leadingAnchor
                .constraint(greaterThanOrEqualTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            zombieText.trailingAnchor
                .constraint(lessThanOrEqualTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            zombieText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("dasdasdasd")
    }

}