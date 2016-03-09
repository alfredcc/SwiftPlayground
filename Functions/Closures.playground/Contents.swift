//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// @autoclosure 
// “@autoclosure 并不支持带有输入参数的写法，也就是说只有形如 () -> T 的参数才能使用这个特性进行简化。” 摘录来自: 王巍 (onevcat). “Swifter - 100 个 Swift 必备 Tips (第二版)”。 iBooks.
func and(lhs: Bool,@autoclosure _ rhs: () -> Bool) -> Bool {
    guard lhs else { return false }
    return rhs()
}

let nums = [11,2,3,4,5]
if and(!nums.isEmpty, nums[0] > 10) {
    print(nums[0])
}

// noescape annotation
// noescape transform: (Self.Generator.Element)throws -> T

func bar(@noescape code: (() -> String)) -> String {
    return code()
}
func foo(@noescape code: (() -> String)) -> String {
    return "foo \(bar(code))"
}

print(foo() {"abc"})
//
//// 摘录来自 http://nshint.io/blog/2015/10/23/noescape-attribute/
///// >closures (and functions) annotated with @noescape can only be passed as @noescape parameters.
//
//// we cannot run it asynchronously:
//func async(@noescape code: () -> Void ) {
//    dispatch_async(dispatch_get_main_queue(), code)
//}
//
//// we can’t store it
//func store(@noescape code: () -> Void) {
//    let codeFunc: () -> Void = code
//    codeFunc()
//}
//
//// we can’t capture it in another non-@noescape closure
//func capture(@noescape code: () -> Void) {
//    let capured = {
//        code()
//    }
//    capured()
//}

//func funcBuild<T, U, V>(f: T -> U, _ g: V -> T)
//    -> V -> U {
//    return {
//        f(g($0))
//    }
//}

let arr = [1,2,10]

let max = arr.reduce(0) { (pre: Int, element: Int) -> Int in
    if pre > element {
        return pre
    } else {
        return element
    }
}

max