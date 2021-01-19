//: [Previous](@previous)

import Foundation
import UIKit
import SwiftUI
import PlaygroundSupport

// In SwiftUI, @Environment allows us to
// retrieve external dependencies

class User: ObservableObject {
    @Published var name: String = "John"
}

struct ContentView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

var user = User()
let vc = UIHostingController(rootView: ContentView().environmentObject(user))

PlaygroundPage.current.liveView = vc

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    user.name = "Jane"
}

// To understand how such a mechanism is possible,
// we'll try and implement our own @Environment-like
// mechanism

struct Locator {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct Locator`
    static var sharedInstances: [ObjectIdentifier: Any] = [:]
    
    static func register<T>(instance: T){
        self.sharedInstances[ObjectIdentifier(T.self)] = instance
    }
    
    static func locate<T>(_ type: T.Type) -> T{
        let key = ObjectIdentifier(type)
        
        return self.sharedInstances[key]! as! T
    }
}

@propertyWrapper
struct Locatable<Value> {
    // 👩🏽‍💻👨🏼‍💻 Implement `struct Locatable`
    var wrappedValue: Value {
        get {
            return Locator.locate(Value.self)
        }
    }
    
}

// Let's try it out!

class Service {
    func action() {
        print("I'm performing a service 😊")
    }
}

Locator.register(instance: Service())

let service = Locator.locate(Service.self)

service.action()

class MyController {
    @Locatable var service: Service
    
    func work() {
        self.service.action()
    }
}

let controller = MyController()

controller.work()

//: [Next](@next)
