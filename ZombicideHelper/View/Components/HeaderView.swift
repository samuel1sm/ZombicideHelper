//
//  HeaderView.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 31/01/22.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func onHeaderButtonClicked()
}

class HeaderView: UIView {
    var button: UIButton = {
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10
        config.titleAlignment = .center
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        let button = UIButton(configuration: config, primaryAction: nil)

        button.titleLabel?.textColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 4

        return button
    }()

    weak var delegate: HeaderViewDelegate?

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        button.addTarget(self, action: #selector(headerButtonClicked(sender: )), for: .touchUpInside)
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .gray

        self.addSubview(button)
        self.addSubview(titleLabel)
        self.addSubview(lineView)
        button.isHidden = true

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -1)
        ])

        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func setTitle(title: String, fontSize: CGFloat = 18) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }

    func setButton(buttonText: String) {
        button.isHidden = false
        button.setTitle(buttonText, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func headerButtonClicked(sender: UIButton) {
        delegate?.onHeaderButtonClicked()
    }
}
