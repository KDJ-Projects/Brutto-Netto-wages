//
//  MainView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 26/01/2023.
//

import SwiftUI

struct MainView: View {
    @State private var textColor =  Color.white
    @State private var buttonColor = Color.blue
    
    var body: some View {
            
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "eurosign.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200, alignment: .center)
                            .foregroundColor(buttonColor)
                            .padding(.bottom, 40)
                    }.padding()
                    
                    Spacer()
                    
                    VStack(spacing: 50.0) {
                        
                        NavigationLink {
                            EmployedView()
                        } label: {
                            Text("Loontrekkend")
                        }
                        .frame(width: 200)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(40)
                        .foregroundColor(textColor)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(buttonColor, lineWidth: 5)
                        )
                        
                        NavigationLink {
                            FreelanceView()
                        } label: {
                            Text("Freelancer maand")
                        }
                        .frame(width: 200)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(40)
                        .foregroundColor(textColor)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(buttonColor, lineWidth: 5)
                        )
						
						NavigationLink {
							HourlyRateView()
						} label: {
							Text("Freelance uurtarief")
						}
						.frame(width: 200)
						.fontWeight(.bold)
						.font(.body)
						.padding()
						.background(buttonColor)
						.cornerRadius(40)
						.foregroundColor(textColor)
						.padding(10)
						.overlay(
							RoundedRectangle(cornerRadius: 40)
								.stroke(buttonColor, lineWidth: 5)
						)
                        
                        NavigationLink {
                            HolidayView()
                        } label: {
                            Text("Jaarinfo")
                        }
                        .frame(width: 200)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(40)
                        .foregroundColor(textColor)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(buttonColor, lineWidth: 5)
                        )
                        
                        Spacer()
                    }
                    
                    /// footer section
                    VStack {
                        Text("®Created by KDJ | 2023")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
//            .preferredColorScheme(.light)
    }
}
