//
//  MainView.swift
//  Brutto-Netto-Calculator
//
//  Created by Kurt De Jonghe on 26/01/2023.
//

import SwiftUI

struct MainView: View {
    @State private var textColor =  Color.white
    
    var body: some View {
            
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "eurosign.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .center)
							.foregroundColor(btn.buttonColor)
							.padding(.top, 140)
                    }.padding()
                    
                    Spacer()
                    
                    VStack(spacing: 40.0) {
                        
                        NavigationLink {
                            EmployedView()
                        } label: {
                            Text("Loontrekkend")
                        }
                        .frame(width: 200)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding()
						.background(btn.buttonColor)
                        .cornerRadius(40)
                        .foregroundColor(textColor)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
								.stroke(btn.buttonColor, lineWidth: 5)
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
						.background(btn.buttonColor)
                        .cornerRadius(40)
                        .foregroundColor(textColor)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
								.stroke(btn.buttonColor, lineWidth: 5)
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
						.background(btn.buttonColor)
						.cornerRadius(40)
						.foregroundColor(textColor)
						.padding(10)
						.overlay(
							RoundedRectangle(cornerRadius: 40)
								.stroke(btn.buttonColor, lineWidth: 5)
						)
						
						NavigationLink {
							LeaseCarView()
						} label: {
							Text("Leasewagen")
						}
						.frame(width: 200)
						.fontWeight(.bold)
						.font(.body)
						.padding()
						.background(btn.buttonColor)
						.cornerRadius(40)
						.foregroundColor(textColor)
						.padding(10)
						.overlay(
							RoundedRectangle(cornerRadius: 40)
								.stroke(btn.buttonColor, lineWidth: 5)
						)
                        
                        NavigationLink {
                            InformationView()
                        } label: {
                            Text("Informatie")
                        }
                        .frame(width: 200)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding()
						.background(btn.buttonColor)
                        .cornerRadius(40)
                        .foregroundColor(textColor)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
								.stroke(btn.buttonColor, lineWidth: 5)
                        )
                        
                        Spacer()
                    }
                    
                    /// footer section
					VStack(spacing: 30) {
                        Text("®Created by KDJ - Projects")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                            .fontWeight(.bold)
							.padding(.bottom, 150)
							.padding(.top, -30)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
//            .preferredColorScheme(.dark)
    }
}
