//
//  SpendingBudget.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
/// Represents the user's planned spending limit until their next payday.
///
/// Business Rules:
/// The spending limit must be greater than zero.
/// The payday must be a future date.

import Foundation
struct SpendingBudget: Codable{
    let spendingLimit: Double
    let payday: Date
}
