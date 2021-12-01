//
//  ZombieDetailsViewController.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 27/11/21.
//

import UIKit

class ZombieDetailsViewController: UIViewController {
    var zombieInformation: ZombieInformations!
    let scrollView: UIScrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildScreen()
    }

}
