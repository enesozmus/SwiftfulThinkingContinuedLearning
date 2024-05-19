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
        → .xcdatamodeld
 
    ✅ Let’s create one now: press Cmd+N to make a new file, select Data Model from the list of templates, then name your model Aaaa.xcdatamodeld.
    ✅ + Add Entity
    ✅ Set the properties of your entity
 */
