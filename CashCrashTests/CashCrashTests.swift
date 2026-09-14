//
//  CashCrashTests.swift
//  CashCrashTests
//
//  Created by Zahi Saba on 2/9/2026.
//

import Testing
import Foundation
@testable import CashCrash

struct CashCrashTests {
    
    let useCase = RecordExpenseUseCase()
    let budgetUseCase = SetSpendingBudgetUseCase()
    let checkSpendingUseCase = CheckSpendingUseCase()
    let editExpenseUseCase = EditExpenseUseCase()
    let deleteExpenseUseCase = try DeleteExpenseUseCase()

    @Test
    func recordExpenseSucceedsWithValidInput() throws {
        let expense = try useCase.execute(
            name: "Lunch",
            amount: 12.50,
            category: "Food",
            date: Date()
        )
        
        #expect(expense.name == "Lunch")
        #expect(expense.amount == 12.50)
        #expect(expense.category == "Food")
    }
    
    @Test
    func recordExpenseFailsWhenAmountIsZero() {
        #expect(throws: RecordExpenseError.invalidAmount) {
            try useCase.execute(
                name: "Lunch",
                amount: 0,
                category: "Food",
                date: Date()
            )
        }
    }
    
    @Test
    func recordExpenseFailsWhenNameIsEmpty() {
        #expect(throws: RecordExpenseError.missingName) {
            try useCase.execute(
                name: "",
                amount: 12.50,
                category: "Food",
                date: Date()
            )
        }
    }
    
    @Test
    func recordExpenseFailsWhenCategoryIsEmpty() {
        #expect(throws: RecordExpenseError.missingCategory) {
            try useCase.execute(
                name: "Lunch",
                amount: 12.50,
                category: "",
                date: Date()
            )
        }
    }
    
    @Test
    func setSpendingBudgetSucceedsWithValidInput() throws {
        let futurePayday = Date().addingTimeInterval(86400)
        
        let budget = try budgetUseCase.execute(
            spendingLimit: 500,
            payday: futurePayday
        )
        
        #expect(budget.spendingLimit == 500)
        #expect(budget.payday == futurePayday)
    }
    
    @Test
    func setSpendingBudgetFailsWhenLimitIsZero() {
        #expect(throws: SetSpendingBudgetError.invalidSpendingLimit) {
            try budgetUseCase.execute(
                spendingLimit: 0,
                payday: Date().addingTimeInterval(86400)
            )
        }
    }
    
    @Test
    func setSpendingBudgetFailsWhenPaydayIsInPast() {
        #expect(throws: SetSpendingBudgetError.invalidPayday) {
            try budgetUseCase.execute(
                spendingLimit: 500,
                payday: Date().addingTimeInterval(-86400)
            )
        }
    }
    @Test
    func checkSpendingShowsOnTrackWhenBelowWarningLevel() throws {
        let budget = SpendingBudget(
            spendingLimit: 500,
            payday: Date().addingTimeInterval(86400)
        )
        
        let advice = try checkSpendingUseCase.execute(
            totalSpent: 200,
            budget: budget
        )
        
        #expect(advice == "You're on track with your spending budget.")
    }
    @Test
    func checkSpendingShowsWarningAtEightyPercent() throws {
        let budget = SpendingBudget(
            spendingLimit: 500,
            payday: Date().addingTimeInterval(86400)
        )
        
        let advice = try checkSpendingUseCase.execute(
            totalSpent: 400,
            budget: budget
        )
        
        #expect(advice == "You're spending too fast. Try to slow down your spending.")
    }
    @Test
    func checkSpendingShowsOverBudgetWhenLimitIsReached() throws {
        let budget = SpendingBudget(
            spendingLimit: 500,
            payday: Date().addingTimeInterval(86400)
        )
        
        let advice = try checkSpendingUseCase.execute(
            totalSpent: 500,
            budget: budget
        )
        
        #expect(advice == "You have reached or exceeded your spending budget.")
    }
    @Test
    func checkSpendingFailsWhenTotalSpentIsNegative() {
        let budget = SpendingBudget(
            spendingLimit: 500,
            payday: Date().addingTimeInterval(86400)
        )
        
        #expect(throws: CheckSpendingError.invalidTotalSpent) {
            try checkSpendingUseCase.execute(
                totalSpent: -20,
                budget: budget
            )
        }
    }
    @Test
    func editExpenseUpdatesExistingExpense() throws {
        
        let expense = Expense(
            name: "Burger",
            amount: 120,
            category: "Food",
            date: Date()
        )
        
        let updatedExpense = try editExpenseUseCase.execute(
            expense: expense,
            name: "Burger",
            amount: 12,
            category: "Food",
            date: expense.date
        )
        
        #expect(updatedExpense.name == "Burger")
        #expect(updatedExpense.amount == 12)
        #expect(updatedExpense.category == "Food")
        #expect(updatedExpense.id == expense.id)
    }
    @Test
    func editExpenseFailsWhenAmountIsZero() {
        
        let expense = Expense(
            name: "Burger",
            amount: 12,
            category: "Food",
            date: Date()
        )
        
        #expect(throws: EditExpenseError.invalidAmount) {
            try editExpenseUseCase.execute(
                expense: expense,
                name: "Burger",
                amount: 0,
                category: "Food",
                date: expense.date
            )
        }
    }
    @Test
    func deleteExpenseRemovesExistingExpense() throws {
        
        let expense = Expense(
            name: "Coffee",
            amount: 5,
            category: "Food",
            date: Date()
        )
        
        let expenses = [expense]
        
        let updatedExpenses = try deleteExpenseUseCase.execute(
            expenses: expenses,
            expense: expense
        )
        
        #expect(updatedExpenses.isEmpty)
    }
    @Test
    func deleteExpenseFailsWhenExpenseIsNotFound() {
        
        let savedExpense = Expense(
            name: "Coffee",
            amount: 5,
            category: "Food",
            date: Date()
        )
        
        let differentExpense = Expense(
            name: "Lunch",
            amount: 15,
            category: "Food",
            date: Date()
        )
        
        let expenses = [savedExpense]
        
        #expect(throws: DeleteExpenseError.expenseNotFound) {
            try deleteExpenseUseCase.execute(
                expenses: expenses,
                expense: differentExpense
            )
        }
    }
}
