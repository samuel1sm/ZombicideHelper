//
//  FilterViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 12/01/22.
//

import UIKit

protocol FilterStackDelegate: AnyObject {
    func updateFilter(create: Bool, buttonData: FilterButtonData)
}

class FilterViewController: UIViewController {
    var viewModel: ZombiesInformationViewModel!
    weak var delegate: FilterStackDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        buildScreen()
    }

    func buildScreen() {
        let filterTitleLabel = UIView.createHeaderView(text: "Filters")
        let actionsFilterArea = buildSimpleFiltersArea(title: Constants.Filters.actions,
                                                       buttonTexts:
                                                        sortKeys(viewModel.filterOptions.actions))

        let lifeFilterArea = buildSimpleFiltersArea(title: Constants.Filters.life,
                                                    buttonTexts:
                                                        sortKeys(viewModel.filterOptions.life))

        let damageFilterArea = buildSimpleFiltersArea(title: Constants.Filters.damage,
                                                      buttonTexts:
                                                        sortKeys(viewModel.filterOptions.damage))

        let zombieFilterArea = buildSimpleFiltersArea(title: Constants.Filters.type,
                                                      buttonTexts: sortKeys(viewModel.filterOptions.zombieType),
                                                      distribution: .fillProportionally)

        let expationFilterArea = buildLargerFiltersArea(title: Constants.Filters.expantions,
                                                        buttonTexts: sortKeys(viewModel.filterOptions.gamesInfos))

        view.addSubview(filterTitleLabel)
        view.addSubview(actionsFilterArea)
        view.addSubview(lifeFilterArea)
        view.addSubview(damageFilterArea)
        view.addSubview(zombieFilterArea)
        view.addSubview(expationFilterArea)

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
            lifeFilterArea.heightAnchor.constraint(equalToConstant: 72)
        ])

        NSLayoutConstraint.activate([
            actionsFilterArea.topAnchor.constraint(equalTo: lifeFilterArea.bottomAnchor, constant: 10),
            actionsFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            actionsFilterArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -20),
            actionsFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionsFilterArea.heightAnchor.constraint(equalToConstant: 72)
        ])

        NSLayoutConstraint.activate([
            damageFilterArea.topAnchor.constraint(equalTo: actionsFilterArea.bottomAnchor, constant: 10),
            damageFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            damageFilterArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            damageFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            damageFilterArea.heightAnchor.constraint(equalToConstant: 72)
        ])

        NSLayoutConstraint.activate([
            zombieFilterArea.topAnchor.constraint(equalTo: damageFilterArea.bottomAnchor, constant: 10),
            zombieFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            zombieFilterArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            zombieFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zombieFilterArea.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate([
            expationFilterArea.topAnchor.constraint(equalTo: zombieFilterArea.bottomAnchor, constant: 10),
            expationFilterArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            expationFilterArea.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            expationFilterArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            expationFilterArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

    }

    func buildSimpleFiltersArea(title: String, buttonTexts: [String],
                                distribution: UIStackView.Distribution = .fillEqually) -> UIView {
        let view = buildFilterView()
        let stack = UIStackView.filterStack(distribution: distribution)

        buttonTexts.forEach {
            let button = FilterButton.standartConfig(title: $0, filterType: title,
                                                     isActive: viewModel.getButtonState(filter: title, rule: $0))
            button.addTarget(self, action: #selector(onFilterPressed), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }

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

    func buildLargerFiltersArea(title: String, buttonTexts: [String]) -> UIView {
        let view = buildFilterView()
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.distribution = .fillProportionally
        mainStack.spacing = 3

        let stacks = Array(0..<6).map { _ -> UIStackView in
            let stack = UIStackView.filterStack()
            mainStack.addArrangedSubview(stack)
            return stack
        }

        for (index, name) in buttonTexts.enumerated() {
            let module = index % stacks.count
            let button = FilterButton.standartConfig(title: name, filterType: title,
                                                     isActive: viewModel.getButtonState(filter: title, rule: name))
            button.addTarget(self, action: #selector(onFilterPressed), for: .touchUpInside)
            stacks[module].addArrangedSubview(button)
        }

        let header = UIView.createHeaderView(text: title, fontSize: 16)
        view.addSubview(header)
        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 26)
        ])

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        return view
    }

    private func buildFilterView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.filterBackground)
        view.layer.cornerRadius = 10
        return view
    }

    private func sortKeys(_ buttonTexts: [String: Bool]) -> [String] {
        return Array(buttonTexts.keys).sorted(by: <)
    }

    @objc func onFilterPressed(_ sender: FilterButton!) {
        guard let filterType = sender.filterType else {return}

        let result = viewModel.updateFilter(filter: filterType.type, rule: filterType.rule )
        sender.updateButtonState(isActive: result)
        delegate.updateFilter(create: result, buttonData: filterType )
    }

}

extension UIStackView {
    static func filterStack(spacing: CGFloat = 6, distribution: UIStackView.Distribution = .fillEqually,
                            maskIntoConstraints: Bool = false) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = maskIntoConstraints
        stack.axis = .horizontal
        stack.distribution = distribution
        stack.spacing = spacing
        return stack
    }
}

extension UIView {
    static func createHeaderView(text: String, fontSize: CGFloat = 18, labelHeight: CGFloat = 44,
                                 maskIntoConstraints: Bool = false) -> UIView {

        let resultView = UIView()
        resultView.translatesAutoresizingMaskIntoConstraints = maskIntoConstraints

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
