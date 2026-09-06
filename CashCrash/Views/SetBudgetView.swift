//
//  SetBudgetView.swift
//  CashCrash
//
//  Created by Zahi Saba on 6/9/2026.
//

import Foundation
import SwiftUI

struct SetBudgetView: View {
    
    @ObservedObject var viewModel: CashCrashViewModel
    
    @State private var spendingLimit: String = ""
    @State private var payday: Date = Date()
    @State private var showConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Set Spending Budget")
                .font(.largeTitle)
                .bold()
            
            TextField("Spending limit", text: $spendingLimit)
                .textFieldStyle(.roundedBorder)
            
            DatePicker(
                "Next Payday",
                selection: $payday,
                displayedComponents: .date
            )
            
            Button("Set Budget") {
                
                if let limit = Double(spendingLimit) {
                    
                    viewModel.setBudget(
                        spendingLimit: limit,
                        payday: payday
                    )
                    
                    if viewModel.errorMessage == nil {
                        showConfirmation = true
                        spendingLimit = ""
                    }
                    
                } else {
                    viewModel.errorMessage = "Enter a valid spending limit."
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Budget")
        .alert("Budget Set", isPresented: $showConfirmation) {
            Button("OK") {
            }
        }
    }
}
