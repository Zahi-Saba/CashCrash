//
//  Expense.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
/// Represents a single expense recorded by the user.
///
/// Business Rules:
/// The expense amount must be greater than zero.
/// The expense name cannot be empty.
/// The expense category cannot be empty.
/// An expense must have an amount greater than zero.
import Foundation
struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let category: String
    let date: Date
}
