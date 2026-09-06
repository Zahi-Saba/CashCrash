//
//Dashboardview.swift
//  CashCrash
//
//  Created by Zahi Saba on 6/9/2026.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var viewModel: CashCrashViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Cash Crash")
                    .font(.largeTitle)
                    .bold()
                
                Text("Total Spent")
                    .font(.headline)
                
                Text("$\(viewModel.totalSpent, specifier: "%.2f")")
                    .font(.title)
                
                if let budget = viewModel.budget {
                    Text("Spending Limit: $\(budget.spendingLimit, specifier: "%.2f")")
                } else {
                    Text("No spending budget set yet.")
                }
                
                Text(viewModel.spendingAdvice)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NavigationLink("Record Expense") {
                    Text("Record Expense Screen")
                }
                
                NavigationLink("Set Spending Budget") {
                    Text("Budget Screen")
                }
                
                NavigationLink("Payday Forecast") {
                    Text("Payday Forecast Screen")
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
