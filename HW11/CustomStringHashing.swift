//
//  CustomStringHashing.swift
//  WBApp
//
//  Created by Alina Potapova on 12.07.2024.
//

import Foundation

// MARK: - Собственная функция для получения хеша строки

func customStringHash(for string: String) -> Int {
    var hashValue = 0
    
    // Проход по символам строки
    for char in string {
        
        // Получаем ASCII код символа
        let charValue = Int(char.asciiValue ?? 0)
        
        // Простая хеш-функция: (hash * 31 + charValue)
        // Использование простого числа 31 дает лучшее распределение ключей и меньшее количество коллизий. 31 можно легко умножить, используя битовые операции: (hash * 31) можно вычислить как (hash << 5) - hash, что эффективно с точки зрения производительности.
        hashValue = (hashValue &* 31) &+ charValue
    }
    
    return hashValue
}


// MARK: - Демонстрации примера

let customHashValue = customStringHash(for: exampleString)

//print("Custom hash value for '\(exampleString)': \(customHashValue)")
