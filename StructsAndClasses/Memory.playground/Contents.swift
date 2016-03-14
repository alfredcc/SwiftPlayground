//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Persion {
    let name: String
    var parents: [Persion]
}

var Neil = Persion(name: "Neil", parents: [])
Neil.parents = [Neil]

print(Neil)

class View {
    unowned var window: Window
    init(window: Window) {
        self.window = window
    }
}

class Window {
    var rootView: View?
}


var window: Window? = Window()
var view: View? = View(window: window!)
window?.rootView = view

view = nil
window = nil

