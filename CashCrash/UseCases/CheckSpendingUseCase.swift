//
//  CheckSpending.swift
//  CashCrash
//
//  Created by Zahi Saba on 4/9/2026.
// Checks how the user's spending compares with their spending budget.

import Foundation
enum CheckSpendingError: LocalizedError {
case invalidTotalSpent

var errorDescription: String? {
    switch self {
    case .invalidTotalSpent:
        return "Your total spending cannot be below $0."
    }
}
}

struct CheckSpendingUseCase {
    func execute(
            totalSpent: Double,
            budget: SpendingBudget
        ) throws -> String {
            
            if totalSpent < 0 {
                throw CheckSpendingError.invalidTotalSpent
            }
            
            if totalSpent >= budget.spendingLimit {
                return "You have reached or exceeded your spending budget."
            }
            
            if totalSpent >= budget.spendingLimit * 0.8 {
                return "You're spending too fast. Try to slow down your spending."
            }
            
            return "You're on track with your spending budget."
        }

}
