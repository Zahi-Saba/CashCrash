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

                VStack(spacing: 8) {
                    Text("Total Spent")
                        .font(.headline)

                    Text("$\(viewModel.totalSpent, specifier: "%.2f")")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(15)
                
                if let budget = viewModel.budget {
                    VStack(spacing: 8) {
                        Text("Spending Limit")
                            .font(.headline)

                        Text("$\(budget.spendingLimit, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(15)
                } else {
                    Text("No spending budget set yet.")
                }
                
                Text(viewModel.spendingAdvice)
                    .multilineTextAlignment(.center)
                    .padding()
                if viewModel.expenses.isEmpty {
                    Text("No expenses recorded yet.")
                        .foregroundColor(.gray)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Recent Expenses")
                            .font(.headline)
                        
                        ScrollView {
                            VStack(spacing: 10) {
                                
                                ForEach(viewModel.expenses) { expense in
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            Text(expense.name)
                                                .bold()
                                            
                                            Text(expense.category)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Text("$\(expense.amount, specifier: "%.2f")")
                                            .bold()
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                        .frame(height: 180)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(15)
                }
                
                NavigationLink {
                    RecordExpenseView(viewModel: viewModel)
                } label: {
                    Text("Record Expense")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple.opacity(0.8))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(radius: 4)
                }
                NavigationLink {
                    SetBudgetView(viewModel: viewModel)
                } label: {
                    Text("Set Spending Budget")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple.opacity(0.8))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(radius: 4)
                }
                
                NavigationLink {
                    PaydayForecastView(viewModel: viewModel)
                } label: {
                    Text("Payday Forecast")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple.opacity(0.8))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(radius: 4)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
 
