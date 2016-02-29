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