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

	var pickerData: [(String, Double)]?
	var usdTextFieldValue: Double? = 0


	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		usdTextField.delegate = self
		currencyTableView.delegate = self
		currencyTableView.dataSource = self

		configNavigationItem()
		registerTableViewCell()
		fetchJson()
	}

	//MARK: - func ============================================
	func configNavigationItem() {
		navigationItem.title = "currency list page"
	}
	func registerTableViewCell() {
		let cellNib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
		currencyTableView.register(cellNib, forCellReuseIdentifier: "CurrencyTableViewCell")
	}
	func fetchJson() {
		let urlString = "https://open.er-api.com/v6/latest/USD"
		guard let url = URL(string: urlString) else { return }

		URLSession.shared.dataTask(with: url) { data, res, err in
			guard let data = data else { return }

			do {
				let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
				self.pickerData = currencyModel.rates?.sorted { $0.key < $1.key }

				DispatchQueue.main.async {
					self.currencyTableView.reloadData()
				}
			} catch {
				print(error)
			}
		}.resume()
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
		cell.leftLabel.text = self.pickerData?[indexPath.row].0
		
		let changedValue = (self.pickerData?[indexPath.row].1 ?? 0) * (usdTextFieldValue ?? 0)
		
//		cell.rightLabel.text = self.pickerData?[indexPath.row].1.description
		cell.rightLabel.text = String(format: "%.2f", changedValue)
		return cell
	}
}
