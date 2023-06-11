//
//  InformationView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 05/02/2023.
//

import SwiftUI

struct InformationView: View {
    @State private var yearNetHourWage = ""
    
    // MARK: Variables 2023 -> Belgium
    /// Working and non working days in 2023
	static let workingDaysInYear: Int = 249 // Total workable days this year
	static let noneWorkingDaysInYear: Int = 116 // Unworkable days includes weekends and payd hoidays
    
    /// Vacation days and days off in 2023
	static let annualYearlyLeaveDays: Int = 20 // Total leave days
	static let annualWorkingReduductionDays: Int = 12 // Total reduction of working days
	static let annualPaydHolidays: Int = 10 // Total payed holidday
    
	static let totalWorkingHoursYear = Double(workingDaysInYear) * Double(8)
	static let totalWorkignHoursYearFormat = String(format: "%.0f", totalWorkingHoursYear)
	
    static let averigeWorkingDaysMonth = totalWorkingHoursYear / Double(12)
	static let averigeWorkingDaysMothFormat = String(format: "%.0f", averigeWorkingDaysMonth)
	
	// Formating currency
	static let lumpSumExpenses: Double = 3000 // Lumpsum of the yearly deductible professional expenses
	static let lumpSumExpensesFormat = String(format: "%.0f", lumpSumExpenses)
	
	// Background color image
	let imageBackgroundColor : Color = Color(red: 242/255, green: 242/255, blue: 247/255)
	
    var body: some View {
        ZStack {
            VStack {
				
				HStack {
					Image(systemName: "info.bubble")
						.resizable()
						.foregroundColor(.blue)
						.frame(width: 200, height: 200)
				}.padding(.bottom, 0)
				
                List {
                    Text("INFORMATIE 2023         ")
						.multilineTextAlignment(.center)
						.foregroundColor(.blue)
                        .font(.largeTitle)
                        .bold()

                    Section {
                        Text("Aantal werkdagen: \(InformationView.workingDaysInYear)")
							.font(.callout)
                        Text("Aantal werkuren: \(InformationView.totalWorkignHoursYearFormat)")
                            .font(.callout)
						Text("Aantal feestdagen: \(InformationView.annualPaydHolidays)")
							.font(.callout)
                    } header: {
                        Text("Jaar")
							.foregroundColor(.green)
                    }
                    
                    Section {
                        Text("Gemiddelde aantal uren: \(InformationView.averigeWorkingDaysMothFormat)")
                            .font(.callout)
                    } header: {
                        Text("Maand")
							.foregroundColor(.green)
                    }
					
					// Info section
					Section {
						Text("Forfaitaire beroepskosten: \(InformationView.lumpSumExpensesFormat) €")
						
					} header: {
						Text("Info")
							.foregroundColor(.green)
					}
                }
            }
//			.background(imageBackgroundColor)
        }
    }
}
    
struct HolidayView_Previews: PreviewProvider {
	static var previews: some View {
		InformationView()
//			.preferredColorScheme(.dark)
	}
}
