//
//  ClientServer.swift
//  WBApp
//
//  Created by Alina Potapova on 28.07.2024.
//

import Foundation
import Combine

// - MARK: Данные, которые будут обрабатываться

struct DataChunk {
    let id: Int
    let data: String
}

// - MARK: Протокол для задач обработки данных

protocol DataProcessor {
    func process(data: DataChunk) async throws -> String
}

// - MARK: Протокол для сервера

protocol ServerProtocol {
    func distributeTasks(dataChunks: [DataChunk]) async
    func getResults() async -> [String]
    func getErrors() async -> [Error]
}

// - MARK: Задача обработки данных

struct DataProcessingTask: DataProcessor {
    func process(data: DataChunk) async throws -> String {
        // Имитация ошибки для демонстрации
        if data.id == 2 || data.id == 1 { // Например, возникает ошибка для DataChunk с id 2
            throw ServerError.taskError("Simulated processing error for chunk \(data.id)")
        }
        // Имитируем успешную обработку данных
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
        return "Processed \(data.data)"
    }
    
    enum ServerError: Error {
        case taskError(String)
    }
}

// - MARK: Реализация клиента

actor Client {
    let id: Int
    let taskProcessor: DataProcessor

    init(id: Int, taskProcessor: DataProcessor) {
        self.id = id
        self.taskProcessor = taskProcessor
    }

    func process(data: DataChunk) async throws -> String {
        try await taskProcessor.process(data: data)
    }
}

// - MARK: Реализация сервера для распределения задач

actor Server: ServerProtocol {
    private var clients: [Client] = []
    private var results: [String] = []
    private var errors: [Error] = []
    
    func addClient(_ client: Client) {
        clients.append(client)
    }
    
    func distributeTasks(dataChunks: [DataChunk]) async {
        await withTaskGroup(of: (Int, Result<String, Error>).self) { group in
            for (index, dataChunk) in dataChunks.enumerated() {
                let client = clients[index % clients.count]
                group.addTask {
                    do {
                        let result = try await client.process(data: dataChunk)
                        return (index, .success(result))
                    } catch {
                        return (index, .failure(error))
                    }
                }
            }
            
            for await (index, result) in group {
                switch result {
                case .success(let output):
                    results.append("Client \(clients[index % clients.count].id) processed chunk \(index): \(output)")
                case .failure(let error):
                    errors.append(error)
                }
            }
        }
    }
    
    func getResults() -> [String] {
        return results
    }

    func getErrors() -> [Error] {
        return errors
    }
}

// - MARK: Имитация работы системы

func system() async {
    let server = Server()
    
    let clients = [
        Client(id: 1, taskProcessor: DataProcessingTask()),
        Client(id: 2, taskProcessor: DataProcessingTask()),
        Client(id: 3, taskProcessor: DataProcessingTask())
    ]
    
    for client in clients {
        await server.addClient(client)
    }
    
    // Имитируем данные для обработки
    
    let dataChunks: [DataChunk] = [
        DataChunk(id: 1, data: "Data1"),
        DataChunk(id: 2, data: "Data2"),
        DataChunk(id: 3, data: "Data3"),
        DataChunk(id: 4, data: "Data4"),
        DataChunk(id: 5, data: "Data5"),
        DataChunk(id: 6, data: "Data6"),
        DataChunk(id: 7, data: "Data7"),
        DataChunk(id: 8, data: "Data8")
    ]
    
    // Распределяем задачи
    
    await server.distributeTasks(dataChunks: dataChunks)
    
    // Получаем результаты и ошибки
    
    let results = await server.getResults()
    let errors = await server.getErrors()
    
    print("Results:")
    
    results.isEmpty ? print("-") : results.forEach { print($0) }
    
    print("\nErrors:")
    
    errors.isEmpty ? print("-") : errors.forEach { print($0) }
}

// - MARK: Имитация запуска системы

// Task {
//     await system()
// }
