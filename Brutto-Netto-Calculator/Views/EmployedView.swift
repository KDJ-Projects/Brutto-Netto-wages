//
//  EmployedView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 14/12/2021.
//

import SwiftUI
import Foundation

struct EmployedView: View {
	@State private var grossSalary = ""
	@State private var netSalary = ""
	@State private var daysWorked = ""
	@State private var dailyMealFee = ""
	@State private var dailyRoadFee = ""
	@State private var carwashCellPhoneExpense = ""
	@State private var netAmount = ""
	@State private var benefitInKind = "" // 319.35€ lease car Tiguan
	
	@State private var showAlert = false
	@State private var showNetSalary = false
	
	var body: some View {
		
		ZStack {
			
			VStack (spacing: 5) {
				HStack {
					VStack {
						Text("MAANDBEREKENING")
							.font(.largeTitle)
							.foregroundColor(txt.textColor)
						Text("WERKNEMER")
							.font(.largeTitle)
							.foregroundColor(txt.textColor)
					}
				}.padding()
				
				HStack {
					Image(systemName: "eurosign.circle")
						.resizable()
						.foregroundColor(.blue)
						.frame(width: 130, height: 130)
				}.padding(.bottom, 40)
				
				HStack (spacing: -10) {
					Text("Brutto verloning:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 280, height: 10, alignment: .leading)
						.padding(.leading, 50)
					
					TextField("", text: $grossSalary)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
						.padding(.trailing, 50)
				}.padding()
				
				HStack (spacing: -10) {
					Text("Aantal gewerkte dagen:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 280, height: 10, alignment: .leading)
						.padding(.leading, 50)
					
					TextField("", text: $daysWorked)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
						.padding(.trailing, 50)
				}.padding()
				
				HStack (spacing: -10) {
					Text("Bedrag maaltijd vergoeding:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 280, height: 10, alignment: .leading)
						.padding(.leading, 50)
					
					TextField("", text: $dailyMealFee)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
						.padding(.trailing, 50)
				}.padding()
				
				HStack (spacing: -10) {
					Text("Bedrag baan vergoeding:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 280, height: 10, alignment: .leading)
						.padding(.leading, 50)
					
					TextField("", text: $dailyRoadFee)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
						.padding(.trailing, 50)
				}.padding()
				
				HStack (spacing: -10) {
					Text("Vergoeding overige onkosten:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 280, height: 10, alignment: .leading)
						.padding(.leading, 50)
					
					TextField("", text: $carwashCellPhoneExpense)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
						.padding(.trailing, 50)
				}.padding()
				
				HStack (spacing: -10) {
					Text("Voordeel alle aard (VAA):")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 280, height: 10, alignment: .leading)
						.padding(.leading, 50)
					
					TextField("", text: $benefitInKind)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
						.padding(.trailing, 50)
				}.padding()
				
				Spacer()
				
				HStack(alignment: .center) {
					
					Button("Bereken".uppercased()) {
						calculateNetSalary()
					}
					.font(.largeTitle)
					.foregroundColor(txt.textColor)
					.frame(width: 280, height: 30, alignment: .center)
					.padding()
					.background(
						Capsule()
							.stroke(btn.buttonColor, lineWidth: 2.0)
					)
					.alert("Geef waardes in", isPresented: $showAlert) {}
					.alert(self.netAmount.uppercased(), isPresented: $showNetSalary) {}
				}
			}
		}
	}
	
	func calculateNetSalary() {
		@State var monthlyTax = ""
		@State var netMeal = ""
		@State var netRoad = ""
		@State var netMonthFee = ""
		
		@State var monthlysocialSecurityContribution = 0.1307
		@State var monthlyWageTax = 0.36811227424364431
		
		// Calculations
		// Calculating monthly gross taxable wage amount
		var calcGrossTaxable: Double{
			guard let m = Double(grossSalary),
				  let n = Optional(monthlysocialSecurityContribution),
				  let result = Optional(m - (m * n))
			else { return 0 }
			return result
		}
		
		// Calculating monthly gross taxable (wage + leasecar) amount
		var calcGrossTaxableWithCar: Double{
			guard let m = Double(grossSalary),
				  let o = Double(benefitInKind),
				  let n = Optional(monthlysocialSecurityContribution),
				  let result = Optional(o + (m - (m * n)))
			else { return 0 }
			return result
		}
		
		var calcMonthlyTax: Double{
			guard let m = Optional(calcGrossTaxableWithCar),
				  let n = Optional(monthlyWageTax)
			else { return 0 }
			return m * n
		}
		
		// Caclulating net wage amount
		var calcNetSalary: Double{
			guard let m = Optional(calcGrossTaxableWithCar),
				  let n = Optional(calcMonthlyTax),
				  let o = Double(benefitInKind)
			else { return 0 }
			return m - n - o
		}
		
		var calcNetMealFees: Double{
			guard let m = Double(daysWorked),
				  let n = Double(dailyMealFee)
			else { return 0 }
			return m * n
		}
		
		var calcdailyRoadFees: Double{
			guard let m = Double(daysWorked),
				  let n = Double(dailyRoadFee)
			else { return 0 }
			return m * n
		}
		
		var calcMonthFees: Double {
			guard let m = Optional(1.0),
				  let n = Double(carwashCellPhoneExpense)
			else { return 0 }
			return m * n
		}
		
		var calcTotalNetSalary: Double {
			guard let net = Optional(calcNetSalary + calcNetMealFees +
									 calcdailyRoadFees + calcMonthFees)
			else { return 0 }
			return net
		}
		
		// Formating outputs
		let monthlyTaxFormat = String(format:"%.1f", calcMonthlyTax)
		monthlyTax = "Maandelijks belasting: \n\(monthlyTaxFormat) €"
		
		let dailyMealVouchersFormat = String(format:"%.1f", calcNetMealFees)
		netMeal = "Maaltijd bedrag: \n\(dailyMealVouchersFormat) €"
		
		let dailyRoadFeesFormat = String(format:"%.1f", calcdailyRoadFees)
		netRoad = "Baan vergoeding: \n\(dailyRoadFeesFormat)"
		
		let monthlyFeesFormat = String(format:"%.1f", calcMonthFees)
		netMonthFee = "Vergoedingen: \n\(monthlyFeesFormat)"
		
		let monthSalaryFormat = String(format:"%.1f", calcNetSalary)
		self.netSalary = "Netto verloning: \n\(monthSalaryFormat) €"
		
		let FeesSalaryFormat = String(format:"%.1f", calcTotalNetSalary)
		self.netAmount = "Netto loon \n\(FeesSalaryFormat) €"
		
		// Error handling if textfield is empthy show alert
		grossSalary == "" || daysWorked == "" || dailyMealFee == "" ||
		dailyRoadFee == "" || carwashCellPhoneExpense == "" || benefitInKind == ""
		? showAlert.toggle() : showNetSalary.toggle()
	}
}

struct EmployedView_Previews: PreviewProvider {
	static var previews: some View {
		EmployedView()
	}
}
