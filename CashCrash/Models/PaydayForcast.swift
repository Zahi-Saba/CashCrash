//
//  PaydayForcast.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
//
/// Represents the user's spending position leading up to their next payday.
///
/// Business Rules:
/// The remaining budget is calculated from the spending limit minus total spent.
/// The spending advice reflects whether the user is on track, spending too fast,
/// or has reached or exceeded the spending budget.
import Foundation
struct PaydayForecast {
    let spendingLimit: Double
    let totalSpent: Double
    let remainingBudget: Double
    let payday: Date
    let spendingAdvice: String
}
