//: [Previous](@previous)

import Foundation

// Property Wrappers operate on properties

// Thank you, Captain Obvious 🦸🏻‍♂️

// Wouldn't it be cool to have the same mechanism for functions?

// Functions are first-class citizens in Swift!

// Functions can be stored
var increment: (Int) -> Int = { $0 + 1 }

// Functions can operate on other functions
[1, 2, 3].map({ $0 * $0 })

// Functions can return other functions
func buildIncrementor() -> (Int) -> Int {
    return { $0 + 1 }
}

// We can store a function in a property...
// ...so Property Wrappers can work with functions 🎉

// Let's begin with a simple use case

// This is our goal syntax
//struct Trigo {
//    @Cached static var cachedCos = { (x: Double) in cos(x) }
//}

@propertyWrapper
struct Cached<Input: Hashable, Output> {
    
    // 👩🏽‍💻👨🏼‍💻 Implement `struct Cached`
    private var functionWithCache: (Input) -> Output
    
    init(wrappedValue: @escaping (Input) -> Output) {
        self.functionWithCache = wrappedValue
    }
    
    var wrappedValue: (Input) -> (Output){
        get { return self.functionWithCache }
        set { self.functionWithCache = Cached.addCachingLogic(to: newValue)}
    }
    
    private static func addCachingLogic(to function: @escaping (Input)-> Output) -> (Input) -> Output{
        var cache: [Input: Output] = [:]
        return { (input: Input) -> Output in
            if let cacheOutput = cache[input]{
                return cacheOutput
            }else{
                let output = function(input)
                cache[input] = output
                return output
            }
        }
    }
}

struct Trigo {
    @Cached static var cachedCos = { (x: Double) in cos(x) }
}

Trigo.cachedCos(.pi * 2) // takes 48.85 µs

// value of cos for 2π is now cached

let cachedTrigo = Trigo.cachedCos(.pi * 2) // takes 0.13 µs
print(cachedTrigo)

// What's really cool is that through this wraper
// we are able to optimize our code, without
// degrading it's readability.

// (But never forget: premature optimizations are
// bad ideas 🙅🏻‍♂️)

//: [Next](@next)
