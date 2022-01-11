//
//  ZombieCollectionViewUI.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 27/11/21.
//

import UIKit

extension ZombiesViewController {
    func configureCollectionViewUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/cellPerRoll) - 4,
                                 height: (view.frame.size.width/cellPerRoll)-4)

        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        guard let myCollectionView = myCollectionView else {return}
        myCollectionView.register(ZombieCollectionViewCell.self,
                                  forCellWithReuseIdentifier: ZombieCollectionViewCell.indentifier)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        view.addSubview(myCollectionView)

        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            myCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
