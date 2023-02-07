//
//  TabbarController.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/06.
//

import UIKit

class TabbarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()

 		tabBar.items?[0].title = "Picker"
		tabBar.items?[0].image = UIImage(systemName: "filemenu.and.selection")?.withRenderingMode(.alwaysOriginal)
		tabBar.items?[1].title = "List"
		tabBar.items?[1].image = UIImage(systemName: "list.dash")?.withRenderingMode(.alwaysOriginal)
		
		let tabBarAppearance = UITabBarAppearance()
		let tabBarItemAppearance = UITabBarItemAppearance()
		
		tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
		tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
		
		tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
		
		tabBar.standardAppearance = tabBarAppearance
		if #available(iOS 15.0, *) {
			tabBar.scrollEdgeAppearance = tabBarAppearance
		}
	}
}


