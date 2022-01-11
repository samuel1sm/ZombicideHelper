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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    let zombieStatusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let zombieTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .black
        return label
    }()
    let scrollView: UIScrollView =  {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
        view.isUserInteractionEnabled = true
        view.contentInsetAdjustmentBehavior = .automatic
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
                                Damage to Destroy: \(status.minDamageDestroy)
                                Experience Provided: \(status.experienceProvided)
                                Damage Inflicted: \(status.damageInflicted)
                                Type: \(zombieInformation.zombieType)
                                Game: \(zombieInformation.game)
                            """

        zombieTextLabel.text =  zombieInformation.zombieText.replacingOccurrences(of: "||", with: "\n")

    }

    func buildScreen() {
        let screenStack = UIStackView()
        screenStack.translatesAutoresizingMaskIntoConstraints = false
        screenStack.axis = .horizontal
        screenStack.addArrangedSubview(zombieImage)
        screenStack.addArrangedSubview(zombieStatusLabel)
        screenStack.distribution = .fillEqually
        screenStack.setCustomSpacing(10, after: zombieImage)

        let testImage = UIImageView(image: UIImage(named: zombieInformation.zombieModelUrl))

        let screenSize: CGRect = UIScreen.main.bounds
        testImage.frame = CGRect(x: 0, y: 0, width: 50, height: screenSize.height)

        scrollView.addSubview(testImage)

        screenStack.spacing = 3
        view.addSubview(screenStack)
        view.addSubview(zombieTitleLabel)
        view.addSubview(scrollView)

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
            scrollView.topAnchor.constraint(equalTo: screenStack.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])

//        NSLayoutConstraint.activate([
//            zombieTextLabel.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 10),
//            zombieTextLabel.bottomAnchor
//                .constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            zombieTextLabel.leadingAnchor
//                .constraint(greaterThanOrEqualTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            zombieTextLabel.trailingAnchor
//                .constraint(lessThanOrEqualTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
////            zombieTextLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
//        ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("dasdasdasd")
    }

}
