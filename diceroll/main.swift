//
//  main.swift
//  diceroll
//
//  Created by Jared Counts on 6/18/18.
//  Copyright © 2018 Jared Counts. All rights reserved.
//

import Foundation

let Diceroll = diceroll()
if CommandLine.argc < 2 {
	Diceroll.interactiveMode()
} else {
	Diceroll.staticMode()
}
