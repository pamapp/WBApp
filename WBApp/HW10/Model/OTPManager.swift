//
//  OTPManager.swift
//  WBApp
//
//  Created by Alina Potapova on 10.07.2024.
//

import Foundation

struct OTPSequence: Sequence {
    private let startTime: Date
    private let generatedOTP: String
    
    let phoneNumber: String
    let validTime: TimeInterval
    
    init(phoneNumber: String, validTime: TimeInterval) {
        self.phoneNumber = phoneNumber
        self.validTime = validTime
        self.startTime = Date()
        self.generatedOTP = String(format: "%04d", arc4random_uniform(10000))

        print("Сгенерированный OTP для \(phoneNumber): \(generatedOTP)") // Для отладки
    }

    func makeIterator() -> OTPIterator {
        return OTPIterator(validTime: validTime, startTime: startTime, generatedOTP: generatedOTP)
    }
    
    func remainingTime() -> TimeInterval {
        let elapsedTime = Date().timeIntervalSince(startTime)
        return Swift.max(validTime - elapsedTime, 0)
    }
}

struct OTPIterator: IteratorProtocol {
    let validTime: TimeInterval
    let startTime: Date
    let generatedOTP: String

    mutating func next() -> String? {
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(startTime)
        
        return elapsedTime < validTime ? generatedOTP : nil
    }
}

struct OTPManager {
    private var otpSequences: [String: OTPSequence] = [:]
    private let otpValidityDuration: TimeInterval

    init(otpValidityDuration: TimeInterval) {
        self.otpValidityDuration = otpValidityDuration
    }

    mutating func generateOTP(forPhoneNumber phoneNumber: String) -> String {
        let otpSequence = OTPSequence(phoneNumber: phoneNumber, validTime: otpValidityDuration)
        otpSequences[phoneNumber] = otpSequence
        var iterator = otpSequence.makeIterator()
        return iterator.next()!
    }

    mutating func validateOTP(_ otp: String, forPhoneNumber phoneNumber: String) -> Bool {
        guard let otpSequence = otpSequences[phoneNumber] else {
            return false
        }
        var iterator = otpSequence.makeIterator()
        if let generatedOTP = iterator.next(), generatedOTP == otp {
            otpSequences.removeValue(forKey: phoneNumber)
            return true
        } else {
            return false
        }
    }
    
    func remainingTime(forPhoneNumber phoneNumber: String) -> TimeInterval? {
        return otpSequences[phoneNumber]?.remainingTime()
    }
}
