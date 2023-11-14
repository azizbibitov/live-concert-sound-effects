//
//  PersistenceManager.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 26.05.2022.
//

import Foundation

class PersistenceManager {
    
    enum Keys {
        static let launches = "Launches"
    }
    
    static var shared = PersistenceManager()
    private var defaults = UserDefaults.standard
    
    func fetchLaunches() -> Int {
        return defaults.integer(forKey: Keys.launches)
    }
    
    func shouldRequestReview() -> Bool {
        var launches = fetchLaunches()
        launches += 1
        defaults.set(launches, forKey: Keys.launches)
        if launches % 3 == 0 { return true }
        return false
    }
    
}
