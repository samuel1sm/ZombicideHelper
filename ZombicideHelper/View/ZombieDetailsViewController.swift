//
//  ZombieDetailsViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 27/11/21.
//

import UIKit

class ZombieDetailsViewController: UIViewController {
    var zombieInformation: ZombieInformations!
    let zombieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let zombieImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    let zombieStatusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .justified
        return label
    }()
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.textAlignment = .natural
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = zombieInformation.name

        guard let backgroundImage = UIImage(named: "backgroundImage") else {return}
        view.backgroundColor = UIColor(patternImage: backgroundImage)

        loadData()
        buildScreen()
    }

    func loadData() {

        zombieTitleLabel.text = zombieInformation.name
        zombieImage.image = UIImage(named: zombieInformation.zombieModelUrl)

        let status = zombieInformation.status
        zombieStatusLabel.text = """
                                Target Priority: \(status.targetPriority)
                                Actions: \(status.actions)
                                Life: \(status.minDamageDestroy)
                                Experience: \(status.experienceProvided)
                                Damage: \(status.damageInflicted)
                                Type: \(zombieInformation.zombieType)
                                Game: \(zombieInformation.game)
                                """

        textView.text =  zombieInformation.zombieText.replacingOccurrences(of: "||", with: "\n")

    }

    func buildScreen() {
        let screenStack = UIStackView()
        screenStack.translatesAutoresizingMaskIntoConstraints = false
        screenStack.axis = .horizontal
        screenStack.addArrangedSubview(zombieImage)
        screenStack.addArrangedSubview(zombieStatusLabel)
        screenStack.distribution = .fillEqually
        screenStack.setCustomSpacing(10, after: zombieImage)

        screenStack.spacing = 3
        view.addSubview(screenStack)
        view.addSubview(zombieTitleLabel)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            zombieTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            zombieTitleLabel.leadingAnchor
                .constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            zombieTitleLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            zombieTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zombieImage.heightAnchor.constraint(equalTo: zombieImage.widthAnchor)

        ])
        NSLayoutConstraint.activate([
            screenStack.topAnchor.constraint(equalTo: zombieTitleLabel.bottomAnchor, constant: 10),
            screenStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            screenStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            screenStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: screenStack.bottomAnchor, constant: 5),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])

    }

}
