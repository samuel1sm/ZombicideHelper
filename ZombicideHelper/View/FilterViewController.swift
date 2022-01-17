//
//  FilterViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 12/01/22.
//

import UIKit

class FilterViewController: UIViewController {
    var filterOptins: FilterOptions!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        title = "Filter"
        buildScreen()
    }

    func buildScreen() {
        let filterTitleLabel = UIView.createHeaderView(text: "Filters")
        let actionsFilterArea = buildSimpleFiltersArea(title: "Actions",
                                                       buttonTexts: sortKeys(filterOptins.actionsInfos))
        let lifeFilterArea = buildSimpleFiltersArea(title: "Life",
                                                    buttonTexts: sortKeys(filterOptins.minDamageDestroyInfos))
        let damageFilterArea = buildSimpleFiltersArea(title: "Damage",
                                                      buttonTexts: sortKeys(filterOptins.damageInflictedInfos))

        view.addSubview(filterTitleLabel)
        view.addSubview(actionsFilterArea)
        view.addSubview(lifeFilterArea)
        view.addSubview(damageFilterArea)

        NSLayoutConstraint.activate([
            filterTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            filterTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterTitleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            lifeFilterArea.topAnchor.constraint(equalTo: filterTitleLabel.bottomAnchor, constant: 20),
            lifeFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lifeFilterArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            lifeFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lifeFilterArea.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            actionsFilterArea.topAnchor.constraint(equalTo: lifeFilterArea.bottomAnchor, constant: 20),
            actionsFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            actionsFilterArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -20),
            actionsFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionsFilterArea.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            damageFilterArea.topAnchor.constraint(equalTo: actionsFilterArea.bottomAnchor, constant: 20),
            damageFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            damageFilterArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            damageFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            damageFilterArea.heightAnchor.constraint(equalToConstant: 80)
        ])

    }

    func buildSimpleFiltersArea(title: String, buttonTexts: [String]) -> UIView {
        let view = buildFilterView()

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 6

        buttonTexts.forEach {stack.addArrangedSubview(UIButton.createFilterButton(text: $0))}

        let header = UIView.createHeaderView(text: title, fontSize: 16)
        view.addSubview(header)
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 26)
        ])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        return view
    }

    private func buildFilterView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }

    private func sortKeys(_ buttonTexts: [String: Bool]) -> [String] {
        return Array(buttonTexts.keys).sorted(by: <)
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
