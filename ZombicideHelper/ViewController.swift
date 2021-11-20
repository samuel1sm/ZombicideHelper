//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ViewController: UIViewController  {
    
    private var myCollectionView: UICollectionView?
    private let cellPerRoll : CGFloat = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zombies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        print(view.frame.size.width/cellPerRoll)
        layout.itemSize = CGSize(width: (view.frame.size.width/cellPerRoll) - 4, height: (view.frame.size.width/cellPerRoll)-4)
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let myCollectionView = myCollectionView else {return}
        myCollectionView.register(ZombieCollectionViewCell.self, forCellWithReuseIdentifier: ZombieCollectionViewCell.indentifier)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        view.addSubview(myCollectionView)
        myCollectionView.frame = view.bounds
    }
    

}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZombieCollectionViewCell.indentifier, for: indexPath) as? ZombieCollectionViewCell else { fatalError("Cell doenst exists") }

        cell.configure(label: "teste", image: UIImage(systemName: "house")!)
        return cell
    }
}

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped \(indexPath.row)")
    }
}
