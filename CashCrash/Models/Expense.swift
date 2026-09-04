//
//  Expense.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
//

import Foundation
/// Represents a single expense recorded by the user.
/// An expense must have an amount greater than zero.
struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let category: String
    let date: Date
}
