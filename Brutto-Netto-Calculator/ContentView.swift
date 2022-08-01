//
//  ContentView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 14/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var grossSalary = ""
    @State private var netSalary = ""
    @State private var daysWorked = ""
    @State private var dailyMealFee = ""
    @State private var dailyRoadFee = ""
    @State private var carwashCellPhoneExpense = ""
    @State private var netAmount = ""
    
    @State private var showAlert = false
    @State private var showNetSalary = false
    
    @State private var monthlyRszContribution = 0.1307
    @State private var monthlyWitholdingTax = 0.36811227424364431
    
    var body: some View {
        
        ZStack {
            Color(red: 10/250, green: 130/250, blue: 250/250)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "eurosign.square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .center)
                        .padding(.bottom, 40)
                }.padding()
                
                HStack {
                    Text("Brutto verloning:")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $grossSalary)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(.blue)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                HStack {
                    Text("Aantal gewerkte dagen:")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $daysWorked)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(.blue)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                HStack {
                    Text("Bedrag maaltijd vergoeding:")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $dailyMealFee)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(.blue)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                HStack {
                    Text("Bedrag baan vergoeding:")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $dailyRoadFee)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(.blue)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                HStack {
                    Text("Vergoeding overige onkosten:")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 280, height: 10, alignment: .leading)
                        .padding(.leading, 50)
                    
                    TextField("", text: $carwashCellPhoneExpense)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(.blue)
                        .frame(width: 65, height: 10, alignment: .center)
                        .padding(.trailing, 50)
                }.padding()
                
                Spacer()
                
                HStack(alignment: .center) {
                    
                    Button("Bereken".uppercased()) {
                        calculateNetSalary()
                    }
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 280, height: 30, alignment: .center)
                    .padding()
                    .background(
                        Capsule()
                            .stroke(Color.white, lineWidth: 2.0)
                    )
                    .alert("Geef waardes in", isPresented: $showAlert) {}
                    .alert(self.netAmount.uppercased(), isPresented: $showNetSalary) {}
                }
                Spacer()
            }
        }
    }
    
    private func calculateNetSalary() {
        
        @State var motnhlyTax = ""
        @State var netMeal = ""
        @State var netRoad = ""
        @State var netMonthFee = ""
        
        var calcNetTaxable: Double{
            guard let m = Double(grossSalary),
                  let n = Optional(monthlyRszContribution) else { return 0 }
            return m - (m * n)
        }

        var calcMonthlyTax: Double{
            guard let m = Optional(calcNetTaxable),
                  let n = Optional(monthlyWitholdingTax) else { return 0 }
            return m * n
        }

        var calcNetSalary: Double{
            guard let m = Optional(calcNetTaxable),
                  let n = Optional(calcMonthlyTax) else { return 0 }
            return m - n
        }
        
        var calcNetMealFees: Double{
            guard let m = Double(daysWorked),
                  let n = Double(dailyMealFee) else { return 0 }
            return m * n
        }
        
        var calcdailyRoadFees: Double{
            guard let m = Double(daysWorked),
                  let n = Double(dailyRoadFee) else { return 0 }
            return m * n
        }
        
        var calcMonthFees: Double {
            guard let m = Optional(1.0),
                  let n = Double(carwashCellPhoneExpense) else { return 0 }
            return m * n
        }
        
        var calcTotalNetSalary: Double {
            guard let net = Optional(calcNetSalary + calcNetMealFees + calcdailyRoadFees + calcMonthFees) else { return 0 }
            return net
        }
        
        let netMonthlyTax = String(format:"%.1f", calcMonthlyTax)
        motnhlyTax = "Maandelijks belasting: \n\(netMonthlyTax) €"
        
        let netDailyMealFees = String(format:"%.1f", calcNetMealFees)
        netMeal = "Maaltijd bedrag: \n\(netDailyMealFees) €"
        
        let netDailyRoadFees = String(format:"%.1f", calcdailyRoadFees)
        netRoad = "Baan vergoeding: \n\(netDailyRoadFees)"
        
        let netMonthlyFees = String(format:"%.1f", calcMonthFees)
        netMonthFee = "Vergoedingen: \n\(netMonthlyFees)"

        let netMonthSalary = String(format:"%.1f", calcNetSalary)
        self.netSalary = "Netto verloning: \n\(netMonthSalary) €"

        let netTotalSalary = String(format:"%.1f", calcTotalNetSalary)
        self.netAmount = "Netto loon + vergoedingen \n\(netTotalSalary) €"
        
        
        grossSalary == "" || daysWorked == "" || dailyMealFee == "" || dailyRoadFee == "" || carwashCellPhoneExpense == "" ? showAlert.toggle() : showNetSalary.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
