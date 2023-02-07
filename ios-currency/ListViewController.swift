//
//  TableViewController.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/06.
//

import UIKit

class ListViewController: UIViewController {
	//MARK: - Properties

	@IBOutlet weak var usdTextField: UITextField!
	@IBOutlet weak var currencyTableView: UITableView!

	var pickerData: [[String: Double]]?
	var usdTextFieldValue: Double? = 0


	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		usdTextField.delegate = self
		currencyTableView.delegate = self
		currencyTableView.dataSource = self

		configNavigationItem()
		registerTableViewCell()
		fetchPickerItems()
	}

	//MARK: - func ============================================
	func configNavigationItem() {
		navigationItem.title = "currency list page"
	}
	func registerTableViewCell() {
		let cellNib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
		currencyTableView.register(cellNib, forCellReuseIdentifier: "CurrencyTableViewCell")
	}
	func fetchPickerItems() {
		CurrencyNetwork.fetchPickerItems { [weak self] currencyModel in
			guard let RATES = currencyModel.rates else { return }

			let rates = RATES.sorted(by: { dic1, dic2 in
				dic1.key < dic2.key
			}).map { key, value in
				[key: value]
			}

			self?.pickerData = rates

			DispatchQueue.main.async {
				self?.currencyTableView.reloadData()
			}
		}
	}
}


//MARK: - UITextFieldDelegate ============================================
extension ListViewController: UITextFieldDelegate {
	func textFieldDidChangeSelection(_ textField: UITextField) {
		usdTextFieldValue = Double(textField.text ?? "")

		currencyTableView.reloadData()
	}
}

//MARK: - UITableViewDelegate, UITableViewDataSource ============================================
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pickerData?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
		guard let keys = pickerData?[indexPath.row].keys else { return UITableViewCell() }
		guard let values = pickerData?[indexPath.row].values else { return UITableViewCell() }

		cell.leftLabel.text = Array(keys)[0]
		let changedValue = Array(values)[0] * (usdTextFieldValue ?? 0)
		cell.rightLabel.text = String(format: "%.2f", changedValue)

		return cell
	}
}
