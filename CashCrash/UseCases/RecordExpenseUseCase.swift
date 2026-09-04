//
//  RecordExpenseUseCase.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
//Records a new expense for the Cash Crash user.

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
