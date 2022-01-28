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
    let zombiesViewModel = ZombiesInformationViewModel()
    private var subscriptions = Set<AnyCancellable>()
    var filterSize: CGFloat = 0

    let filtersStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        filterView.viewModel = zombiesViewModel
        filterView.delegate = self
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

    }

    func buildScreen() {

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(filtersStack)
        scrollView.contentSize.height = 0
        scrollView.showsHorizontalScrollIndicator = false

        view.addSubview(searchBar)
        view.addSubview(myCollectionView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            scrollView.heightAnchor.constraint(lessThanOrEqualToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            filtersStack.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 1),
            filtersStack.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -1),
            filtersStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            filtersStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
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

extension ZombiesViewController: FilterStackDelegate {
    func updateFilter(create: Bool, buttonData: FilterButtonData) {
        let buttonText = "\(buttonData.type): \(buttonData.rule)"
        if create {
            let button = FilterButton()
            button.setTitle(buttonText, for: .normal)
            filtersStack.addArrangedSubview(button)
        } else {
            let button = filtersStack.arrangedSubviews.first { view in
                guard let button = view as? FilterButton else {return false}
                return button.titleLabel?.text == buttonText
            }

            if let button = button {
                filtersStack.removeArrangedSubview(button)
                button.removeFromSuperview()
            }
        }

        zombiesViewModel.loadFilters()
        myCollectionView.reloadData()

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
