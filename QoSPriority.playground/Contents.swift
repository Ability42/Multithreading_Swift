import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func task(_ symbol: String) {
    for i in 1...10 {
        print("\(symbol) \(i) priority = \(qos_class_self().rawValue)")
    }
}

let serialPriorityQueue1 = DispatchQueue(label: "com.sp.mySerial", qos: .utility)
let serialPriorityQueue2 = DispatchQueue(label: "com.sp.mySerial", qos: .background)


print("-------------------------------------")
print(" Private .serial Q1 - .utility")
print(" Private .serial Q2 - .userInteractive")
print("-------------------------------------")

serialPriorityQueue2.asyncAfter(deadline: .now() + 0.1, qos: .userInteractive) { task("🐭") }

serialPriorityQueue1.async { task("🦋") }
sleep(1)
