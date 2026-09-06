//
//  RecordExpenseView.swift
//  CashCrash
//
//  Created by Zahi Saba on 6/9/2026.
//
import SwiftUI

struct RecordExpenseView: View {
    
    @ObservedObject var viewModel: CashCrashViewModel
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var date: Date = Date()
    @State private var showConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Record Expense")
                .font(.largeTitle)
                .bold()
            
            TextField("Expense name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
            
            TextField("Category", text: $category)
                .textFieldStyle(.roundedBorder)
            
            DatePicker(
                "Date",
                selection: $date,
                displayedComponents: .date
            )
            
            Button("Record Expense") {
                
                if let expenseAmount = Double(amount) {
                    
                    viewModel.recordExpense(
                        name: name,
                        amount: expenseAmount,
                        category: category,
                        date: date
                    )
                    
                    if viewModel.errorMessage == nil {
                        showConfirmation = true
                        
                        name = ""
                        amount = ""
                        category = ""
                    }
                    
                } else {
                    viewModel.errorMessage = "Enter a valid expense amount."
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Expense")
        .alert("Expense Added", isPresented: $showConfirmation) {
            Button("OK") {
            }
        }
    }
}
