//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ViewController: UIViewController  {
    
    var myCollectionView: UICollectionView?
    let cellPerRoll : CGFloat = 2
    let zombiesBrain = ZombiesBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zombies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionViewUI()
    }
  
    

}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zombiesBrain.zombiesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZombieCollectionViewCell.indentifier, for: indexPath) as? ZombieCollectionViewCell else { fatalError("Cell doenst exists") }
        
        let information = zombiesBrain.getZombieInformation(zombie: indexPath.row)
        cell.configure(zombieInformation: information)
        return cell
    }
}

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = ZombieDetailsViewController()
        detailView.zombieInformation = zombiesBrain.getZombieInformation(zombie: indexPath.row)
        present(detailView, animated: true, completion: nil)
    }
}
