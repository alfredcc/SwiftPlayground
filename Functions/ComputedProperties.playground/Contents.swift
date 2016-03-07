//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct File {
    let path: String

//    func computeSize() -> Int? {
//        let fm = NSFileManager.defaultManager()
//        guard
//            let dict = try? fm.attributesOfItemAtPath(self.path),
//            let size = dict["NSFileSize"] as? Int
//            else { return nil }
//        return size
//    }
    lazy var size: Int? = {
        let fm = NSFileManager.defaultManager()
        guard let dict = try? fm.attributesOfItemAtPath(self.path),
            let size = dict["NSFileSize"] as? Int  else {
                return nil
        }
        return size
    }()

//    private var cachedSize: Int?

//    mutating func cachedComputeSize() -> Int? {
//        guard cachedSize == nil else { return cachedSize! }
//        let fm = NSFileManager.defaultManager()
//        guard
//            let dict = try? fm.attributesOfItemAtPath(self.path),
//            let size = dict["NSFileSize"] as? Int
//            else { return nil }
//        cachedSize = size
//        return size
//    }

     var cachedSize: Int? {
        let fm = NSFileManager.defaultManager()
        guard let dict = try? fm.attributesOfItemAtPath(self.path),
        let size = dict["NSFileSize"] as? Int
            else { return nil }
        return size
    }
}

//var file = File("/Users/racechao/Desktop")
extension File {
    var date: NSData? {
        get {
            return NSData(contentsOfFile: path)
        }
        set {
            let theData = newValue ?? NSData()
            theData.writeToFile(path, atomically: true)
        }
    }
}

//var file = File(path: "test.txt")

// Overloading subscripts

let fibs = [0, 1, 1, 2, 3, 5]

let first = fibs[0]
fibs[1..<3]

struct RangeStart<I: ForwardIndexType> { let start: I }
struct RangeEnd<I: ForwardIndexType> { let end: I }

postfix operator ..< {}
postfix func ..<<I: ForwardIndexType>(lhs: I) -> RangeStart<I> {
    return RangeStart(start: lhs)
}

prefix operator ..< {}
prefix func ..<<I: ForwardIndexType>(rhs: I) -> RangeEnd<I> {
    return RangeEnd(end: rhs)
}

extension CollectionType {
    subscript(r: RangeStart<Self.Index>) -> SubSequence {
        return self[r.start..<self.endIndex]
    }
    subscript(r: RangeEnd<Self.Index>) -> SubSequence {
        return self[self.startIndex..<r.end]
    }
}

extension Dictionary {
    subscript(key: Key, or defaultValue: Value) -> Value {
        get {
            return self[key] ?? defaultValue
        } set(newValue) {
            self[key] = newValue }
    }
}

extension SequenceType where Generator.Element: Hashable {
    func frequencies() -> [Generator.Element: Int] {
        var result: [Generator.Element: Int] = [:]
        for x in self {
            result[x, or: 0] += 1
        }
        return result
    }
}