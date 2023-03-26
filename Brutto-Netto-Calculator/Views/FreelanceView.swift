//
//  FreelanceView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 24/01/2023.
//

import SwiftUI

struct FreelanceView: View {
    // Input variables
    @State private var peferedNetSalary = ""
    @State private var daysWorked = ""
    @State private var monthlyFixedFee = ""
    @State private var consultingPercentage = ""
    
    // Bottom sheet variables
    @State private var showBottomSheet: Bool = false
    @State private var showAlert: Bool = false
    @State private var grossAmount = ""
    @State private var netHourWage = ""
    @State private var yearNetHourWage = ""
    @State private var monthVat = ""
    @State private var grossWithVat = ""
    
    // Color variables
    @State private var textColor = Color.blue
    @State private var buttonColor = Color.blue
    @State private var textFieldColor = Color.blue
    
    var body: some View {
        ZStack {
            VStack {
                // Title
                HStack {
					VStack {
                        Text("MAANDBEREKENING")
                            .font(.largeTitle)
                            .foregroundColor(textColor)
                        Text("FREELANCER")
                            .font(.largeTitle)
                            .foregroundColor(textColor)
                    }
                }.padding()
                
                // Input prefered monthly pay
                HStack {
                    Text("Gewenst maandelijks netto loon:")
                        .font(.body)
                        .foregroundColor(textColor)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $peferedNetSalary)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(textColor)
                        .border(textFieldColor)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                // Input days monthly days work
                HStack {
                    Text("Aantal werk dagen per maand:")
                        .font(.body)
                        .foregroundColor(textColor)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $daysWorked)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(textColor)
                        .border(textFieldColor)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                // Input fixed monthly fee
                HStack {
                    Text("Vaste maandelijkse vaste kosten:")
                        .font(.body)
                        .foregroundColor(textColor)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $monthlyFixedFee)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(textColor)
                        .border(textFieldColor)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                Spacer()
                
                // Calculate button
                VStack(alignment: .leading) {
                    Button("Bereken".uppercased()) {
                        calculateNetEarnings()
						
						// MARK: Error handling if textfield is empthy show alert
						peferedNetSalary == "" || daysWorked == "" || monthlyFixedFee == ""
						? showAlert.toggle() :  showBottomSheet.toggle()
                    }
                    .font(.largeTitle)
                    .foregroundColor(textColor)
                    .frame(width: 280, height: 30, alignment: .center)
                    .padding()
                    .background(
                        Capsule()
                            .stroke(buttonColor, lineWidth: 2.0)
                    )
                    .alert(isPresented: self.$showAlert) {
                        Alert(title: Text("Error"),
                              message: Text("⚠️ Geef alle waardes in ⚠️")
                        )
                    }
                    .sheet(isPresented: $showBottomSheet, content: {
                        List {
                            Section {
                                Text("\(grossAmount)")
                                Text("\(monthVat)")
                                Text("\(grossWithVat)")
                                    .foregroundColor(.red)
                            } header: {
                                Text("Maand bedragen")
                            }
                            
                            Section {
                                Text("\(netHourWage)")
                                Text("\(yearNetHourWage)")
                            } header: {
                                Text("Uur bedragen")
                            }
                        }
                        // .presentationDetents([.large, .medium, .fraction(0.75)])
                        //                        .presentationDetents([.medium])
                        .presentationDetents([.fraction(0.40)])
                    })
                }
                
                Spacer()
            }
        }
    }
    
    func calculateNetEarnings() {
        // Day calculation variables
        @State var yearlySocialSecurityFixedContribution = 751.25 // Fixed starter contribution for the first 3 years
        @State var yearlySocialSecurityContribution = 20.5 / 100
        @State var valueAddedTax: Double = 21.0
        @State var numberOfHoursPerDay: Double = 8.0
        @State var multiplyFactor: Double = 2.0
        
        // Vacation days and days off
        @State var annualYearlyLeaveDays = 20
        @State var annualWorkingReduductionDays = 12
        @State var annualPaydHolidays = 10
        
        @State var totalWorkingDays: Double = 249
        
        @State var totalWorkingHoursYear: Double = totalWorkingDays * 8
        
        // MARK: Calculations
        // Calculates workingdays to workinghours
        var calculateDaysToHours: Double {
            guard let workDays = Double(daysWorked),
                  let dayHours = Optional(numberOfHoursPerDay)
                    
            else { return 0 }
            return workDays * dayHours
        }
        
        // Calculates monthly total earnings
        var calculateGrossEarnings: Double {
            guard let salary = Double(peferedNetSalary),
                  let fixedFee = Double(monthlyFixedFee),
                  let multi = Optional(multiplyFactor)
                    
            else { return 0 }
            return (salary + fixedFee) * multi
        }
        
        // Calculate monthly value added tax
        var calculateValueAddedTax: Double {
            guard let vat = Optional(valueAddedTax),
                  let gross = Optional(calculateGrossEarnings)
                    
            else { return 0 }
            return gross * (vat / 100)
        }
        
        // Calculating monthly gross wage
        var calculateGrossWageWithVat: Double {
            guard let m = Optional(calculateGrossEarnings),
                  let n = Optional(calculateValueAddedTax)
                    
            else { return 0 }
            return m + n
        }
        
        // Calculate hourly rate
        var calculateHourlyRate: Double {
            guard let workDays = Double(daysWorked),
                  let workingDayHours = Optional(8),
                  let earnings = Optional(calculateGrossEarnings)
                    
            else { return 0 }
            return earnings / (workDays * Double(workingDayHours))
        }
        
        // Calculate hourly rate for full year
        var caclulateYearlyHourlyRate: Double {
            guard let totalHours = Optional(totalWorkingHoursYear),
                  let monthsInYear = Optional(Double(13)),
                  let preferedSalary = Double(peferedNetSalary),
                  let fixedFee = Double(monthlyFixedFee)
            else { return 0 }
            return (((preferedSalary + fixedFee)*2) * monthsInYear) / totalHours
        }
        
        // MARK: Formating bottom sheet outputs
        let formatGrossEarnings = String(format:"%.2f", calculateGrossEarnings)
        self.grossAmount = "Brutto maand bedrag: \(formatGrossEarnings) €"
        
        let formatMonthlyVatContribution = String(format:"%.2f", calculateValueAddedTax)
        self.monthVat = "BTW bedrag per maand: \(formatMonthlyVatContribution) €"
        
        let formatMonthlyGrossWithVat = String(format:"%.2f", calculateGrossWageWithVat)
        self.grossWithVat = "Brutto + Btw: \(formatMonthlyGrossWithVat) €"
        
        let formatNetHourlyWage = String(format:"%.2f", calculateHourlyRate)
        self.netHourWage = "Uurbedrag maand basis: \(formatNetHourlyWage) €"
        
        let formatNetYearHourlyWage = String(format:"%.2f", caclulateYearlyHourlyRate)
        self.yearNetHourWage = "Uurbedrag op jaar basis: \(formatNetYearHourlyWage) €"
    }
}

struct FreelanceView_Previews: PreviewProvider {
    static var previews: some View {
        FreelanceView()
			.preferredColorScheme(.dark)
    }
}
