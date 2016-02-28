////: Playground - noun: a place where people can play
//
import UIKit

/**
*  Arrays and Mutability
*/

/// 使用不可变的 NSArray 也并不是意味着 array 的值不可变

//let a = NSMutableArray(array: [1,2,3])
//
//let b: NSArray = a
//
//a.insertObject(4, atIndex: 3)
//
//b

let a = NSMutableArray(array: [1,2,3])

let b = a.copy() as! NSArray

a.insertObject(4, atIndex: 3)

b

/// Map

let strings = ["hello", "world", ""]
var nums: [Int?] = []
for str in strings {
    if str.characters.count > 0 {
        nums.append(str.characters.count)
    } else {
        nums.append(nil)
    }
}

let mapedNums = strings.map { (str: String) -> Int? in
    if str.characters.count > 0 {
        return str.characters.count
    } else {
        return nil
    }
}

// 自己实现一个 map
extension Array {
    // 这里还有两个可以改进的地方 1. 加入@noescape 2. 加入rethrows
    // 最终大概是这样子: func map<U>(@noescape transform: Element throws -> U) rethrows -> [U]
    func myMap<U>(transform: Element -> U) -> [U] {
        var result: [U] = []
        result.reserveCapacity(self.count) // 这里声明 array 内存控件大小，提高 reallocate 时的效率 ref: http://stackoverflow.com/questions/27830470/swift-array-capacity-vs-array-count
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

// 其他方法

struct People {
    var age: Int
}

var peoples: [People] = []
for i in 0...5 {
    let p = People(age: i)
    peoples.append(p)
}

peoples.sort{$0.age > $1.age}

// 自定义 findElement 方法

extension SequenceType {
    func findElement(match: (Generator.Element -> Bool)) -> Generator.Element? {
        for element in self where match(element) {
            return element
        }
        return nil
    }
}

let object = peoples.findElement{ $0.age == 3 }
object


