//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ZombiesViewController: UIViewController {

    let cellPerRoll: CGFloat = 2
    var zombiesViewModel = ZombiesInformationViewModel()
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = " Search..."
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zombies"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureCollectionView()

        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        searchBar.delegate = self

        buildScreen()

    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/cellPerRoll) - 4,
                                 height: (view.frame.size.width/cellPerRoll)-4)

        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.register(ZombieCollectionViewCell.self,
                                  forCellWithReuseIdentifier: ZombieCollectionViewCell.indentifier)

        view.addSubview(searchBar)
        view.addSubview(myCollectionView)
    }

    func buildScreen() {

        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            searchBar.heightAnchor.constraint(lessThanOrEqualToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            myCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            myCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            myCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension ZombiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        zombiesViewModel.filterList(filter: searchText)
        myCollectionView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("saiu")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("fasfas")
        view.endEditing(true)
    }
}

extension ZombiesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zombiesViewModel.filteredList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ZombieCollectionViewCell.indentifier, for: indexPath)
                as? ZombieCollectionViewCell
        else { fatalError("Cell doenst exists") }

        let information = zombiesViewModel.getZombieInformation(zombie: indexPath.row)
        cell.configure(zombieInformation: information)
        return cell
    }
}

extension ZombiesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = ZombieDetailsViewController()
        //        detailView.modalPresentationStyle = .fullScreen
        detailView.zombieInformation = zombiesViewModel.getZombieInformation(zombie: indexPath.row)
        //        navigationController?.pushViewController(detailView, animated: true)
        present(detailView, animated: true, completion: nil)
    }
}
