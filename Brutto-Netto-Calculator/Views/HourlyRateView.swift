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
	@State var totalWorkingHoursYear: Double = InformationView.totalWorkingHoursYear
	@State var monthsInYear: Double = 12.0
	@State var avererigeWorkDaysInMonth: Double = 20.75
	
	// MARK: Input variables
	@State var preferedHourlyFee = ""
	
	// MARK: National social security amounts
	// from 70857.99 up to 104422.24 deduction is 14.7%
	@State var maxSocialSecurityContributionPercentage: Double = 0.205
	@State var maxSocialSecurityContributionBracket: Double = 104422.24
	// fore amounts up to 70857.99 diduction is 20.5%
	@State var firstSocialSecurityContributionPercentage: Double = 0.147
	@State var firstSocialSecurityContributionBracket: Double = 70857.99
	
	// MARK: Value added tax
	@State var vatPercentage: Double = 0.21

	// MARK: Lump sum of professional expenses
	@State var lumpSumExpenses: Double = 3000.0
	
	// MARK: Tax brackets
	@State private var pesonalIncomeTaxBracket_25 = 0.25 // from 0.00 to 13.870,00
	@State private var personalIncomeTaxBracket_40 = 0.40 // from 13.870,00 to 24.480,00
	@State private var personalIncomeTaxBracket_45 = 0.45 // from 24.480,00 to 42.370,00
	@State private var personalIncomeTaxBrackte_50 = 0.50 // from 42.370,00 to ...
	
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
	@State private var MonthGrossWithTaxFee = ""
		
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
					.sheet(isPresented: $showBottomSheet) {
						List {
							// Day Section
//							Section {
//								Text("\(grossDayFee)")
//								Text("\(netDayWage)")
//									.foregroundColor(.green)
//							} header: {
//								Text("Dag bedrag")
//							}
							
							// Month Section
							Section {
								Text("\(MonthGrossWithTaxFee)")
									.foregroundColor(.red)
								Text("\(grossMonthFee)") //MARK: aanpassen!
									.foregroundColor(.blue)
								
								Text("\(netMonthWage)")
									.foregroundColor(.green)
								
							} header: {
								Text("Maand bedragen")
									.foregroundColor(.red)
							}
							
							// Year Section
							Section {
								Text("\(grossYearFee)")
								Text("\(grossSocialFee)")
								Text("\(yearlyTaxDeduction)")
								Text("\(yearlyNetWage)")
							} header: {
								Text("Jaar bedragen")
									.foregroundColor(.red)
							}
						}
						.presentationDetents([.fraction(0.65)])
					}
				}
			}
		}
    }
	
	
	// MARK: CALCULATION SECTION
	func calculateMonthlyWage() {
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
		
		var calculateGrossMonthWageWithTax: Double {
			guard let m = Optional(calculateGrossMonthWage),
				  let n = Optional(vatPercentage) else { return 0}
			return (m * n) + m
		}
		
		var calculateYearlySocialSecurityContribution: Double {
			guard let m = Optional(firstSocialSecurityContributionBracket * firstSocialSecurityContributionPercentage),
				  let n = Optional((maxSocialSecurityContributionBracket - firstSocialSecurityContributionBracket) *
				   maxSocialSecurityContributionPercentage) else { return 0 }
			return m + n
		}
		
		var calculateTaxableGrossYearWage: Double {
			guard let m = Optional(calculateGrossYearhWage),
				  let n = Optional(calculateYearlySocialSecurityContribution) else { return 0 }
			return m - n
		}
		
		var calculateYearlyTaxDeduction: Double {
			guard let m = Optional(pesonalIncomeTaxBracket_25),
				  let n = Optional(personalIncomeTaxBracket_40),
				  let o = Optional(personalIncomeTaxBracket_45),
				  let p = Optional(personalIncomeTaxBrackte_50),
				  let r = Optional(lumpSumExpenses),
				  let q = Optional(calculateTaxableGrossYearWage - r) else { return 0 }
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
		
		// MARK: FORMATTING SECTION
		// Day formating
//		let formatDailyFee = String(format:"%.2f", calculateGrossDayWage)
//		self.grossDayFee = "Brutto dag bedrag: \(formatDailyFee) €"
		
//		let formatNetDayWage = String(format:"%.2f", calculateNetDayWage)
//		self.netDayWage = "Netto dag loon: \(formatNetDayWage) €"

		// Month formating
		let formatMonthfeeWhitTax = String(format:"%.2f", calculateGrossMonthWageWithTax)
		self.MonthGrossWithTaxFee = "Omzet + btw(21%): \(formatMonthfeeWhitTax) €"
		
		let formatMonthFee = String(format:"%.2f", calculateGrossMonthWage)
		self.grossMonthFee = "Netto omzet: \(formatMonthFee) €"
		
		let formatNetMonthWage = String(format:"%.2f", calculateNetMonthWage)
		self.netMonthWage = "Netto inkomsten: \(formatNetMonthWage) €"

		// Year fromating
		let formatYearlyFee = String(format:"%.2f", calculateGrossYearhWage)
		self.grossYearFee = "Brutto omzet: \(formatYearlyFee) €"
		
		let formatYearlySocialSecurity = String(format:"%.2f", calculateYearlySocialSecurityContribution)
		self.grossSocialFee = "RSZ bijdrage: \(formatYearlySocialSecurity) €"
		
		let formatYearlyTaxDeduction = String(format:"%.2f", calculateYearlyTaxDeduction)
		self.yearlyTaxDeduction = "Personen belasting: \(formatYearlyTaxDeduction) €"
		
		let formatYearlyNetWage = String(format:"%.2f", calculateYearlyNetWage)
		self.yearlyNetWage = "Netto inkomsten: \(formatYearlyNetWage) €"
	}
}

struct HourlyRateView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyRateView()
    }
}
