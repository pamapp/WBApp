////
////  DictionaryOperations.swift
////  WBApp
////
////  Created by Alina Potapova on 12.07.2024.
////
//
//import Foundation
//
//// MARK: - Операции над словарем
//
//// 1. Создание словаря с названиями городов и их населением
//
//var cityPopulations = [
//    "Москва": 13149803,
//    "Санкт-Петербург": 5597763,
//    "Сургут": 420000,
//    "Елец": 100000,
//    "Нижний Новгород": 1214765
//]
//
//print("Dictionary: \(cityPopulations)")
//
//// 2. Добавление нескольких пар ключ-значение
//
//cityPopulations["Сочи"] = 466078
//cityPopulations["Тобольск"] = 103175
//
//print("\nDictionary after insertion (Сочи, Тобольск): \(cityPopulations)")
//
//// 3. Удаление одной пары ключ-значение
//
//cityPopulations.removeValue(forKey: "Нижний Новгород")
//
//print("\nDictionary after deletion (Нижний Новгород): \(cityPopulations)")
//
//// 4. Обновление значения для одного из ключей
//
//cityPopulations["Елец"] = 112200
//
//print("\nDictionary after updating the value for one of the keys (Елец): \(cityPopulations)")
//
//// 5. Получение значения для одного из ключей
//
//if let population = cityPopulations["Санкт-Петербург"] {
//    print("\nPopulation of Saint-Petersburg: \(population)")
//} else {
//    print("\nSaint-Petersburg no found in dictionary.")
//}
