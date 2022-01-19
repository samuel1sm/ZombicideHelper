//
//  FilterButton.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 19/01/22.
//

import UIKit

class FilterButton: UIButton {
    var filterType: String = ""

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

}

extension FilterButton {
    static func standartConfig(title: String, filterType: String) -> FilterButton {
        var config = UIButton.Configuration.borderless()
        config.titlePadding = 20

        let button = FilterButton(configuration: config, primaryAction: nil)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.filterType = filterType
        return button
    }
}
