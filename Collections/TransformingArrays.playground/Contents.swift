//: Playground - noun: a place where people can play

import UIKit

/**
*  functions that can capture and mutate variables outside their scope
*/

extension Array {
    func accumlate<U>(inital: U, combine: (U, Element) -> U) -> [U] {
        var sum = inital
        return self.map { next in
            sum = combine(sum, next)
            return sum
        }
    }
}

[1,2,3,4,5].accumlate(0, combine: +)

// 类似 for-in 方法
[1,2,3,4,5].forEach { (num) -> () in
    if num == 2 {
        print(num)
    }
}

let nums = [1,2,5,7,8,9,10]
let evenNumber = nums.filter { $0 % 2 == 0}
evenNumber

// filter 实现 这里对 filter 有个小 Tip：注意和 `contains` 的区别，只有当你需要数组的所有过滤后的元素使用 filter
extension Array {
    func filter(includeElement: Element -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

extension SequenceType {
    public func allMatch(predicate: Generator.Element -> Bool) -> Bool {
        return !self.contains{ !predicate($0) }
    }
}

// Reduce 实现

extension Array {
    func reduce<U>(initial: U, combine: (U,Element) -> U) -> U {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }

    // 使用 `reduce` 实现 `map` 和 `filter`
    func map2<U>(transform: Element -> U) -> [U] {
        return reduce([]) { $0 + [transform($1)]}
    }

    func filter2(includeElement: Element -> Bool) -> [Element] {
        return reduce([]) { includeElement($1) ? $0 + [$1] : $0 }
    }
}

// flatMap 实现 在Swift 2.0 中 flatMap很像map函数，但是它摒弃了那些值为nil的元素。
extension Array {
    func flatMap<U>(transform: Element -> [U]) -> [U] {
        var result: [U] = []
        for x in self {
            result.appendContentsOf(transform(x))
        }
        return result
    }
}

let suits = ["[]", "[]", "[]", "[]"]
let ranks = ["J", "K", "A", "Q"]
let all = [suits, ranks]
let flatAll = all.flatMap { (e) in
    return e.map{ $0 + "hello"}
}
flatAll

let strings = ["123", "", "12"]
let newNums = strings.flatMap { (str: String) -> Int? in
    guard str.characters.count > 0 else {
        return nil
    }
    return str.characters.count
}

newNums

