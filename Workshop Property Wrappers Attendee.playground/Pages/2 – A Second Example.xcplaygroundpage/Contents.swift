//: [Previous](@previous)

import Foundation

// When we deal with standardized formats,
// lingering whitespaces can be very tricky:

URL(string: " https://nshipster.com") // nil (!)

ISO8601DateFormatter().date(from: " 2019-06-24") // nil (!)

// So let's introduce a Property Wrapper
// that will trim such characters!

@propertyWrapper
struct Trimmed {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct Trimmed`
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { self.value }
        set { self.value = newValue.trimmingCharacters(in: .whitespacesAndNewlines)}
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

struct Post {
    @Trimmed var title: String
    @Trimmed var body: String
}

var quine = Post(title: "  Swift Property Wrappers  ", body: "...")
quine.title // "Swift Property Wrappers" (no leading or trailing spaces!)
quine.title = "      @propertyWrapper     "
quine.title // "@propertyWrapper" (still no leading or trailing spaces!)
//: [Next](@next)


