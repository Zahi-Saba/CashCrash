//
//  CashCrashViewModel.swift
//  CashCrash
//
//  Created by Zahi Saba on 6/9/2026.
//

import Foundation
import Combine

class CashCrashViewModel : ObservableObject{
    
    @Published var expenses : [Expense] = []
    @Published var budget: SpendingBudget?
    @Published var spendingAdvice: String = "Set a budget to see your spending advice."
        @Published var errorMessage: String?
    
    private let recordExpenseUseCase = RecordExpenseUseCase()
        private let budgetUseCase = SetSpendingBudgetUseCase()
        private let checkSpendingUseCase = CheckSpendingUseCase()
    
    var totalSpent: Double {
            var total = 0.0
            
            for expense in expenses {
                total += expense.amount
            }
            
            return total
        }
    func recordExpense(
        name: String,
        amount: Double,
        category: String,
        date: Date
    ) {
        do {
            let expense = try recordExpenseUseCase.execute(
                name: name,
                amount: amount,
                category: category,
                date: date
            )
            
            expenses.append(expense)
            errorMessage = nil
            updateSpendingAdvice()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func setBudget(
        spendingLimit: Double,
        payday: Date
    ) {
        do {
            budget = try budgetUseCase.execute(
                spendingLimit: spendingLimit,
                payday: payday
            )
            
            errorMessage = nil
            updateSpendingAdvice()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func updateSpendingAdvice() {
        guard let budget = budget else {
            spendingAdvice = "Set a budget to see your spending advice."
            return
        }
        
        do {
            spendingAdvice = try checkSpendingUseCase.execute(
                totalSpent: totalSpent,
                budget: budget
            )
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
