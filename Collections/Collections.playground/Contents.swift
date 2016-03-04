//: Playground - noun: a place where people can play

import UIKit

protocol QueueType {
    // The Type of elements held in self
    typealias Element
    // Enqueue `newElement` to `self`
    mutating func enqueue(newElement: Element)
    // Dequeue an element from `self`
    mutating func dequeue() -> Element?
}

let collection = [1,2,3,4,5,6]

for x in collection {
    print(x)
}

// iterateoverallbutthefirstelementofacollection
for x in collection.dropFirst() {
    print(x)
}

// iterate all but the last 5 of a collection
for x in collection.dropLast(2) {
    print(x)
}

// iterate all indices of a collection 遍历下标
for idx in collection.indices {
    print(idx)
}

// find the location of a specific element in collection
//if let idx = collection.indexOf(predicate: (Int) throws -> Bool)

// Implement A queue
struct Queue<Element>: QueueType {
    private var left: [Element]
    private var right: [Element]

    init() {
        left = []
        right = []
    }
    // Add an element to the back of the queue inO(1).
    mutating func enqueue(newElement: Element) {
        right.append(newElement)
    }

    // Removes front of the queue in amortized O(1)
    // Returns nil case of an empty queue.
    mutating func dequeue() -> Element? {
        guard !(left.isEmpty && right.isEmpty) else {
            return nil
        }
        if left.isEmpty {
            left = right.reverse()
            right.removeAll(keepCapacity: true)
        }
        return left.removeLast()
    }
}

// CollectionType
extension Queue: CollectionType {
    var startIndex: Int { return 0 }
    var endIndex: Int { return left.count + right.count }
    subscript(idx: Int ) -> Element {
        precondition((0..<endIndex).contains(idx), "Index out of bounds")
        if idx < left.endIndex{
            return left [left.count - idx.successor()]
        } else {
            return right[idx - left.count]
        }
    }
}

// ArrayLiteralConvertible
extension Queue:ArrayLiteralConvertible {
    init(arrayLiteral elements: Element...) {
        self.left = elements.reverse()
        self.right = []
    }
}

let queue: Queue = [2,4,8]

