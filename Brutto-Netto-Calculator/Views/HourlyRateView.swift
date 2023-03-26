//
//  HourlyRateView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 12/02/2023.
//

import SwiftUI

struct HourlyRateView: View {
	// MARK: Global variables
	@State var totalWorkingDays: Double = 249.0
	@State var monthsInYear: Double = 12.0
	@State var avererigeWorkDaysInMonth: Double = 20.75
	@State var taxPercentage: Double = 0.21
	@State var socialSecurityContribution: Double = 0.25
	
	// MARK: Input variables
	@State private var preferedHourlyFee = ""
	
	// MARK: Tax brackets
	@State private var taxBracket_25 = 0.25 // from 0.00 to 13.870,00
	@State private var taxBracket_40 = 0.40 // from 13.870,00 to 24.480,00
	@State private var taxBracket_45 = 0.45 // from 24.480,00 to 42.370,00
	@State private var taxBrackte_50 = 0.50 // from 42.370,00 to ...
	
	// MARK: Bottom sheet variables
	@State private var showBottomSheet: Bool = false
	@State private var grossDayFee = ""
	@State private var grossMonthFee = ""
	@State private var grossYearFee = ""
	@State private var grossSocialFee = ""
	@State private var yearlyTaxDeduction = ""
	@State private var yearlyNetWage = ""
	@State private var netMonthWage = ""
	@State private var netDayWage = ""
		
	// MARK: Color variables
	@State private var textColor = Color.blue
	@State private var buttonColor = Color.blue
	@State private var textFieldColor = Color.blue
	
    var body: some View {
		ZStack {
			VStack {
				// Title
				HStack {
					Text("FREELANCE UURTARIEF")
						.font(.largeTitle)
						.foregroundColor(textColor)
				}.padding(.bottom, 50)
				
				// Input hourly rate
				HStack {
					Text("Gewenst uurloon:")
						.font(.body)
						.foregroundColor(textColor)
						.bold()
						.frame(width: 250, height: 10, alignment: .leading)
					
					TextField("", text: $preferedHourlyFee)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(textColor)
						.border(textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
					
					Text("€")
							.font(.body)
							.foregroundColor(textColor)
							.bold()
							.frame(width: 10, height: 10, alignment: .leading)
				}.padding()
				
				Spacer()
				
				HStack {
					Button("Bereken".uppercased()) {
						calculateMonthlyWage()
						showBottomSheet.toggle()
					}
					.font(.largeTitle)
					.foregroundColor(textColor)
					.frame(width: 280, height: 30, alignment: .center)
					.padding()
					.background(
						Capsule()
							.stroke(buttonColor, lineWidth: 2.0)
					)
					.sheet(isPresented: $showBottomSheet, content: {
						List {
							// Day section
							Section {
								Text("\(grossDayFee)")
								Text("\(netDayWage)")
									.foregroundColor(.green)
							} header: {
								Text("Dag bedrag")
							}
							
							// Month section
							Section {
								Text("\(grossMonthFee)")
								Text("\(netMonthWage)")
									.foregroundColor(.green)
							} header: {
								Text("Maand bedrag")
							}
							
							// Year section
							Section {
								Text("\(grossYearFee)")
								Text("\(grossSocialFee)")
								Text("\(yearlyTaxDeduction)")
								Text("\(yearlyNetWage)")
									.foregroundColor(.green)
							} header: {
								Text("Jaar bedrag")
							}
						}
						.presentationDetents([.fraction(0.60)])
					})
				}
			}
		}
    }
	
	func calculateMonthlyWage() {
		// MARK: Variables
		
		// MARK: Calculations
		var calculateGrossDayWage: Double {
			guard let m = Double(preferedHourlyFee),
				  let n = Optional(Double(8.0)) else { return 0 }
			return m * n
		}
		
		var calculateGrossYearhWage: Double {
			guard let m = Optional(calculateGrossDayWage),
				  let n = Optional(totalWorkingDays) else { return 0 }
			return m * n
		}
		
		var calculateGrossMonthWage: Double {
			guard let m = Optional(calculateGrossYearhWage),
				  let n = Optional(Double(monthsInYear)) else { return 0 }
			return m / n
		}
		
		var calculateYearlySocialSecurityContribution: Double {
			guard let m = Optional(socialSecurityContribution),
				  let n = Optional(calculateGrossYearhWage) else { return 0 }
			return (n * m)
		}
		
		var calculateTaxableGrossYearWage: Double {
			guard let m = Optional(calculateGrossYearhWage),
				  let n = Optional(calculateYearlySocialSecurityContribution) else { return 0 }
			return m - n
		}
		
		var calculateYearlyTaxDeduction: Double {
			guard let m = Optional(taxBracket_25),
				  let n = Optional(taxBracket_40),
				  let o = Optional(taxBracket_45),
				  let p = Optional(taxBrackte_50),
				  let q = Optional(calculateTaxableGrossYearWage) else { return 0 }
			return (13870.00 * m) + (10610.00 * n) + (17890.00 * o) + ((q - 42370.00) * p)
		}
		
		var calculateYearlyNetWage: Double {
			guard let m = Optional(calculateTaxableGrossYearWage),
				  let n = Optional(calculateYearlyTaxDeduction) else { return 0 }
			return m - n
		}
		
		var calculateNetMonthWage: Double {
			guard let m = Optional(calculateYearlyNetWage),
				  let n = Optional(monthsInYear) else { return 0 }
			return m / n
		}
		
		var calculateNetDayWage: Double {
			guard let m = Optional(calculateNetMonthWage),
				  let n = Optional(avererigeWorkDaysInMonth) else { return 0 }
			return m / n
		}
		
		// MARK: Formatting
		let formatDailyFee = String(format:"%.2f", calculateGrossDayWage)
		self.grossDayFee = "Brutto dag bedrag: \(formatDailyFee) €"
		
		let formatYearlyFee = String(format:"%.2f", calculateGrossYearhWage)
		self.grossYearFee = "Brutto jaar bedrag: \(formatYearlyFee) €"
		
		let formatMonthFee = String(format:"%.2f", calculateGrossMonthWage)
		self.grossMonthFee = "Brutto maand bedrag: \(formatMonthFee) €"
		
		let formatYearlySocialSecurity = String(format:"%.2f", calculateYearlySocialSecurityContribution)
		self.grossSocialFee = "Jaarlijkse RSZ bijdrage: \(formatYearlySocialSecurity) €"
		
		let formatYearlyTaxDeduction = String(format:"%.2f", calculateYearlyTaxDeduction)
		self.yearlyTaxDeduction = "Jaarlijkse BTW bijdrage: \(formatYearlyTaxDeduction) €"
		
		let formatYearlyNetWage = String(format:"%.2f", calculateYearlyNetWage)
		self.yearlyNetWage = "Jaarlijks netto loon: \(formatYearlyNetWage) €"
		
		let formatNetMonthWage = String(format:"%.2f", calculateNetMonthWage)
		self.netMonthWage = "Netto maand loon: \(formatNetMonthWage) €"
		
		let formatNetDayWage = String(format:"%.2f", calculateNetDayWage)
		self.netDayWage = "Netto dag loon: \(formatNetDayWage) €"
	}
}

struct HourlyRateView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyRateView()
    }
}
