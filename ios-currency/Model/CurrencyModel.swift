//
//  CurrencyModel.swift
//  ios-currency
//
//  Created by chulyeon kim on 2023/02/06.
//
// https://open.er-api.com/v6/latest/USD

import Foundation

struct CurrencyModel: Codable {
	let result: String?
	let provider: String?
	let baseCode: String?
	let rates: [String: Double]?
	let time: Int?
	
	enum CodingKeys: String, CodingKey {
		case result
		case provider
		case baseCode = "base_code"
		case rates
		case time = "time_last_update_unix"
	}
}

/*
{
	result: "success",
	provider: "https://www.exchangerate-api.com",
	documentation: "https://www.exchangerate-api.com/docs/free",
	terms_of_use: "https://www.exchangerate-api.com/terms",
	time_last_update_unix: 1675641751,
	time_last_update_utc: "Mon, 06 Feb 2023 00:02:31 +0000",
	time_next_update_unix: 1675728941,
	time_next_update_utc: "Tue, 07 Feb 2023 00:15:41 +0000",
	time_eol_unix: 0,
	base_code: "USD",
	rates: {
		USD: 1,
		AED: 3.6725,
		AFN: 90.018651,
		ALL: 106.601007,
		AMD: 396.546914,
		ANG: 1.79,
		XOF: 607.685486,
		XPF: 110.550424,
		YER: 250.201682,
		ZAR: 17.441305,
		ZMW: 19.209108,
		ZWL: 805.723003
		}
}
*/
