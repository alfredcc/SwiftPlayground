//: Playground - noun: a place where people can play

import UIKit

func treble(i: Int) -> Int {
    return i * 3
}

let nums = [1,2,3,4].map(treble)

// closure expression
let treble1 = { (i: Int) in return i * 3}

let newNums = [1,2,3,4].map(treble1)

let isEven = { $0%2 == 0} as Int8 -> Bool
isEven(4)

// IntegerLiteralConvertible
//protocol IntegerLiteralConvertible {
//    typealias IntegerLiteralType
//
//    init(IntegerLiteral value: Self.IntegerLiteralType)
//}

func isEven<T: IntegerType>(i: T) -> Bool {
    return i%2 == 0
}

// 将一个generic funtion 赋值给一个变量必须指定 Type
let int8isEven: Int8 -> Bool = isEven

// Tips: 闭包是一种特殊的方法（匿名方法），闭包与方法主要的不同点是`闭包`能够捕获变量


// 一个粒子
// 利用 Objective-C 的 runtime
let last = "lastName", first = "firstName"

let people = [
    [first: "Neil", last: "Chao"],
    [first: "Yu",last: "Yu"],
    [first: "Chao", last: "Race"]
]

let lastDescriptor = NSSortDescriptor(key: last, ascending: true, selector: "localizedCaseInsensitiveCompare:")
let firstDescriptor = NSSortDescriptor(key: first, ascending: true, selector: "localizedCaseInsensitiveCompare:")

let descriptor = [lastDescriptor, firstDescriptor]
let sortedArray = (people as NSArray).sortedArrayUsingDescriptors(descriptor)

var strings = ["Hello", "hallo", "Hallo","hello"]

strings.sortInPlace {
    return $0.localizedCaseInsensitiveCompare($1) == .OrderedAscending
}

let sortedArrays = people.sort { $0[last] < $1[last] }

sortedArrays