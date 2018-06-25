//
//  diceroll.swift
//  diceroll
//
//  Created by Jared Counts on 6/18/18.
//  Copyright © 2018 Jared Counts. All rights reserved.
//

import Foundation

enum OptionType: String {
	case dice = "d"
	case help = "h"
	case quit = "q"
	case unknown
	
	init(value: String) {
		switch value {
		case "d": self = .dice
		case "h": self = .help
		case "q": self = .quit
		default: self = .unknown
		}
	}
}

class diceroll {
	let consoleIO = ConsoleIO()
	
	func staticMode() {
		let argCount = CommandLine.argc
		let argument = CommandLine.arguments[1]
		let argIndex = argument.index(argument.startIndex, offsetBy: 1)
		
		let (option, value) = getOption(String(argument[argIndex...]))
		switch option {
		case .dice:
			if argCount != 3 {
				if argCount > 3 {
					
				} else {
					consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
				}
				consoleIO.printUsage()
			} else {
				let dice = CommandLine.arguments[2]
				let results = rollThem(dice)
				switch results {
				case "Too many dice":
					consoleIO.writeMessage("Too many dice to roll, please enter less than 100", to: .error)
				case "Not a valid type":
					consoleIO.writeMessage("Not a valid die type. Supported # of sides is 2, 4, 6, 8, 10, 12, or 20.", to: .error)
				case "Invalid format":
					consoleIO.writeMessage("Invalid dice format. Please enter as (# of dice)d(# of sides)", to: .error)
				default:
					consoleIO.writeMessage("\(results)")
				}
				
			}
		case .help:
			consoleIO.printUsage()
		case .unknown, .quit:
			consoleIO.writeMessage("Unknown option \(value)")
			consoleIO.printUsage()
		}
	}
	
	func getOption(_ option: String) -> (option:OptionType, value: String) {
		return (OptionType(value: option), option)
	}
	
	func interactiveMode() {
		consoleIO.writeMessage("Welcome to Dice Roller. This program lets you roll a bunch of dice at the same time.")
		var shouldQuit = false
		while !shouldQuit {
			consoleIO.writeMessage("What kind and how many (e.g. 2d6, 1d20, etc.). You can also type 'q' to quit, or 'h' for help.")
			let first = consoleIO.getInput()
			if first.matches("([0-9]+)d([0-9]+)") {
				let results = rollThem(first)
				switch results {
				case "Too many dice":
					consoleIO.writeMessage("Too many dice to roll, please enter less than 100", to: .error)
				case "Not a valid type":
					consoleIO.writeMessage("Not a valid die type. Supported # of sides is 2, 4, 6, 8, 10, 12, or 20.", to: .error)
				case "Invalid format":
					consoleIO.writeMessage("Invalid dice format. Please enter as (# of dice)d(# of sides)", to: .error)
				default:
					consoleIO.writeMessage("\(results)")
				}
			} else if first == "q" {
				shouldQuit = true
				
			} else if first == "h" {
				consoleIO.printUsage()
			} else {
				consoleIO.writeMessage("Unknown option \(first)", to: .error)
			}
		}
	}
}

func rollThem(_ s: String) -> String {
	var result = ""
	var current = 0
	var total = 0
	if s.matches("[0-9]{1,2}d[0-9]{1,2}") {
		let diceArr = s.components(separatedBy: "d")
		let num = Int(diceArr[0])!
		let type = Int(diceArr[1])!
		if s.IsValidDie(type) {
			if !s.TooManyDie(num) {
				for count in 1...num {
					current = Int.random(in: 1 ... type)
					total = total + current
					if count == num {
						result.append(String(current))
					} else {
						result.append(String(current) + ", ")
					}
				}
				result.append("\n>> Total: " + String(total) + "\n")
				return result
			} else {
				result = "Too many dice"
				return result
			}
		} else {
			result = "Not a valid type"
			return result
		}
	} else {
		result = "Invalid format"
		return result
	}
}
