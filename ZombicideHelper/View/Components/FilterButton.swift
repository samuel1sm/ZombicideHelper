//
//  FilterButton.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 19/01/22.
//

import UIKit

struct FilterButtonData {
    let type: String
    let rule: String
}

class FilterButton: UIButton {
    var filterType: FilterButtonData?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.borderColor = UIColor(named: Constants.invertedColor)?.cgColor
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateButtonState(isActive: Bool) {
        if isActive {
            self.setTitleColor(UIColor.black, for: .normal)
            self.backgroundColor = UIColor.white
        } else {
            self.setTitleColor(UIColor.white, for: .normal)
            self.backgroundColor = UIColor.clear
        }
    }

}

extension FilterButton {
    static func standartConfig(title: String, filterType: String, isActive: Bool) -> FilterButton {
        var config = UIButton.Configuration.borderless()
        config.titlePadding = 20

        let button = FilterButton(configuration: config, primaryAction: nil)
        button.setTitle(title, for: .normal)
        button.updateButtonState(isActive: isActive)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.filterType = FilterButtonData(type: filterType, rule: title)
        return button
    }
}
