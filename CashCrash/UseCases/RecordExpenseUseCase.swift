//
//  RecordExpenseUseCase.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
import Foundation

enum RecordExpenseError: LocalizedError {
    case invalidAmount
    case missingName
    case missingCategory
    
    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Enter an expense amount greater than $0."
            
        case .missingName:
            return "Enter a name for this expense so you can identify what you spent money on."
            
        case .missingCategory:
            return "Choose a spending category before recording this expense."
        }
    }
}

/// Records a new expense for the Cash Crash user.
///
/// Business Rules:
/// The expense amount must be greater than zero.
/// The expense name cannot be empty.
/// The expense category cannot be empty.
struct RecordExpenseUseCase {
    
    func execute(
        name: String,
        amount: Double,
        category: String,
        date: Date
    ) throws -> Expense {
        
        if amount <= 0 {
            throw RecordExpenseError.invalidAmount
        }
        
        if name.isEmpty {
            throw RecordExpenseError.missingName
        }
        
        if category.isEmpty {
            throw RecordExpenseError.missingCategory
        }
        
        return Expense(
            name: name,
            amount: amount,
            category: category,
            date: date
        )
    }
}
