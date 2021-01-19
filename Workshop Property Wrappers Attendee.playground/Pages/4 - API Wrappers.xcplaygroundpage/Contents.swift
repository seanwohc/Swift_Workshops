//: [Previous](@previous)

import Foundation

// The easiest way to persist data on iOS
// is through UserDefaults.

// UserDefaults is a key-value store. So having
// a nice type-safe wrapper arround it is pretty
// useful.

// There have been ways to do so since the beginning
// of Swift.

func showAppIntroduction() { }

extension UserDefaults {

    public enum Keys {
        static let hasSeenAppIntroduction = "has_seen_app_introduction"
    }

    /// Indicates whether or not the user has seen the on-boarding.
    var hasSeenAppIntroduction: Bool {
        set {
            set(newValue, forKey: Keys.hasSeenAppIntroduction)
        }
        get {
            return bool(forKey: Keys.hasSeenAppIntroduction)
        }
    }
}

if !UserDefaults.standard.hasSeenAppIntroduction {
    showAppIntroduction()
    UserDefaults.standard.hasSeenAppIntroduction = true
}


// 👍 Very clean call sites

// 👎 Requires boilerplate

// Perfect use case for a Property Wrapper!

@propertyWrapper
struct UserDefault<T> {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct UserDefault`
    
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return (UserDefaults.standard.object(forKey: self.key) as? T) ?? defaultValue
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: self.key)
        }
    }
    
    var projectedValue: Self{
        return self
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: self.key)
    }
}

struct UserDefaultsConfig {
    @UserDefault("has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}

UserDefaultsConfig.hasSeenAppIntroduction = false
UserDefaultsConfig.hasSeenAppIntroduction // false

UserDefaultsConfig.hasSeenAppIntroduction = true
UserDefaultsConfig.hasSeenAppIntroduction // true

UserDefaultsConfig.$hasSeenAppIntroduction.delete()
UserDefaultsConfig.hasSeenAppIntroduction

//: [Next](@next)
