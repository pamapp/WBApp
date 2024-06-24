//
//  Factory.swift
//  HW5
//
//  Created by Alina Potapova on 22.06.2024.
//

import Foundation

protocol FactoryMaterialProtocol: Hashable {
    var name: String { get set }
    var amount: Int { get set }
}

protocol FactoryProtocol {
    associatedtype Material: FactoryMaterialProtocol
    var name: String { get set }
    var workers: Set<Person> { get set }
    var materials: Set<Material> { get set }

    func hireWorker(_ worker: Person)
    func fireWorker(_ worker: Person)
}

class Passport {
    var series: Int
    var number: Int
    var dateOfIssue: Date
    weak var owner: Person?

    init(series: Int, number: Int, dateOfIssue: Date, owner: Person? = nil) {
        self.series = series
        self.number = number
        self.dateOfIssue = issueDate
        self.owner = owner
        
        print("✅ 🪪 Init <\(series) \(number)> passport\n")
    }

    deinit {
        print("🔥 🪪 Deinit <\(series) \(number)> passport\n")
    }
}

class Person: Hashable {
    let id = UUID()
    var fullName: String
    var age: Int
    var passport: Passport?

    init(fullName: String, age: Int, passport: Passport? = nil) {
        self.fullName = fullName
        self.age = age
        self.passport = passport
        
        print("✅ 🧍 Init <\(fullName)> person\n")
    }

    deinit {
        print("🔥 🧍 Deinit <\(fullName)> person\n")
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(fullName)
        hasher.combine(age)
    }
}

class BuildingMaterial: FactoryMaterialProtocol {
    let id = UUID()
    var name: String
    var amount: Int

    init(name: String, quantity: Int) {
        self.name = name
        self.amount = quantity
        
        print("✅ 🧱 Init <\(name)> building material\n")
    }

    deinit {
        print("🔥 🧱 Deinit <\(name)> building material\n")
    }

    static func == (lhs: BuildingMaterial, rhs: BuildingMaterial) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(amount)
    }
}

class BuildingFactory: FactoryProtocol {
    var name: String
    var workers: Set<Person>
    var materials: Set<BuildingMaterial>

    init(name: String, workers: Set<Person> = [], materials: Set<BuildingMaterial> = []) {
        self.name = name
        self.workers = workers
        self.materials = materials
        
        print("✅ 🏭 Init <\(name)> fabric\n")
    }

    deinit {
        print("🔥 🏭 Deinit <\(name)> fabric\n")
    }

    func hireWorker(_ worker: Person) {
        if workers.insert(worker).inserted {
            print("👷‍♂️ '\(name)': hire <\(worker.fullName)>\n")
        } else {
            print("⚠️ '\(name)': <\(worker.fullName)> already working\n")
        }
    }

    func fireWorker(_ worker: Person) {
        guard workers.remove(worker) != nil else {
            print("🤔 '\(name)': <\(worker.fullName)> doesn't work at the factory\n")
            return
        }
        
        print("👋 '\(name)': fire <\(worker.fullName)>\n")
    }

    func addMaterial(_ material: BuildingMaterial) {
        guard materials.insert(material).inserted else {
            print("⚠️ '\(name)': <\(material.name)> already in production\n")
            return
        }
        
        print("🧱 '\(name)': <\(material.name)> added to production\n")
    }

    func removeMaterial(_ material: BuildingMaterial) {
        guard materials.remove(material) != nil else {
            print("🤔 '\(name)': <\(material.name)> not produced in the factory\n")
            return
        }
        
        print("🧱 '\(name)': <\(material.name)> removed from production\n")
    }

    func printProducedMaterials() {
        let materialNames = materials.map { $0.name }.joined(separator: ", ")
        print("🏭 <\(name)>: materials <\(materialNames)>\n")
    }
    
    func printWorkers() {
        let workersNames = workers.map { $0.fullName }.joined(separator: ", ")
        print("🏭 <\(name)>: workers <\(workersNames)>\n")
    }
}

// MARK: - Демонстрация функционала

func runFactorySimulation() {
    let person1 = Person(fullName: "Petr Sushkov", age: 30)
    let person2 = Person(fullName: "Maria Vasilyeva", age: 25)
    
    let passport1 = Passport(series: 6423, number: 123456, dateOfIssue: Date(), owner: person1)
    let passport2 = Passport(series: 3567, number: 654321, dateOfIssue: Date(), owner: person2)
    
    person1.passport = passport1
    person2.passport = passport2
    
    let material1 = BuildingMaterial(name: "brick", quantity: 500)
    let material2 = BuildingMaterial(name: "cement", quantity: 1000)

    let factory = BuildingFactory(name: "ProBuild")
    
    print("----------------------------------------\n")
    factory.addMaterial(material1)
    factory.addMaterial(material2)
    
    factory.hireWorker(person1)
    factory.hireWorker(person2)

    factory.removeMaterial(material2)
    factory.fireWorker(person2)
    print("----------------------------------------\n")
}

runFactorySimulation()
