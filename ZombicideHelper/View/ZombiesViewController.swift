//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit
import Combine
class ZombiesViewController: UIViewController {

    let cellPerRoll: CGFloat = 2
    var zombiesViewModel = ZombiesInformationViewModel()
    private var subscriptions = Set<AnyCancellable>()

    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = " Search..."
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var myCollectionView: UICollectionView!
    var tapGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zombies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.filterIcon),
                                                            style: .done, target: self, action: #selector(openFilters))

        view.backgroundColor = .systemBackground

        self.zombiesViewModel.$filterOptions.sink { filter in
            print(filter?.zombieTypeInfos)
        }.store(in: &subscriptions)

        tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))

        configureCollectionView()

        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        searchBar.delegate = self

        buildScreen()

    }

    @objc func openFilters() {
        let filterView = FilterViewController()
        filterView.filterOptins = zombiesViewModel.filterOptions
//        filterView.modalPresentationStyle = .fullScreen
        present(filterView, animated: true, completion: nil)
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
        myCollectionView.backgroundColor = .clear
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

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}

extension ZombiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        zombiesViewModel.filterList(filter: searchText)
        myCollectionView.reloadData()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        view.addGestureRecognizer(tapGesture)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        view.removeGestureRecognizer(tapGesture)
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
        detailView.zombieInformation = zombiesViewModel.getZombieInformation(zombie: indexPath.row)
        present(detailView, animated: true, completion: nil)
    }
}
