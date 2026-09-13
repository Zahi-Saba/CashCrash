//
//  CashCrashViewModel.swift
//  CashCrash
//
//  Created by Zahi Saba on 6/9/2026.
//

import Foundation
import Combine

class CashCrashViewModel : ObservableObject{
    
    @Published var expenses : [Expense] = []
    @Published var budget: SpendingBudget?
    @Published var spendingAdvice: String = "Set a budget to see your spending advice."
        @Published var errorMessage: String?
    
    private let recordExpenseUseCase = RecordExpenseUseCase()
        private let budgetUseCase = SetSpendingBudgetUseCase()
        private let checkSpendingUseCase = CheckSpendingUseCase()
    private let editExpenseUseCase = EditExpenseUseCase()
    private let deleteExpenseUseCase = DeleteExpenseUseCase()
    private let expensesKey = "SavedExpenses"
    private let budgetKey = "SavedBudget"
    init() {
        loadData()
    }
    var totalSpent: Double {
            var total = 0.0
            
            for expense in expenses {
                total += expense.amount
            }
            
            return total
        }
    var paydayForecast: PaydayForecast? {
        
        guard let budget = budget else {
            return nil
        }
        
        let remainingBudget = budget.spendingLimit - totalSpent
        
        return PaydayForecast(
            spendingLimit: budget.spendingLimit,
            totalSpent: totalSpent,
            remainingBudget: remainingBudget,
            payday: budget.payday,
            spendingAdvice: spendingAdvice
        )
    }
    func recordExpense(
        name: String,
        amount: Double,
        category: String,
        date: Date
    ) {
        do {
            let expense = try recordExpenseUseCase.execute(
                name: name,
                amount: amount,
                category: category,
                date: date
            )
            
            expenses.append(expense)
            errorMessage = nil
            saveExpenses()
            updateSpendingAdvice()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func setBudget(
        spendingLimit: Double,
        payday: Date
    ) {
        do {
            budget = try budgetUseCase.execute(
                spendingLimit: spendingLimit,
                payday: payday
            )
            errorMessage = nil
            saveBudget()
            updateSpendingAdvice()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func updateSpendingAdvice() {
        guard let budget = budget else {
            spendingAdvice = "Set a budget to see your spending advice."
            return
        }
        
        do {
            spendingAdvice = try checkSpendingUseCase.execute(
                totalSpent: totalSpent,
                budget: budget
            )
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func editExpense(
        expense: Expense,
        name: String,
        amount: Double,
        category: String,
        date: Date
    ) {
        do {
            let updatedExpense = try editExpenseUseCase.execute(
                expense: expense,
                name: name,
                amount: amount,
                category: category,
                date: date
            )
            
            for index in expenses.indices {
                if expenses[index].id == updatedExpense.id {
                    expenses[index] = updatedExpense
                }
            }
            errorMessage = nil
            saveExpenses()
            updateSpendingAdvice()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func deleteExpense(expense: Expense) {
        
        expenses = deleteExpenseUseCase.execute(
            expenses: expenses,
            expense: expense
        )
        errorMessage = nil
        saveExpenses()
        updateSpendingAdvice()
    }
    private func saveExpenses() {
        do {
            let data = try JSONEncoder().encode(expenses)
            UserDefaults.standard.set(data, forKey: expensesKey)
        } catch {
            errorMessage = "Unable to save expenses."
        }
    }
    private func saveBudget() {
        do {
            let data = try JSONEncoder().encode(budget)
            UserDefaults.standard.set(data, forKey: budgetKey)
        } catch {
            errorMessage = "Unable to save your spending budget."
        }
    }
    private func loadData() {
        
        if let expenseData = UserDefaults.standard.data(forKey: expensesKey) {
            do {
                expenses = try JSONDecoder().decode(
                    [Expense].self,
                    from: expenseData
                )
            } catch {
                errorMessage = "Unable to load saved expenses."
            }
        }
        
        if let budgetData = UserDefaults.standard.data(forKey: budgetKey) {
            do {
                budget = try JSONDecoder().decode(
                    SpendingBudget.self,
                    from: budgetData
                )
            } catch {
                errorMessage = "Unable to load your saved budget."
            }
        }
        
        updateSpendingAdvice()
    }
}
