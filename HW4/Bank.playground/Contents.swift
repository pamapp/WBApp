//
//  Bank.swift
//
//
//  Created by Alina Potapova on 15.06.2024.
//

import Foundation

// MARK: Структура для представления Счета

struct Account {
    let accountNumber: String
    private(set) var balance: Double
    
    //Метод для пополнение счета
    mutating func topUpBalance(with amount: Double) {
        guard amount >= 0 else {
            print("❌ Impossible to top up with a negative amount.")
            return
        }
        
        balance += amount
        print("🟢 📥 \(self.accountNumber): +\(amount)💲. Balance: 💲\(balance).")
    }
    
    //Метод для снятия средств
    mutating func withdrawFromBalance(with amount: Double) -> Bool {
        guard amount >= 0 else {
            print("❌ Impossible to withdraw for a negative amount.")
            return false
        }
        
        guard amount <= balance else {
            return false
        }
        
        balance -= amount
        print("🔻 📤 \(self.accountNumber): -\(amount)💲. Balance: 💲\(balance).")
        
        return true
    }
}


// MARK: Класс для представления Банка

final class Bank {
    var accounts: [String: Account] = [:]
    
    // Метод для добавления нового счета
    func addAccount(account: Account) {
        accounts[account.accountNumber] = account
    }
    
    // Метод для пополнения счета
    func topUpAccount(accountNumber: String, amount: Double) {
        guard var account = accounts[accountNumber] else {
            print("❌ Account \(accountNumber) not found.")
            return
        }
        
        account.topUpBalance(with: amount)
        accounts[accountNumber] = account
    }
    
    // Метод для снятия денег со счета
    func withdrawFromAccount(accountNumber: String, amount: Double) {
        guard var account = accounts[accountNumber] else {
            print("❌ Account \(accountNumber) not found.")
            return
        }
        
        guard account.withdrawFromBalance(with: amount) else {
            return
        }
        
        accounts[accountNumber] = account
    }
    
    // Метод для перевода средств между счетами
    func transfer(from: String, to: String, amount: Double) {
        guard var fromAccount = accounts[from], var toAccount = accounts[to] else {
            print("❌ Account not found.")
            return
        }
        print("📤 \(from) -> 📥 \(to): 💲\(amount)")
        print("\nTransactions:")
        
        guard fromAccount.withdrawFromBalance(with: amount) else {
            print("❌ \(from): Not enough funds for 💲\(amount). Balance: 💲\(fromAccount.balance)")
            return
        }
        
        toAccount.topUpBalance(with: amount)
        accounts[from] = fromAccount
        accounts[to] = toAccount
    }
    
    // Метод для печати состояния всех счетов
    func printAccounts() {
        let sortedAccounts = accounts.values.sorted { $0.accountNumber < $1.accountNumber }
        for account in sortedAccounts {
            print("🧾 Account: \(account.accountNumber), Balance: 💲\(account.balance)")
        }
    }
}



// MARK:  - Демонстрация функционала

let bank = Bank()

let account1: Account = .init(accountNumber: "123", balance: 1000.0)
let account2: Account = .init(accountNumber: "456", balance: 2000.0)
let account3: Account = .init(accountNumber: "789", balance: 3000.0)

bank.addAccount(account: account1)
bank.addAccount(account: account2)
bank.addAccount(account: account3)

// Список счетов

print("Accounts List:")
print("-----------------------------")
bank.printAccounts()

print("\n\n")

// Пополнение счета

print("Top up:")
print("--------------------------")

print("Before:")
bank.printAccounts()
print("")

bank.topUpAccount(accountNumber: "123", amount: 500.0)
bank.topUpAccount(accountNumber: "456", amount: 1000.0)
bank.topUpAccount(accountNumber: "789", amount: 5000.0)

print("\nAfter:")
bank.printAccounts()

print("\n\n")

// Снятие средств

print("Withdraw:")
print("--------------------------")

print("Before:")
bank.printAccounts()
print("")

bank.withdrawFromAccount(accountNumber: "123", amount: 500.0)
bank.withdrawFromAccount(accountNumber: "456", amount: 1000.0)
bank.withdrawFromAccount(accountNumber: "789", amount: 5000.0)

print("\nAfter:")
bank.printAccounts()

print("\n\n")

// Переводы между счетами

print("Transfers:")
print("--------------------")

print("Before transfer 1:")
bank.printAccounts()

print("\nTransfer 1:")
bank.transfer(from: "123", to: "789", amount: 300.0)

print("\nAfter transfer 1:")
bank.printAccounts()

print("\n.......................................")

print("\nBefore transfer 2:")
bank.printAccounts()

print("\nTransfer 2:")
bank.transfer(from: "789", to: "456", amount: 10000.0) // <-недостаточно средств

print("\nAfter transfer 2:")
bank.printAccounts()

print("\n.......................................")

print("\nBefore transfer 3:")
bank.printAccounts()

print("\nTransfer 3:")
bank.transfer(from: "789", to: "456", amount: 2000.0)

print("\nAfter transfer 3:")
bank.printAccounts()

print("\n")
