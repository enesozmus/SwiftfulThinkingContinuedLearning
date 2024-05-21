//
//  AutomaticReferenceCountingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 21.05.2024.
//

import SwiftUI

struct AutomaticReferenceCountingBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AutomaticReferenceCountingBootcamp()
}

/*
    🔴 Automatic Reference Counting
        → Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage.
        → In most cases, this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself.
        → ARC automatically frees up the memory used by class instances when those instances are no longer needed.
    ⚠️ However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you.

    🔴 How ARC Works
        → Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance.
        → This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.
        → Additionally, when an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead.
        → This ensures that class instances don’t take up space in memory when they’re no longer needed.
        → However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods.
        → Indeed, if you tried to access the instance, your app would most likely crash.
        → To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance.
        → ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
    ⭕️ To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes "a strong reference" to the instance.
        → The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains.
 */

/*
    🔴 ARC in Action
        → an example of how Automatic Reference Counting works.
        → This example starts with a simple class called Person, which defines a stored constant property called name:

             class Person {
                 let name: String
                 init(name: String) {
                     self.name = name
                     print("\(name) is being initialized")
                 }
                 deinit {
                     print("\(name) is being deinitialized")
                 }
             }

        ❗️ The next code snippet defines three variables of type Person?, which are used to set up multiple references to a new Person instance.
        → Because these variables are of an optional type (Person?, not Person), they’re automatically initialized with a value of nil, and don’t currently reference a Person instance.

             var reference1: Person?
             var reference2: Person?
             var reference3: Person?

        → You can now create a new Person instance and assign it to one of these three variables:
        ❗️ Because the new Person instance has been assigned to the reference1 variable, there’s now a strong reference from reference1 to the new Person instance.
        ❗️ Because there’s at least one strong reference, ARC makes sure that this Person is kept in memory and isn’t deallocated.

            reference1 = Person(name: "John Appleseed")

        → If you assign the same Person instance to two more variables, two more strong references to that instance are established:

            reference2 = reference1
            reference3 = reference1

        → There are now three strong references to this single Person instance.
        → If you break two of these strong references (including the original reference) by assigning nil to two of the variables, a single strong reference remains, and the Person instance isn’t deallocated:

            reference1 = nil
            reference2 = nil

        ❗️ ARC doesn’t deallocate the Person instance until the third and final strong reference is broken, at which point it’s clear that you are no longer using the Person instance:

            reference3 = nil
 */
