//
//  StateObjectAndObservedObjectBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 15.05.2024.
//

import SwiftUI

class DataModel: ObservableObject {
    // → There are several ways for an observed object to notify views that important data has changed, but the easiest is using the @Published property wrapper.
    @Published var name = "Some Name"
    @Published var isEnabled = false
}

struct StateObjectAndObservedObjectBootcamp: View {
    @StateObject private var model = DataModel()
    
    var body: some View {
        Text(model.name)
        MySubView(model: model)
    }
}

struct MySubView: View {
    @ObservedObject var model: DataModel
    
    var body: some View {
        Toggle("Enabled", isOn: $model.isEnabled)
    }
}

#Preview {
    StateObjectAndObservedObjectBootcamp()
}

/*
    🔴 State
        → State is inevitable in any modern app.
        → With SwiftUI it’s important to remember that all of our views are simply functions of their state.
        → We don’t change the views directly, but instead manipulate the state and let that dictate the result.

        → When dealing with properties that represent some form of state, it’s very common to have some kind of associated logic that gets triggered every time that a value is modified.

        → SwiftUI gives us several ways of storing state in our application, but they are subtly different and it’s important to understand how they are different in order to use the framework properly.
        → The simplest way of working with state is the @State property wrapper, used like this:

            @State private var tapCount = 0

        → @State is great for simple properties that belong to a specific view and never get used outside that view.
        🔳 When you have a custom type you want to use that might have multiple properties and methods, or might be shared across multiple views – you will often use @StateObject and @ObservedObject instead.
        → This is very similar to @State except now we’re using an external reference type rather than a simple local property like a string or an integer.
        🔳 You’re still saying that your view depends on data that will change, but now it's your responsibility to manage the data.
 */

/*
    ✅ @StateObject and @ObservedObject property wrappers in SwiftUI instruct the view to update in response to changes in an observed object.
    ✅ Both property wrappers require that the object conforms to the ObservableObject protocol.
    ✅ Though these two property wrappers seem similar, there is a crucial difference to understand when building apps with SwiftUI.

    ❗️ Using @ObservedObject causes the @Published variable to reset whenever @State changes. So since a view can be created or recreated at any time, creating an @ObservedObject within a view is not safe.
    ✅ There is one important difference between @StateObject and @ObservedObject, which is ownership – which view created the object, and which view is just watching it.
    ✅ The rule is this: whichever view is the first to create your object must use @StateObject, to tell SwiftUI it is the owner of the data and is responsible for keeping it alive.
    ✅ All other views must use @ObservedObject, to tell SwiftUI they want to watch the object for changes but don’t own it directly.

    ✅ It is really important that you use @ObservedObject only with views that were passed in from elsewhere.

    ✅ We prefer to use the @StateObject wrapper to ensure consistent results when redrawing the view, unless @ObservedObject is injected as a dependency.
 */

/*
    🔴 StateObject
        → A property wrapper type that instantiates an observable object.
        → Use a state object as the single source of truth for a reference type that you store in a view hierarchy.
        → Create a state object in an App, Scene, or View by applying the @StateObject attribute to a property declaration and providing an initial value that conforms to the ObservableObject protocol.

        → SwiftUI gives us the @StateObject property wrapper so that views can watch the state of an external object, and be notified when something important has changed.

        → SwiftUI’s @StateObject property wrapper is designed to fill a very specific gap in state management: when you need to create a reference type inside one of your views and make sure it stays alive for use in that view and others you share it with.

        → SwiftUI creates a new instance of the model object only once during the lifetime of the container that declares the state object. For example, SwiftUI doesn’t create a new instance if a view’s inputs change, but does create a new instance if the identity of a view changes.
 
        ❗️ Important: You should use @StateObject only once per object, which should be in whichever view is responsible for creating the object. All other views that share your object should use @ObservedObject.

             class DataModel: ObservableObject {
                 @Published var name = "Some Name"
                 @Published var isEnabled = false
             }


             struct MyView: View {
                 @StateObject private var model = DataModel() // Create the state object.


                 var body: some View {
                     Text(model.name) // Updates when the data model changes.
                     MySubView()
                         .environmentObject(model)
                 }
             }
 */

/*
    🔴 ObservedObject
        → A property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes.
        → Add the @ObservedObject attribute to a parameter of a SwiftUI View when the input is an ObservableObject and you want the view to update when the object’s published properties change.
        → You typically do this to pass a StateObject into a subview.

        → First, any type you mark with @ObservedObject must conform to the ObservableObject protocol, which in turn means it must be a class rather than a struct.
        → ❗️ This isn’t optional – SwiftUI requires us to use a class here.

        → It is similar in behavior to @StateObject, except it must not be used to create objects.
        → ❗️ use @ObservedObject only with objects that have been created elsewhere, otherwise SwiftUI might accidentally destroy the object.

        → The following example defines a data model as an observable object, instantiates the model in a view as a state object, and then passes the instance to a subview as an observed object:

             class DataModel: ObservableObject {
                 @Published var name = "Some Name"
                 @Published var isEnabled = false
             }

             struct MyView: View {
                 @StateObject private var model = DataModel()

                 var body: some View {
                     Text(model.name)
                     MySubView(model: model)
                 }
             }

             struct MySubView: View {
                 @ObservedObject var model: DataModel

                 var body: some View {
                     Toggle("Enabled", isOn: $model.isEnabled)
                 }
             }
 */
