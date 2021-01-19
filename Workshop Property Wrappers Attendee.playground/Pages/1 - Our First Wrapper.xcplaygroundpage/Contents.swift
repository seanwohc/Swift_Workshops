//: [Previous](@previous)

import Foundation

// We want to achieve the following syntax:

//struct Solution {
//    @Clamping(0...14) var pH: Double = 7.0
//}

@propertyWrapper
struct Clamping<Value: Comparable> {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct Clamping`
    var value: Value
    let range: ClosedRange<Value>
    
    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        self.value = wrappedValue
        self.range = range
    }
    
    var wrappedValue: Value{
        get { self.value }
        set { self.value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
    
    var projectedValue: Clamping<Value>{
        get{ return self }
    }
}

struct Solution {
    @Clamping(0...14) var pH: Double = 7.0
}

var solution = Solution(pH: 7.0)

solution.pH = -1
solution.pH // 0

// Let's take a look at how this "Compiler Magic" works!

// Whenever we write `solution.pH`, the compiler actually
// replaces it by `solution.pH.wrappedValue`.

// This is what makes Property Wrapper incredibly seamless
// to use!

// And because this happens at compile time, they have no minimum OS requirement 🎉

// If you need to access the Wrapper itself, you can do so by
// implementing the property `projectedValue`.

solution.$pH // is of type Clamping<Double>

// This was the most basic example for a wrapper: the wrapper
// stores data, and wraps it with a layer of business logic.

//: [Next](@next)
