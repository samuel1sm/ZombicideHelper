//
//  FilterViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 12/01/22.
//

import UIKit

class FilterViewController: UIViewController {
    let filterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Filter"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let gameFilterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        title = "Filter"
        buildScreen()

    }

    func buildScreen() {

        view.addSubview(filterTitleLabel)
        view.addSubview(gameFilterView)

        NSLayoutConstraint.activate([
            filterTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            filterTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterTitleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            gameFilterView.topAnchor.constraint(equalTo: filterTitleLabel.bottomAnchor, constant: 20),
            gameFilterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gameFilterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            gameFilterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameFilterView.heightAnchor.constraint(equalToConstant: 200)
        ])

    }

}
