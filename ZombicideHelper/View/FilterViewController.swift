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
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .gray

        view.addSubview(filterTitleLabel)
        view.addSubview(gameFilterView)
        view.addSubview(lineView)

        NSLayoutConstraint.activate([
            filterTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            filterTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterTitleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: filterTitleLabel.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        NSLayoutConstraint.activate([
            gameFilterView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            gameFilterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gameFilterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            gameFilterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameFilterView.heightAnchor.constraint(equalToConstant: 200)
        ])

    }

}

extension UIView {
    static func createHeaderView(text: String, fontSize: CGFloat = 18, labelHeight: CGFloat = 44,
                                 translatesAutoresizingMaskIntoConstraints: Bool = false) -> UIView {
        let resultView = UIView()
        resultView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .gray

        resultView.addSubview(label)
        resultView.addSubview(lineView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: resultView.topAnchor),
            label.leadingAnchor.constraint(equalTo: resultView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: resultView.trailingAnchor),
            label.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: resultView.centerYAnchor, constant: -1)
        ])

        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor),
            lineView.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        return resultView
    }
}

extension UIButton {
    static func createFilterButton(text: String) -> UIButton {
        var config = UIButton.Configuration.borderless()
        config.titlePadding = 20
        let view = UIButton(configuration: config, primaryAction: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor(named: Constants.invertedColor)?.cgColor
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 2
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        view.setTitle(text, for: .normal)
        return view
    }
}
