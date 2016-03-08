//: Playground - noun: a place where people can play

import UIKit

protocol Pokemon {
    typealias SuperPower
    func attact(power: SuperPower)
}

struct Electricity {
    var charge: Int
    func spark() {
        print("spark:", Array(count: charge, repeatedValue: "⚡️").joinWithSeparator(""))
    }
}

struct Fire {
    var level: Int
    func blast() {
        print("Blast:", Array(count: level, repeatedValue: "🔥").joinWithSeparator(""))
    }
}

struct Pikachu: Pokemon {
    func attact(power: Electricity) {
        power.spark()
    }
}

struct Charmander: Pokemon {
    func attact(power: Fire) {
        power.blast()
    }
}

struct anyPokemon<SuperPower>: Pokemon {
    let method: SuperPower -> Void
    init<U: Pokemon where U.SuperPower == SuperPower>(_ pokemon: U) {
        method = pokemon.attact
    }
    func attact(power: SuperPower) {
        method(power)
    }
}

let pika = anyPokemon(Pikachu())
let hito = anyPokemon(Charmander())

pika.attact(Electricity(charge: 16))
hito.attact(Fire(level: 10))
