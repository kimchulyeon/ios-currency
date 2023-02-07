//
//  Network.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/07.
//

import Foundation

enum NetworkError: Error {
	case badUrl
	case noRes
	case statusError
}

struct CurrencyNetwork {
	// @escaping : 함수를 끝내지 않게 하기 위해
	static func fetchPickerItems(completion: @escaping (CurrencyModel) -> Void) {
		let urlString = "https://open.er-api.com/v6/latest/USD"
		guard let url = URL(string: urlString) else { return }

		let task = URLSession.shared.dataTask(with: url) { data, res, err in
			guard let data = data else { return }
			guard let currencyModel = try? JSONDecoder().decode(CurrencyModel.self, from: data) else { return }
			
			completion(currencyModel)
//			guard let RATES = currencyModel.rates else { return }
//
//			let rates = RATES.sorted(by: { dic1, dic2 in
//				dic1.key < dic2.key
//			}).map { key, value in
//				[key: value]
//			}

			
		}

		task.resume()
	}
	
	

}
