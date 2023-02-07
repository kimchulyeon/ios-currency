//
//  ViewController.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/06.

import UIKit

class PickerViewController: UIViewController {
	//MARK: - Properties
	@IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var usdTextField: UITextField!
	@IBOutlet weak var selectedCurrencyTextField: UITextField!
	@IBOutlet weak var selectedCurrencyLabel: UILabel!

	var pickerData: [[String: Double]]?
	var selectedRow = 0 {
		didSet {
			guard let keys = self.pickerData?[selectedRow].keys else { return }
			guard let values = self.pickerData?[selectedRow].values else { return }

			selectedCurrencyLabel.text = Array(keys)[0]
			selectedRowCurrencyName = Array(keys)[0]
			selectedRowCurrencyValue = Array(values)[0]

			selectedCurrencyTextField.text = calculateCurrency()
		}
	}
	var selectedRowCurrencyName = ""
	var selectedRowCurrencyValue: Double = 0


	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		pickerView.delegate = self
		pickerView.dataSource = self
		usdTextField.delegate = self


		configNavigationItem()
		fetchPickerItems()
	}

	//MARK: - func ============================================
	func configNavigationItem() {
		navigationItem.title = "currency picker page"
	}
	func fetchPickerItems() {
		let urlString = "https://open.er-api.com/v6/latest/USD"
		guard let url = URL(string: urlString) else { return }

		// data Task
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, res, err in
			guard let data = data else { return }
			guard let currencyModel = try? JSONDecoder().decode(CurrencyModel.self, from: data) else { return }
			guard let RATES = currencyModel.rates else { return }

			let rates = RATES.sorted(by: { dic1, dic2 in
				dic1.key < dic2.key
			}).map { key, value in
				[key: value]
			}

			self?.pickerData = rates

			DispatchQueue.main.async { [weak self] in
				self?.pickerView.reloadAllComponents()
			}
		}

		task.resume()
	}
	func calculateCurrency() -> String {
		let usdInputValue = Double(usdTextField.text ?? "") ?? 0

		return (selectedRowCurrencyValue * usdInputValue).description
	}
}


//MARK: - UIPickerViewDelegate ============================================
extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		pickerData?.count ?? 0
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		guard let keys = pickerData?[row].keys else { return "" }
		guard let values = pickerData?[row].values else { return "" }

		return Array(keys)[0] + "  " + String(format: "%.2f", Array(values)[0])
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedRow = row
	}
}

//MARK: - UITextFieldDelegate ============================================
extension PickerViewController: UITextFieldDelegate {
	func textFieldDidChangeSelection(_ textField: UITextField) {
		selectedCurrencyTextField.text = calculateCurrency()
	}
}
