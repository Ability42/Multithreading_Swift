import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
eiffelImage.backgroundColor = UIColor.yellow
eiffelImage.contentMode = .scaleAspectFill

view.addSubview(eiffelImage)

PlaygroundPage.current.liveView = view


let imageURL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!

// Via Work Item
func fetchImage() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem { 
        data = try? Data(contentsOf: imageURL)
    }
    
    // workItem.cancel()
    queue.async(execute: workItem)
    
    workItem.notify(queue: DispatchQueue.main) { 
        if let imageData = data {
            eiffelImage.image = UIImage(data: imageData)
        }
    }
}


let first: Int? = 4
let second: Int? = nil
let third: Int? = 0

var array = [first, second, third]
let BEZNIL = array.flatMap { $0 }
print(BEZNIL)



// Classic way
func fetchImage2() {
    let queue = DispatchQueue.global(qos: .utility)
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: data)
            }
        }
    }
}

// With NSURLSession
func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
        if let imageData = data {
            DispatchQueue.main.async {
                print("Show image data")
                eiffelImage.image = UIImage(data: imageData)
            }
            print("Did download image data")
        }
    }
    task.resume()
}

// Async wrapper with sync operation

func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    completionQueue: DispatchQueue,
                    completion: @escaping (UIImage?, Error?) -> ()) {
    do {
        let data = try Data(contentsOf: imageURL)
        completionQueue.async { completion(UIImage(data: data), nil) }
    } catch let error {
        completionQueue.async { completion(nil, error) }
    }
}

asyncLoadImage(imageURL: imageURL, runQueue: DispatchQueue.global(), completionQueue: DispatchQueue.main) { (result, error) in
    guard let image = result else { return }
    eiffelImage.image = image
}





















