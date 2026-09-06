//
//  PaydayForecastView.swift
//  CashCrash
//
//  Created by Zahi Saba on 6/9/2026.
//

import SwiftUI

struct PaydayForecastView: View {
    
    @ObservedObject var viewModel: CashCrashViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Payday Forecast")
                .font(.largeTitle)
                .bold()
            
            if let forecast = viewModel.paydayForecast {
                
                Text("Spending Limit")
                    .font(.headline)
                
                Text("$\(forecast.spendingLimit, specifier: "%.2f")")
                    .font(.title)
                
                Text("Total Spent")
                    .font(.headline)
                
                Text("$\(forecast.totalSpent, specifier: "%.2f")")
                    .font(.title2)
                
                Text("Remaining Budget")
                    .font(.headline)
                
                Text("$\(forecast.remainingBudget, specifier: "%.2f")")
                    .font(.title2)
                
                Text("Next Payday")
                    .font(.headline)
                
                Text(forecast.payday, style: .date)
                
                Text(forecast.spendingAdvice)
                    .multilineTextAlignment(.center)
                    .padding()
                
            } else {
                
                Text("Set a spending budget first to view your payday forecast.")
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Forecast")
    }
}
