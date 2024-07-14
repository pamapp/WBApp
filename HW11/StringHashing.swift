//
//  StringHashing.swift
//  WBApp
//
//  Created by Alina Potapova on 12.07.2024.
//

import Foundation

// MARK: - Функция для получения хеша строки с использованием встроенной функции hash()

func getStringHash(for string: String) -> Int {
    return string.hash
}


// MARK: - Демонстрации примера

let exampleString = "Hello, Swift!"
let hashValue = getStringHash(for: exampleString)

//print("Hash value for '\(exampleString)': \(hashValue)")
