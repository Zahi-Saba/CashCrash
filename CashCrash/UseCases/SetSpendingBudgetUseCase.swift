//
//  SetSpendingBudgetUseCase.swift
//  CashCrash
//
//  Created by Zahi Saba on 4/9/2026.
import Foundation

enum SetSpendingBudgetError: LocalizedError {
    case invalidSpendingLimit
    case invalidPayday
    
    var errorDescription: String? {
        switch self {
        case .invalidSpendingLimit:
            return "Enter a spending limit greater than $0."
            
        case .invalidPayday:
            return "Choose a future payday before setting your spending budget."
        }
    }
}

/// Creates a spending budget for the user until their next payday.
///
/// Business Rules:
/// The spending limit must be greater than zero.
/// The payday must be a future date.
struct SetSpendingBudgetUseCase {
    
    func execute(
        spendingLimit: Double,
        payday: Date
    ) throws -> SpendingBudget {
        
        if spendingLimit <= 0 {
            throw SetSpendingBudgetError.invalidSpendingLimit
        }
        
        if payday <= Date() {
            throw SetSpendingBudgetError.invalidPayday
        }
        
        return SpendingBudget(
            spendingLimit: spendingLimit,
            payday: payday
        )
    }
}
