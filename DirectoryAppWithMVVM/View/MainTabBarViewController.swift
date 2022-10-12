//
//  MainTabBarViewController.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let peopleVM: PeopleViewModelType
    let roomVM: RoomsViewModelType
    init(pvm: PeopleViewModelType, rvm: RoomsViewModelType) {
        self.peopleVM = pvm
        self.roomVM = rvm
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        let vc1 = UINavigationController(rootViewController: PeopleViewController(vm: self.peopleVM))
        let vc2 = UINavigationController(rootViewController: RoomsViewController(vm: self.roomVM))
        vc1.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "Rooms", image: UIImage(systemName: "bed.double.fill"), tag: 1)
        setViewControllers([vc1, vc2], animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
