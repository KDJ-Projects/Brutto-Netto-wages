//
//  HolidayView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 05/02/2023.
//

import SwiftUI

struct HolidayView: View {
    @State private var yearNetHourWage = ""
    
    // MARK: Variables 2023
    /// Working and nonworking days 2023
    static let workingDaysInYear = 249
    static let noneWorkingDaysInYear = 116 // includes weekends and payd hoidays
    
    /// Vacation days and days off
    static let annualYearlyLeaveDays = 20
    static let annualWorkingReduductionDays = 12
    static let annualPaydHolidays = 10
    
    static let totalWorkingHoursYear = workingDaysInYear * 8
    static let averigeWorkingDaysMonth = totalWorkingHoursYear / 12
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Text("OVERZICHT 2023")
                    //                    .foregroundColor(.green)
                        .font(.largeTitle)
                        .bold()
                    
                    Section {
                        Text("Werkdagen 2023: \(HolidayView.workingDaysInYear)")
                            .font(.title2)
                        Text("Werkuren 2023: \(HolidayView.totalWorkingHoursYear)")
                            .font(.title2)
                    } header: {
                        Text("Jaar")
                    }
                    
                    Section {
                        Text("Gemiddelde uren per maand: \(HolidayView.averigeWorkingDaysMonth)")
                            .font(.title2)
                    } header: {
                        Text("Maand")
                    }
                }
            }
        }
    }
}
    
    struct HolidayView_Previews: PreviewProvider {
        static var previews: some View {
            HolidayView()
//                .preferredColorScheme(.light)
        }
    }
