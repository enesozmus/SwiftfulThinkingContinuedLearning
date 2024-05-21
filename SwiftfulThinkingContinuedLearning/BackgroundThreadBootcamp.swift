//
//  BackgroundThreadBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 21.05.2024.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 2: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
        }
        
        //        let newData: [String] = downloadData()
        //        dataArray = newData
    }
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data;
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm :BackgroundThreadViewModel = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}

/*
    → Every program launches with at least one thread where its work takes place, called the main thread.
    → By default, all of the code that we write in our apps is executed on the "main thread", however, if the main thread ever gets overwhelmed with tasks, it can slow down, freeze, or even crash our app.
    → Luckily, Apple provides us with easy access to many other threads that we can use to offload some of the work!
    → We will review how to add different "threads", how to perform tasks on a background thread, and how to return back to the main thread afterward.

    🔴 DispatchQueue
        → An object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread.
        → Dispatch queues execute tasks either serially or concurrently.
        → You schedule work items synchronously or asynchronously.
            → When you schedule a work item synchronously, your code waits until that item finishes execution.
            → When you schedule a work item asynchronously, your code continues executing while the work item runs elsewhere.

        → In Swift, the DispatchQueue class is used to manage the execution of tasks or closures in a concurrent or serial manner.
        → A queue is a FIFO (First In, First Out) list of tasks, and a DispatchQueue manages the execution of these tasks by dispatching them to one or more threads for execution.
        → There are several global concurrent queues available in the system, each with a different Quality of Service (QoS) level, which is used to prioritize the execution of tasks on the queue.

 https://medium.com/@amitnadir_18883/boosting-swift-performance-with-global-dispatch-queues-3a1d5d40bdb4

    1. DispatchQueue.global(qos: .background)
    2. DispatchQueue.global(qos: .userInteractive)
    3. DispatchQueue.global(qos: .userInitiated)
 
    🔴 .main
        → The dispatch queue associated with the main thread of the current process.

    🔴 DispatchQueue.main.async { }
        → You can dispatch code from a background thread back onto the main thread using DispatchQueue.main.async.
        → This is useful when you want to update the UI after a background task has completed.

    🔴 global(qos:)
        → Returns the global system queue with the specified quality-of-service class.
        → Global queue is a concurrent queue that is managed by the system, which means that it can run tasks on any available thread.
        → By default, tasks that are submitted to a global queue will be executed on a non-main thread, unless you specifically target the main queue using DispatchQueue.main.

    ⚠️ However, there are scenarios where a task submitted to a global queue can potentially end up running on the main thread. For example, if the system determines that there are no available threads to handle tasks on the global queue, it may temporarily use the main thread to execute the task instead. Additionally, if the task submitted to the global queue is very small and quick to execute, it may also end up running on the main thread. Therefore to avoid a chance of using main thread, instead of usingDispatchQueue.global() we might want to specify the QoS to background using the DispatchQueue.global(qos: .background) to make sure the queue will run on background thread.

        → The main difference between these three global concurrent queues is their Quality of Service level, which is used to prioritize the execution of tasks on the queue.
        → The .background queue has the lowest priority, followed by the .userInitiated queue, and the .userInteractive queue has the highest priority.
        → Tasks executed on the .background queue are typically long-running and can be executed over a longer period of time without significantly affecting the performance of the app.
        → In contrast, tasks executed on the .userInteractive queue are time-critical and must be executed immediately to provide a smooth and responsive user experience.
        → Finally, tasks executed on the .userInitiated queue are typically initiated by the user and require immediate results.
 
    🔴 DispatchQueue.global(qos: .background)
        → The DispatchQueue.global(qos: .background) method call creates a new global concurrent queue with a Quality of Service (QoS) of .background.
        → This QoS is used for tasks that are not time-critical and can be executed in the background without significantly affecting the performance of the app.
        → Examples of tasks that may be executed on the .background queue include data synchronization, non-essential data processing, or downloading large files.

    🔴 DispatchQueue.global(qos: .userInteractive)
        → The DispatchQueue.global(qos: .userInteractive) method call creates a new global concurrent queue with a Quality of Service (QoS) of .userInteractive.
        → This QoS is used for tasks that are time-critical and require immediate user feedback.
        → Examples of tasks that may be executed on the .userInteractive queue include updating the UI, handling user input, or playing audio.

    🔴 DispatchQueue.global(qos: .userInitiated)
        → The DispatchQueue.global(qos: .userInitiated) method call creates a new global concurrent que with a Quality of Service (QoS) of .userInitiated.
        → This QoS is used for tasks that are initiated by the user and require immediate results.
        → Examples of tasks that may be executed on the .userInitiated queue include loading data for a UI element, processing user input, or performing a search.
 */
