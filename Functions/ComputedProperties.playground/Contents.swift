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

