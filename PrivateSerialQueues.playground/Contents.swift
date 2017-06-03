import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let mySerialQueue = DispatchQueue(label: "com.sp.mySerial")

func task(_ symbol: String) {
    for i in 1...10 {
        print("\(symbol) \(i) priority = \(qos_class_self().rawValue)")
    }
}

func taskHIGHT(_ symbol: String) {
    print("\(symbol) Hight priority = \(qos_class_self().rawValue)")
}

print("--------------------------------------------------")
print("Sync")
print("Private .serial Q1 - no")
print("--------------------------------------------------")

mySerialQueue.sync {
    task("🤖")
}
task("🎃")

print("--------------------------------------------------")
print("Sync")
print("Private .serial Q1 - no")
print("--------------------------------------------------")

mySerialQueue.async {
    task("🤖")
}
task("🎃")


