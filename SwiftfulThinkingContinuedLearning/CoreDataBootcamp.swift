//
//  CoreDataBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 19.05.2024.
//

import SwiftUI

struct CoreDataBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataBootcamp()
}

/*
 
    import CoreData
 
    🔴 Core Data
        → a Framework
        → With Core Data, you can persist or cache data on a single device, or sync data to multiple devices with CloudKit.
        → Use Core Data to save your application’s permanent data for offline use, to cache temporary data, and to add undo functionality to your app on a single device.
        → To sync data across multiple devices in a single iCloud account, Core Data automatically mirrors your schema to a CloudKit container.
        → Through Core Data’s "Data Model editor", you define your data’s types and relationships, and generate respective class definitions.

    ✅ Core Data is an object graph and persistence framework, which is a fancy way of saying it lets us define objects and properties of those objects, then lets us read and write them from permanent storage.
    ✅ On the surface this sounds like using Codable and UserDefaults, but it’s much more advanced than that: Core Data is capable of sorting and filtering of our data, and can work with much larger data. There’s effectively no limit to how much data it can store.
    ✅ Even better, Core Data implements all sorts of more advanced functionality for when you really need to lean on it: data validation, lazy loading of data, undo and redo, and much more.
 */

/*
    🔴 Creating a Core Data model
        → Define your app’s object structure with a data model file.
        → The first step in working with Core Data is to create a data model file to define the structure of your app’s objects, including their object types, properties, and relationships.
        → Core Data needs to know ahead of time what all our data types look like, what it contains, and how it relates to each other. This is all contained in a new file type called Data Model, which has the file extension “xcdatamodeld”.
        ⚠️ Data models don’t contain our actual data, just the definitions of properties and attributes like we defined a moment ago.
        → .xcdatamodeld
 
    ✅ Let’s create one now: press Cmd+N to make a new file, select Data Model from the list of templates, then name your model .xcdatamodeld.
            → When you press Create, Xcode will open the new file in its data model editor.
            → Here we define our types as “entities”, then create properties in there as “attributes”.
            ⭕️ Core Data is responsible for converting that into an actual database layout it can work with at runtime.
    ✅ + Add Entity
    ✅ Set the properties of your entities
 */

/*
    🔴 Setting up a Core Data stack
        → Manage and persist your app’s model layer.
        → Set up the classes that manage and persist your app’s objects.
        → These classes are collectively referred to as the Core Data stack.

            1. An instance of NSManagedObjectModel represents your app’s model file describing your app’s types, properties, and relationships.
            2. An instance of NSManagedObjectContext tracks changes to instances of your app’s types.
            3. An instance of NSPersistentStoreCoordinator saves and fetches instances of your app’s types from stores.
            4. An instance of NSPersistentContainer sets up the model, context, and store coordinator all at once.
 
    ✅ First, create a new Swift file called CoreDataStack.swift
    ✅ Add this -import CoreData- just above its import Foundation line:
            ⭕️ We’re going to start by creating a new class called CoreDataStack, making it conform to ObservableObject so that we can use it with the @StateObject property wrapper.
            ⭕️ We want to create one of these when our app launches, then keep it alive for as long as our app runs.
 */

/*
    🔴 Initialize a Persistent Container
        ✅ Inside this class we’ll add a single property of the type NSPersistentContainer, which is the Core Data type responsible for loading a data model and giving us access to the data inside.
 
    🔴 NSPersistentContainer
        → A container that encapsulates the Core Data stack in your app.
        → NSPersistentContainer simplifies the creation and management of the Core Data stack by handling the creation of the managed object model (NSManagedObjectModel), persistent store coordinator (NSPersistentStoreCoordinator), and the managed object context (NSManagedObjectContext).
 */

/*
    🔴 Inject the managed object context
        → Create an instance of the Core Data stack and inject its managed object context into your app environment.
        → That completes CoreDataStack, so the final step is to create an instance of CoreDataStack and send it into SwiftUI’s environment.
        → This is relevant to Core Data because most apps work with only one Core Data store at a time, so rather than every view trying to create their own store individually we instead create it once when our app starts, then store it inside the SwiftUI environment so everywhere else in our app can use it.
 
        ✅ Go to app/root/main file
 
     🔴 Managed object contexts
         → The third piece of the Core Data puzzle: managed object contexts.
         → These are effectively the “live” version of your data – when you load objects and change them, those changes only exist in memory until you specifically save them back to the persistent store.
         → So, the job of the view context is to let us work with all our data in memory, which is much faster than constantly reading and writing data to disk. When we’re ready we still do need to write changes out to persistent store if we want them to be there when our app runs next, but you can also choose to discard changes if you don’t want them.
 */
