//: Playground - noun: a place where people can play

import UIKit

protocol StackType {
    typealias Element

    mutating func push(e: Element)

    mutating func pop() -> Element?
}

extension Array: StackType {
    mutating func push(e: Element) {
        self.append(e)
    }

    mutating func pop() -> Element? {
        guard !isEmpty else { return nil}
        return removeLast()
    }
}