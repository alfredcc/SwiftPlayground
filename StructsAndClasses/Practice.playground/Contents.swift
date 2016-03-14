//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


typealias USDCents = Int

// Not thread-safe
//class Account {
//    var funds: USDCents = 0
//    init(funds: USDCents) {
//        self.funds = funds
//    }
//}

struct Account {
    var funds: USDCents
}

var alice = Account(funds: 100)
var bob = Account(funds: 0)

func transfer(amount: USDCents, source: Account, destination: Account) ->
    (source: Account, destination: Account)? {
    guard source.funds >= amount else { return nil }
    var newSource = source
    newSource.funds -= amount
            var newDestination = destination
        newDestination.funds += amount
    return (newSource, newDestination)
}

func transfer(amount: USDCents, inout source: Account, inout destination: Account) -> Bool {
    guard source.funds >= amount else { return false }
    source.funds -= amount
    destination.funds += amount
    return true
}

transfer(50, source: &alice, destination: &bob)

alice // 还是原来的值
bob

// Closures with strong reference

class People {
    init() {
        print("init")
    }
    deinit {
        print("deinit")
    }
}

func scope() {
    let people = People()
    print("About to leave scope")
}

//scope()

func capturingScope() -> () -> () {
    let people = People()
    return { print(people) }
}

//let a = capturingScope()
//
//a()

let _ = capturingScope()