//: [Previous](@previous)

import UIKit

// The idea of decorating properties with attributes is
// not new to Swift.

// Several attributes have already been available for
// quite a while.

class MyViewController: UIViewController {
    
    lazy var label: UILabel = UILabel()
    
    @NSCopying var string: NSAttributedString = NSAttributedString()
}

// These attributes perform their purpose well, but
// they have an inherent limit: they are hardcoded
// into the compiler.

// Consequently, as developers, we couldn't define
// our own attributes.

// The Swift team saw this limitation, and a pitch
// was made for a mechanism called "Property Wrappers".

// Let's take a look at the motivation behind this pitch:
// https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md

// There are property implementation patterns that
// come up repeatedly.

// Rather than hardcode a fixed set of patterns into
// the compiler (as we have done for lazy and @NSCopying),
// we should provide a general "property wrapper"
// mechanism to allow these patterns to be defined as libraries.

//: [Next](@next)
