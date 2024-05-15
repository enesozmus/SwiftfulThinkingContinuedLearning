//
//  ObservableObjectBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 15.05.2024.
//

import SwiftUI

class UserProgress: ObservableObject {
    @Published var score = 0
}

struct ObservableObjectBootcamp: View {
    @StateObject var progress = UserProgress()
    
    var body: some View {
        VStack {
            Text("Your score is \(progress.score)")
            InnerView(progress: progress)
        }
    }
}

struct InnerView: View {
    @ObservedObject var progress: UserProgress

    var body: some View {
        Button("Increase Score") {
            progress.score += 1
        }
    }
}

#Preview {
    ObservableObjectBootcamp()
}

/*
    ✅ In SwiftUI, managing state that’s shared across multiple views requires tools that extend beyond the State property wrapper.
    ✅ This is where ObservableObject and ObservedObject come into play.
    ✅ ObservableObject is a protocol that SwiftUI provides for objects that can be observed for changes.
    ✅ When you mark a class as conforming to ObservableObject, you’re signaling to SwiftUI that this object’s properties, when changed, should trigger a refresh of any views that depend on them.
    ✅ Any properties marked with @Published in an ObservableObject will automatically notify the view to update when they change.

    🔴 ObservableObject
        → a protocol
        → A type of object with a publisher that emits before the object has changed.
        → By default an ObservableObject synthesizes an objectWillChange publisher that emits the changed value before any of its @Published properties changes.

            1.   The ObservableObject protocol is used with some sort of class that can store data.
            2.   The @Published property wrapper is added to any properties inside an observed object that should cause views to update when they change.
            3.   The @ObservedObject and @StateObject property wrappers is used inside a view to store an observable object instance.

         class UserProgress: ObservableObject {
             @Published var score = 0
         }

         struct InnerView: View {
             @ObservedObject var progress: UserProgress

             var body: some View {
                 Button("Increase Score") {
                     progress.score += 1
                 }
             }
         }

         struct ContentView: View {
             @StateObject var progress = UserProgress()

             var body: some View {
                 VStack {
                     Text("Your score is \(progress.score)")
                     InnerView(progress: progress)
                 }
             }
         }
 */
