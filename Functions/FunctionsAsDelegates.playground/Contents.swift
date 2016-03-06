//: Playground - noun: a place where people can play

import UIKit

// 版本 V1
protocol Observable {
    mutating func register(observer: Observer)
}

protocol Observer {
    func receive(e: Any)
}

struct EventGenerator: Observable {
    var observers: [Observer] = []

    mutating func register(observer: Observer) {
        observers.append(observer)
    }

    func fireEvents(e: Any) {
        for observer in observers {
            observer.receive(e)
        }
    }
}

struct EventReceiver: Observer {
    func receive(e: Any) {
        print("Received: \(e)")
    }
}

var generator = EventGenerator()
let receiver = EventReceiver()
generator.register(receiver)

generator.fireEvents("hi, are you ok?")


// 版本V2
//protocol ObserverType {
//    typealias Event
//    func receive(e: Event)
//}
//
//protocol ObservableType {
//    typealias Event
//    mutating func register<O: ObserverType where O.Event == Event>(observer: O)
//}
//
//
//struct StringEventGenerator: ObservableType {
//    typealias Event = String
//    var observers: [String -> ()] = []
//
//    mutating func register<O: ObserverType where O.Event == Event>(observer: O) {
//        observers.append {observer.receive($0)}
//    }
//
//    func fireEvents(e: String) {
//        for observer in observers {
//            observer(e)
//        }
//    }
//}
//
//struct StringEventReceiver: ObserverType {
//    func receive(e: String) {
//        print("Received: \(e)")
//    }
//}
//
//var g = StringEventGenerator()
//let r = StringEventReceiver()
//g.register(r)
//
//g.fireEvents("hi, indeian mi fan")

// 版本V3
protocol ObserverType {
    typealias Event
    func receive(e: Event)
}

protocol ObservableType {
    typealias Event
    // RemoveanyreferencetoObserverType,justregisterafunction
    mutating func register(observer: Event -> ())
}


struct StringEventGenerator: ObservableType {

    var observers: [String -> ()] = []

    mutating func register(observer: String -> ()) {
        observers.append(observer)
    }
    func fireEvents(e: String) {
        for observer in observers {
            observer(e)
        }
    }
}

struct StringEventReceiver {
    func receive(e: String) {
        print("Received: \(e)")
    }
}

var g = StringEventGenerator()
let r = StringEventReceiver()
g.register{print("Closure received \($0)")}

g.fireEvents("hi, indeian mi fan")

struct StringStoringReceiver {
    var str = ""
    mutating func receive(event: String) {
        str += str.isEmpty ? event: ", \(event)"
    }
}

var stringR = StringStoringReceiver()

g.register{stringR.receive($0)}
g.fireEvents("hi!")
g.fireEvents("1!")
g.fireEvents("2!")

stringR.str