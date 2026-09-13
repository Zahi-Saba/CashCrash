//
//  EditExpenseUseCase.swift
//  CashCrash
//
//  Created by Zahi Saba on 13/9/2026.
//

import Foundation
import Foundation

enum EditExpenseError: LocalizedError {
    case invalidAmount
    case missingName
    case missingCategory
    
    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Enter an expense amount greater than $0."
            
        case .missingName:
            return "Enter a name for this expense."
            
        case .missingCategory:
            return "Choose a spending category for this expense."
        }
    }
}

/// Updates an existing expense recorded by the Cash Crash user.
///
/// Business Rules:
/// The expense amount must be greater than zero.
/// The expense name cannot be empty.
/// The expense category cannot be empty.
struct EditExpenseUseCase {
    
    func execute(
        expense: Expense,
        name: String,
        amount: Double,
        category: String,
        date: Date
    ) throws -> Expense {
        
        if amount <= 0 {
            throw EditExpenseError.invalidAmount
        }
        
        if name.isEmpty {
            throw EditExpenseError.missingName
        }
        
        if category.isEmpty {
            throw EditExpenseError.missingCategory
        }
        
        var updatedExpense = expense
        
        updatedExpense.name = name
        updatedExpense.amount = amount
        updatedExpense.category = category
        updatedExpense.date = date
        
        return updatedExpense
    }
}
