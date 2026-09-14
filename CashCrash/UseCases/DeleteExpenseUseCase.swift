//
//  DeleteExpenseUseCase.swift
//  CashCrash
//
//  Created by Zahi Saba on 13/9/2026.
//

import Foundation
enum DeleteExpenseError: LocalizedError {
    case expenseNotFound
    
    var errorDescription: String? {
        switch self {
        case .expenseNotFound:
            return "The expense could not be found."
        }
    }
}

/// Deletes an existing expense from the user's recorded expenses.
struct DeleteExpenseUseCase {
    
    func execute(
        expenses: [Expense],
        expense: Expense
    ) throws -> [Expense] {
        
        var updatedExpenses = expenses
        
        for index in updatedExpenses.indices {
            if updatedExpenses[index].id == expense.id {
                updatedExpenses.remove(at: index)
                return updatedExpenses
            }
        }
        
        throw DeleteExpenseError.expenseNotFound
    }
}
