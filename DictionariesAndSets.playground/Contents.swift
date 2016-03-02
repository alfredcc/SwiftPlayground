//: Playground - noun: a place where people can play

import UIKit

let mySet: Set = [1,2,3,4,5,2,6]
extension Dictionary {
    mutating func merge<S:SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) {
            for (k,v) in other {
                self[k] = v
            }
    }
}

// creating a dictionary from a sequence of (Key, Value) pairs.
extension Dictionary {
    init<S: SequenceType
        where S.Generator.Element == (Key,Value)>(_ sequence: S) {
            self = [:]
            self.merge(sequence)
    }
}

extension Dictionary {
    func mapValues<NewValue>(transform:Value -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>(map({ (key, value) in
            return (key, transform(value))
        }))
    }
}

// Using Sets Inside Closures
extension SequenceType where Generator.Element: Hashable {
    func unique() -> [Generator.Element] {
        var seen: Set<Generator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}

// CollectionType -> SequenctType -> GeneratorType

// generate a list of Fibonacci
class FibsGenerator:GeneratorType {
    var state = (0, 1)
    func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0+state.1)
        return upcomingNumber
    }
}