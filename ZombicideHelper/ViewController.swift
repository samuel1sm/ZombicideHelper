//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 16/11/21.
//

import UIKit

class ViewController: UIViewController  {
    
    private var myCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 100)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        myCollectionView?.register(ZombiCollectionViewCell.self, forCellWithReuseIdentifier: ZombiCollectionViewCell.indentifier)
        myCollectionView?.backgroundColor = UIColor.white
       
        
        view.addSubview(myCollectionView ?? UICollectionView())
        self.view = view
    }

}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZombiCollectionViewCell.indentifier, for: indexPath) as? ZombiCollectionViewCell else { fatalError("Cell doenst exists") }
        
        cell.zombiName = "teste"
        return cell
    }
}

extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped \(indexPath.row)")
    }
}
