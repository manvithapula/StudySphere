//
//  StreakManager.swift
//  studysphere
//
//  Created by admin64 on 14/11/24.
//


import Foundation

class StreakManager {
    static let shared = StreakManager()
    private let lastOpenKey = "lastOpenDate"
    private let streakCountKey = "streakCount"
    
    // Load the current streak count from UserDefaults
    var currentStreak: Int {
        return UserDefaults.standard.integer(forKey: streakCountKey)
    }
    
    // Update the streak based on the last open date
    func updateStreak() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let lastOpen = UserDefaults.standard.object(forKey: lastOpenKey) as? Date {
            let daysDifference = Calendar.current.dateComponents([.day], from: lastOpen, to: today).day ?? 0
            
            if daysDifference == 1 {
                incrementStreak() // Increment streak if last open was yesterday
            } else if daysDifference > 1 {
                resetStreak() // Reset streak if last open was more than one day ago
            }
        } else {
            resetStreak() // Initialize streak on first launch
        }
        
        // Update last open date to today
        UserDefaults.standard.set(today, forKey: lastOpenKey)
    }
    
    // Increment the streak count
    private func incrementStreak() {
        let newStreak = currentStreak + 1
        UserDefaults.standard.set(newStreak, forKey: streakCountKey)
    }
    
    // Reset the streak count to 1
    private func resetStreak() {
        UserDefaults.standard.set(1, forKey: streakCountKey)
    }
}
