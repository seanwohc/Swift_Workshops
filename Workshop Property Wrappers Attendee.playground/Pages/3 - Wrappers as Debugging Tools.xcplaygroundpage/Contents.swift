//: [Previous](@previous)

import Foundation

// When we debug our programs, we can inspect
// the current values of variables.

// However, in some cases the current value
// might not be enough information. And we
// might like to have an history of all the
// values that were set to a variable.

@propertyWrapper
struct Versioned<Value> {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct Versioned`
    private var currentValue: Value
    private(set) var history: [(Value, Date)] = []
    
    init(wrappedValue: Value) {
        self.currentValue = wrappedValue
    }
    
    var wrappedValue: Value {
        get { return self.currentValue }
        set {
            self.history.append((self.currentValue, Date()))
            self.currentValue = newValue
        }
    }
    
    var projectedValue: Self {
        get { return self }
    }
}

struct User {
    @Versioned var name: String = ""
}

var user = User()

user.name = "John"
user.name = "Jane"

user.$name.history



//: [Next](@next)
