//
//  StringExtension.swift
//  diceroll
//
//  Created by Jared Counts on 6/18/18.
//  Copyright © 2018 Jared Counts. All rights reserved.
//

import Foundation

extension String {
	func IsValidDie(_ dice: Int) -> Bool {
		let die = [2, 4, 6, 8, 10, 12, 20, 100]
		if die.contains(dice) {
			return true
		} else {
			return false
		}
	}
	
	func TooManyDie(_ dice: Int) -> Bool {
		if dice < 100 {
			return false
		}
		return true
	}
	
	func matches(_ text: String) -> Bool {
		let diceRegex = try! NSRegularExpression(pattern: text, options: [])
		let ms = diceRegex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
		if ms.count > 0 {
			return true
		} else {
			return false
		}
	}
}
