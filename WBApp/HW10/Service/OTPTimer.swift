//
//  OTPTimer.swift
//  WBApp
//
//  Created by Alina Potapova on 10.07.2024.
//

import Foundation

class OTPTimer: ObservableObject {
    @Published var remainingTime: TimeInterval = 0
    private var timer: Timer?

    func start(with initialTime: TimeInterval) {
        remainingTime = initialTime
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                DispatchQueue.main.async {
                    self.remainingTime -= 1
                }
            } else {
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }
    
    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
