//
//  LeaseCarView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 05/04/2023.
//

import SwiftUI

struct LeaseCarView: View {
	
	// MARK: Input variables
	@State var monthlyLeaseAmount = ""
	@State var monthlyGasExpense = ""
	@State var totalDrivingDays = ""
	@State var daysInYear = 356
	
	// MARK: Bottom sheet variables
	@State private var showBottomSheet: Bool = false
	@State private var monthTotalCost = ""
	@State private var yearlytotalLeaseCost = ""
	@State private var yearlyTotalFullCost = ""
	@State private var totalcost = ""
	
	var body: some View {
		ZStack {
			VStack {
				// Title
				HStack {
					Text("LEASEWAGEN")
						.font(.largeTitle)
						.foregroundColor(txt.textColor)
				}.padding(.bottom, 50)
				
				// Input hourly rate
				
				HStack {
					Image(systemName: "car.circle")
						.resizable()
						.foregroundColor(.blue)
						.frame(width: 200, height: 200)
				}.padding(.bottom, 50)
				
				HStack {
					Text("Maand lease bedrag:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 250, height: 10, alignment: .leading)
					
					TextField("", text: $monthlyLeaseAmount)
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
				
				HStack {
					Text("Maand bezine bedrag:")
						.font(.body)
						.foregroundColor(txt.textColor)
						.bold()
						.frame(width: 250, height: 10, alignment: .leading)
					
					TextField("", text: $monthlyGasExpense)
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
						leaseCalculations()
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
							// Month Section
							Section {
								Text("\(monthTotalCost)")
									.foregroundColor(.green)
							} header: {
								Text("Maand bedragen")
									.foregroundColor(.blue)
							}
							
							// Year Section
							Section {
								Text("\(yearlytotalLeaseCost)")
									.foregroundColor(.green)
								
								Text("\(yearlyTotalFullCost)")
									.foregroundColor(.green)
								
								Text("\(totalcost)")
									.foregroundColor(.green)
							} header: {
								Text("Jaar bedragen")
									.foregroundColor(.blue)
							}
						}
						.presentationDetents([.fraction(0.40)])
					}
				}
			}
		}
	}

	// MARK: CALCULATION SECTION
	func leaseCalculations() {
		
		var calculateMonthCost: Double {
			guard let m = Double(monthlyLeaseAmount),
				  let n = Optional(Double(monthlyGasExpense)) else { return 0 }
			return (m + (n ?? 0)).rounded(toPlaces: 2)
		}
		
		var calculateTotalLeaseCost: Double {
			guard let m = Double(monthlyLeaseAmount),
				  let n = Optional(Double(12.0)) else { return 0 }
			return (m * n).rounded(toPlaces: 2)
		}

		var calculateTotalFuelCost: Double {
			guard let m = Double(monthlyGasExpense),
				  let n = Optional(Double(12.0)) else { return 0 }
			return (m * n).rounded(toPlaces: 2)
		}
		
		var calculateTotalYearCost: Double {
			guard let m = Optional(calculateTotalLeaseCost),
				  let n = Optional(calculateTotalFuelCost) else { return 0 }
			return (m + n).rounded(toPlaces: 2)
		}
		
		// Month formating
		self.monthTotalCost = "Maand kost: \(calculateMonthCost) €"
		
		// Year formating
		self.yearlytotalLeaseCost = "Leasejaar bedrag: \(calculateTotalLeaseCost) €"
		self.yearlyTotalFullCost = "Bezine jaar bedrag: \(calculateTotalFuelCost) €"
		self.totalcost = "Totale jaar kost: \(calculateTotalYearCost) €"
	}
}


struct LeaseCarView_Previews: PreviewProvider {
	static var previews: some View {
		LeaseCarView()
	}
}
