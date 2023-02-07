//
//  TableViewController.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/06.
//

import UIKit

class ListViewController: UIViewController {
	//MARK: - Properties
	
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configNavigationItem()
	}
	
	//MARK: - func ============================================
	func configNavigationItem() {
		navigationItem.title = "currency list page"
	}
}


