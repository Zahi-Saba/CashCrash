//
//  DeleteExpenseUseCase.swift
//  CashCrash
//
//  Created by Zahi Saba on 13/9/2026.
//

import Foundation

/// Deletes an existing expense from the user's recorded expenses.
struct DeleteExpenseUseCase {
    
    func execute(
        expenses: [Expense],
        expense: Expense
    ) -> [Expense] {
        
        var updatedExpenses = expenses
        
        for index in updatedExpenses.indices {
            if updatedExpenses[index].id == expense.id {
                updatedExpenses.remove(at: index)
                break
            }
        }
        
        return updatedExpenses
    }
}
