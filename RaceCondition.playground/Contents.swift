//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true


var value = "👽"

func changeValue(variant: Int) {
    sleep(1)
    value = value + "👦🏻"
    print("\(value) - \(variant)")
}


let mySerialQueue = DispatchQueue.global()

mySerialQueue.async {
    changeValue(variant: 1)
}
value


value = "👀"
mySerialQueue.sync {
    changeValue(variant: 2)
}
value