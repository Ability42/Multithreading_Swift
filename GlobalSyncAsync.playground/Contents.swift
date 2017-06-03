import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let mainQueue = DispatchQueue.main

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)

let defaultQueue = DispatchQueue.global()

func task(_ symbol: String) {
    for i in 1...10 {
        print("\(symbol) \(i) priority = \(qos_class_self().rawValue)")
    }
}

func taskHIGHT(_ symbol: String) {
    print("\(symbol) Hight priority = \(qos_class_self().rawValue)")
}


print("---------------------------------------------------")
print(" AСИНХРОННОСТЬ  async ")
print(" Q1 - Global .concurrent qos = .userInitiated")
print("---------------------------------------------------")

userInitiatedQueue.async { task("👰🏿") }
task("👽")

print("---------------------------------------------------")
print(" СИНХРОННОСТЬ  sync ")
print(" Q1 - Global .concurrent qos = .userInitiated")
print("---------------------------------------------------")

userInitiatedQueue.sync { task("👰🏿") }
task("👽")