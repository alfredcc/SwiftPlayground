//
//  ViewController.swift
//  Roguelike
//
//  Created by race on 16/3/15.
//  Copyright © 2016年 race. All rights reserved.
//

import UIKit

protocol Serializer {
    subscript(name: String) -> AnyObject? { get set }
}

typealias PropertyList = [String: AnyObject]

extension NSUserDefaults: Serializer {
    subscript(name: String) -> AnyObject? {
        get {
            return objectForKey(name)
        }
        set {
            setObject(newValue, forKey: name)
        }
    }
}

// MARK: - Player
struct Player {
    var health: Health
    var chocolates: BoxOfChocolates?

    init(properties: PropertyList = [:]) {
        let healthProperties = properties["health"] as? PropertyList ?? [:]
        health = Health(properties: healthProperties)
        if let chocolatesProperties = properties["chocolates"] as? PropertyList {
            chocolates = BoxOfChocolates(properties: chocolatesProperties)
        }
    }

    mutating func study() {
        health.foodPoints -= 2
        health.experiencePoints += 1
    }

    func serialize() -> PropertyList {
        var result: PropertyList = [
            "health": health.serialize()
        ]
        result["chocolates"] = chocolates?.serialize()
        return result
    }
}

extension Player {
    mutating func eat() {
        guard let count = chocolates?.numberOfChocolates where count > 0
            else { return }
        chocolates?.numberOfChocolates -= 1
        health.foodPoints = min(100, health.foodPoints + 10)
    }
}

// MARK: - Health
struct Health {
    var foodPoints: Int = 100
    var experiencePoints: Int = 0

    init(properties: PropertyList = [:]) {
        foodPoints = properties["food"] as? Int ?? foodPoints
        experiencePoints = properties["experience"] as? Int ?? experiencePoints
    }

    func serialize() -> PropertyList {
        return [
            "food": foodPoints,
            "experience": experiencePoints
        ]
    }
}

// MARK: - BoxOfChocolates
struct BoxOfChocolates {
    private var numberOfChocolates: Int = 10

    init(properties: PropertyList) {
        numberOfChocolates = properties["chocolates"] as? Int ?? numberOfChocolates
    }

    func serialize() -> PropertyList {
        return [
            "chocolates": numberOfChocolates
        ]
    }
}

class GameState {
    var player: Player {
        didSet { save() }
    }

    var serializer: Serializer

    init(serializer: Serializer = NSUserDefaults.standardUserDefaults()) {
        self.serializer = serializer
        player = Player(properties: (serializer["player"] ?? [:]) as! PropertyList)
    }

    func save() {
        serializer["player"] = player.serialize()
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

