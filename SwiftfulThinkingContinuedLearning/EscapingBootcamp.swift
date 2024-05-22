//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        let newData: String = downloadData()
        text = newData
        
        downloadData3 { [weak self] returnedData in
            // 🚨 strong reference
            self?.text = returnedData
        }
        
        downloadData4 { [weak self] (returnedData) in
            self?.text = returnedData.data
        }
        
        downloadData5 { [weak self] (returnedData) in
            self?.text = returnedData.data
        }
    }
    
    func downloadData() -> String {
        return "downloadData!"
    }
    func downloadData2() -> String {
        // ⚠️ simulation
        // → When we have these regular returns - they want to return immediately - This is synchronous code.
        // → But when we add these delays into our code. This is asynchronous code.
        // → This is not happening immedeiatly.
        // → This is happeninmg at a diffrent point in time.
        // → Two seconds later
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            return "New data!"
        //        }
        return ""
    }
    // ✅ When we add this at @escaping it makes our code asynchronous which means it's not going to immediately excute and return
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("downloadData3")
        }
    }
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "downloadData4")
            completionHandler(result)
        }
    }
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "downloadData5")
            completionHandler(result)
        }
    }
}
// Void == ()

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject var vm: EscapingViewModel = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}

/*
    🔴 Closures
        → Group code that executes together, without creating a named function.
        → Closures are self-contained blocks of functionality that can be passed around and used in your code.
        → Closures in Swift are similar to closures, anonymous functions, lambdas, and blocks in other programming languages.
        → Closures can capture and store references to any constants and variables from the context in which they’re defined.

    🔴 Escaping Closures
        → A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.
        → When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.

        → One way that a closure can escape is by being stored in a variable that’s defined outside the function.
        → As an example, many functions that start an asynchronous operation take a closure argument as a completion handler.
        → The function returns after it starts the operation, but the closure isn’t called until the operation is completed — the closure needs to escape, to be called later.
 
        → We use @escaping closures to deal with returning from functions when using asynchronous code.
        → This is code that does NOT execute immediately, but rather at a future point in time.
        → This becomes extremely important when we need to download data from the internet!
 */
