//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ZombiesViewController: UIViewController {

    var myCollectionView: UICollectionView?
    let cellPerRoll: CGFloat = 2
    let zombiesBrain = ZombiesInformationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zombies"
        navigationController?.navigationBar.prefersLargeTitles = true

        buildScreen()

    }

    func buildScreen() {
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

extension ZombiesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zombiesBrain.zombiesList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZombieCollectionViewCell.indentifier,
                                                            for: indexPath) as? ZombieCollectionViewCell
                                                            else { fatalError("Cell doenst exists") }

        let information = zombiesBrain.getZombieInformation(zombie: indexPath.row)
        cell.configure(zombieInformation: information)
        return cell
    }
}

extension ZombiesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = ZombieDetailsViewController()
//        detailView.modalPresentationStyle = .fullScreen
        detailView.zombieInformation = zombiesBrain.getZombieInformation(zombie: indexPath.row)
//        navigationController?.pushViewController(detailView, animated: true)
        present(detailView, animated: true, completion: nil)
    }
}
