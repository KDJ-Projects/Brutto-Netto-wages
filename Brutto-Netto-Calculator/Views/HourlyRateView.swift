//
//  HourlyRateView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 12/02/2023.
//

import SwiftUI

struct HourlyRateView: View {
	// MARK: Input variables
	@State var preferedHourlyFee = ""

	// MARK: Lump sum of professional expenses
	@State var lumpSumExpenses: Double = 3000.0
	
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
	
    var body: some View {
		ZStack {
			VStack {
				// Title
				HStack {
					Text("FREELANCE UURTARIEF")
						.font(.largeTitle)
						.foregroundColor(txt.textColor)
				}.padding(.bottom, 40)
				
				HStack {
					Image(systemName: "eurosign.circle")
						.resizable()
						.foregroundColor(.blue)
						.frame(width: 200, height: 200)
				}.padding(.bottom, 50)
				
				// Input hourly rate
				HStack {
					Text("Gewenst uurloon:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 250, height: 10, alignment: .leading)
					
					TextField("", text: $preferedHourlyFee)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numbersAndPunctuation)
						.foregroundColor(txt.textColor)
						.border(txtf.textFieldColor)
						.frame(width: 65, height: 10, alignment: .center)
					
					Text("€")
							.font(.body)
							.foregroundColor(txt.textColor)
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
					.foregroundColor(txt.textColor)
					.frame(width: 280, height: 30, alignment: .center)
					.padding()
					.background(
						Capsule()
							.stroke(btn.buttonColor, lineWidth: 2.0)
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
						.presentationDetents([.fraction(0.50)])
						.presentationDragIndicator(.visible)
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
				  let n = Optional(workingDays.workingDays) else { return 0 }
			return m * n
		}
		
		var calculateGrossMonthWage: Double {
			guard let m = Optional(calculateGrossYearhWage),
				  let n = Optional(monthsInYear.monthsInYear) else { return 0 }
			return m / n
		}
		
		var calculateGrossMonthWageWithTax: Double {
			guard let m = Optional(calculateGrossMonthWage),
				  let n = Optional(vat.vatPercentage) else { return 0}
			return (m * n) + m
		}
		
		var calculateYearlySocialSecurityContribution: Double {
			guard let m = Optional(minBracket.minSocialBracket * minPercentage.minSocialPercentage),
				  let n = Optional((maxBracket.maxSocialBracket - minBracket.minSocialBracket) *
								   maxPercentage.maxSocialPercentage) else { return 0 }
			return m + n
		}
		
		var calculateTaxableGrossYearWage: Double {
			guard let m = Optional(calculateGrossYearhWage),
				  let n = Optional(calculateYearlySocialSecurityContribution) else { return 0 }
			return m - n
		}
		
		var calculateYearlyTaxDeduction: Double {
			guard let m = Optional(bracket25.tax_25),
				  let n = Optional(bracket40.tax_40),
				  let o = Optional(bracket45.tax_45),
				  let p = Optional(bracket50.tax_50),
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
				  let n = Optional(monthsInYear.monthsInYear) else { return 0 }
			return m / n
		}
		
		var calculateNetDayWage: Double {
			guard let m = Optional(calculateNetMonthWage),
				  let n = Optional(averigeWorkingDaysMonth.averigeWorkingDaysMonth) else { return 0 }
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
