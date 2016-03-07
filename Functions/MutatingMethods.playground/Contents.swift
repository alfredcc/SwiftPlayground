//: Playground - noun: a place where people can play

import UIKit

// inout 
func increment(inout i: Int) {
    i += 1
}

var x = 0

increment(&x)

x

func inc() -> () -> Int {
    var i = 0
    // 在闭包捕获 i，并且加 1

    return {
        i += 1
        return i
    }
}

let u = inc()
print(u())
print(u())

func inc(inout i: Int) -> () -> Int {
//    return {
//        i += 1
//        return i
//    }
    let f: () -> Int = {
        i += 1
        return i
    }
    f()
    return f
}

var y = 0
let fx = inc(&y)
print(fx())
print(fx())
print(y)


func incref(i: UnsafeMutablePointer<Int>) -> () -> Int {
    return {
        i.memory += 1
        return i.memory
    }
}

let fun: () -> Int
do {
    var array = [0]
    fun = incref(&array)
}

fun()
fun()
fun()