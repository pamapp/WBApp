//
//  SetOperations.swift
//  WBApp
//
//  Created by Alina Potapova on 12.07.2024.
//

import Foundation

// MARK: - Операции над множеством

// 1. Создание множества целых чисел

var numberSet: Set<Int> = [1, 2, 3, 4, 5]

print("Set: \(numberSet)")

// 2. Добавление элементов в множество

numberSet.insert(6)
numberSet.insert(7)

print("Set after insertion (6, 7): \(numberSet)")

// 3. Удаление одного элемента из множества

numberSet.remove(1)

print("Set after deletion (1): \(numberSet)")

// 4. Проверка существования элемента в множестве

let containsFive = numberSet.contains(5)

print("Set contains (5): \(containsFive)")

// 5. Создание второго множества для операций

let anotherSet: Set<Int> = [4, 5, 6, 8, 9]

print("\nAnother set: \(anotherSet)")

// 6. Операции объединения, пересечения и разности множеств

let unionSet = numberSet.union(anotherSet)
let intersectionSet = numberSet.intersection(anotherSet)
let differenceSet = numberSet.subtracting(anotherSet)

print("Union of sets: \(unionSet)")
print("Intersection of sets: \(intersectionSet)")
print("Difference of sets: \(differenceSet)")
