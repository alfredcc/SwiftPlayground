//: Playground - noun: a place where people can play

import UIKit

// link http://ericasadun.com/2016/03/08/swift-queue-fun/

/// Wrapping an Array

public struct Queue<T>: ArrayLiteralConvertible {
    /// backing array store
    public private(set) var elements: Array<T> = []

    /// introduce a new element to the queue in O(1) time
    public mutating func push(value: T) { elements.append(value) } // O(1)

    /// remove the front of the queue in O(`count` time
    public mutating func pop() -> T { return elements.removeFirst() } // O(`count`)

    /// test whether the queue is empty
    public var isEmpty: Bool { return elements.isEmpty }

    /// queue size, computed property
    public var count: Int { return elements.count }

    /// offer `ArrayLiteralConvertible` support
    public init(arrayLiteral elements: T...) { self.elements = elements }
}

var q = Queue(arrayLiteral: [1, 2, 3])
q.elements = [4, 5]


while !q.isEmpty { q.pop() }