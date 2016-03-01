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
