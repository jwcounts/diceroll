//
//  ConsoleIO.swift
//  diceroll
//
//  Created by Jared Counts on 6/18/18.
//  Copyright © 2018 Jared Counts. All rights reserved.
//

import Foundation

enum OutputType {
	case error
	case standard
}

class ConsoleIO {
	func writeMessage(_ message: String, to: OutputType = .standard) {
		switch to {
		case .standard:
			print("\u{001B}[;m>> \(message)")
		case .error:
			fputs("\u{001B}[0;31m>> \(message)\n", stderr)
		}
	}
	
	func printUsage() {
		let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
		
		writeMessage("usage:")
		writeMessage("\(executableName) -d (# of dice)d(# of sides)")
		writeMessage("or")
		writeMessage("\(executableName) -h to show usage information")
		writeMessage("Type \(executableName) without an option to enter interactive mode.")
	}
	
	func getInput() -> String {
		let keyboard = FileHandle.standardInput
		let inputData = keyboard.availableData
		let strData = String(data: inputData, encoding: String.Encoding.utf8)!
		return strData.trimmingCharacters(in: CharacterSet.newlines)
	}
	
}
