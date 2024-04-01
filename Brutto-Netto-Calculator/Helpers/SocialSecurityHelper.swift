//
//  SocialSecurityHelper.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 03/04/2023.
//

import Foundation
import SwiftUI

struct SocialSecurityHelper {
	// from 70857.99 up to 104422.24 deduction is 14.7%
	let minSocialPercentage: Double
	let minSocialBracket: Double
	// for amounts up to 70857.99 diduction is 20.5%
	let maxSocialPercentage: Double
	let maxSocialBracket: Double
	
	init() {
		self.minSocialPercentage = 0.147
		self.minSocialBracket = 70857.99
		self.maxSocialPercentage = 0.205
		self.maxSocialBracket = 104422.24
	}
}

let minPercentage = SocialSecurityHelper()
let minBracket = SocialSecurityHelper()
let maxPercentage = SocialSecurityHelper()
let maxBracket = SocialSecurityHelper()
