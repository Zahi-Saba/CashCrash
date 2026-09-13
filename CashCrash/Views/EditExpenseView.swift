//
//  EditExpenseView.swift
//  CashCrash
//
//  Created by Zahi Saba on 13/9/2026.
//

import Foundation
import SwiftUI

struct EditExpenseView: View {
    
    @ObservedObject var viewModel: CashCrashViewModel
    
    let expense: Expense
    
    @State private var name: String
    @State private var amount: String
    @State private var category: String
    @State private var date: Date
    @State private var showConfirmation = false
    @Environment(\.dismiss) private var dismiss
    
    init(
        viewModel: CashCrashViewModel,
        expense: Expense
    ) {
        self.viewModel = viewModel
        self.expense = expense
        
        _name = State(initialValue: expense.name)
        _amount = State(initialValue: String(expense.amount))
        _category = State(initialValue: expense.category)
        _date = State(initialValue: expense.date)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Edit Expense")
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
            
            Button("Save Changes") {
                
                if let expenseAmount = Double(amount) {
                    
                    viewModel.editExpense(
                        expense: expense,
                        name: name,
                        amount: expenseAmount,
                        category: category,
                        date: date
                    )
                    
                    if viewModel.errorMessage == nil {
                        showConfirmation = true
                    }
                    
                } else {
                    viewModel.errorMessage = "Enter a valid expense amount."
                }
            }
            Button("Delete Expense") {
                viewModel.deleteExpense(expense: expense)
                dismiss()
            }
            .foregroundColor(.red)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Expense")
        .alert("Expense Updated", isPresented: $showConfirmation) {
            Button("OK") {
            }
        }
    }
}
