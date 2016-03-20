//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

enum Optional<T> {
    case None
    case Some(T)
}

extension CollectionType where Generator.Element: Equatable {
    func indexOf(element: Generator.Element) -> Optional<Index> {
        for idx in self.indices where self[idx] == element {
            return .Some(idx)
        }

        return .None
    }
}