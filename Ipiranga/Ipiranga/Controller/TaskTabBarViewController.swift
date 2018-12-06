	//
//  BpmTabBarViewController.swift
//  BPMAprovacao
//
//  Created by Maurício Mazzocco on 23/10/17.
//  Copyright © 2017 Totvs. All rights reserved.
//

import UIKit


class TaskTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.items?[0].title =  NSLocalizedString("notifications", comment: "")
        self.tabBar.items?[1].title =  NSLocalizedString("tasks", comment: "")
        self.tabBar.items?[2].title =  NSLocalizedString("profile", comment: "")
        tabBar.barTintColor = .tabBarBPM
        tabBar.tintColor = .greenTabBar
        tabBar.unselectedItemTintColor = .unselectTabBarBPM
        tabBar.layer.borderWidth = 0.50
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage =  UIImage()
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.borderColor = UIColor.greyTextColor.withAlphaComponent(0.2).cgColor
        selectedIndex = 1

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
