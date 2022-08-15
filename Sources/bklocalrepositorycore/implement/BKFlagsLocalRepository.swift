//
//  File.swift
//  
//
//  Created by Javier Carapia on 15/08/22.
//

import Foundation

public struct BKFlagsLocalRepository {
    private static let showOnboardingKey = "show_onboarding_key"
    
    public static var showOnboarding: Bool {
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: showOnboardingKey)
        }
        get {
            let defaults = UserDefaults.standard
            return defaults.bool(forKey: showOnboardingKey)
        }
    }
}
