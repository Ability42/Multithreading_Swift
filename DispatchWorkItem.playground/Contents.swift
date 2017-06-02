import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


func taskHight(_ symbol: String) {
    print("\(symbol) priority = \(qos_class_self().rawValue)")
}

func task(_ symbol: String) {
    for i in 1...10 {
        print("\(symbol) \(i) priority = \(qos_class_self().rawValue)")
    }
}

print("-------------------------------------")
print(" Private .serial Q1 - .utility")
print(" Private .serial Q2 - .userInteractive")
print("-------------------------------------")


let hightPriorityItem = DispatchWorkItem(qos: .userInteractive, flags: [.enforceQoS]) { 
    taskHight("🎩")
}

let workerQueue1 = DispatchQueue(label: "com.sp.mySerial", qos: .userInitiated, attributes: .concurrent)
let workerQueue2 = DispatchQueue(label: "com.sp.mySerial", qos: .background, attributes: [.concurrent, .initiallyInactive])

workerQueue2.async { task("🐣") }
workerQueue1.async { task("🦋") }
workerQueue1.async(execute: hightPriorityItem)
workerQueue1.async(execute: hightPriorityItem)
workerQueue1.async(execute: hightPriorityItem)


sleep(2)
workerQueue2.activate()

