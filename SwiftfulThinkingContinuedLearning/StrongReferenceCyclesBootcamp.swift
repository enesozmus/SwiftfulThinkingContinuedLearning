//
//  StrongReferenceCyclesBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI

struct StrongReferenceCyclesBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StrongReferenceCyclesBootcamp()
}

/*
    🔴 Strong Reference Cycles Between Class Instances
        → It’s possible to write code in which an instance of a class never gets to a point where it has zero strong references.
        → This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive.
        → This is known as a "strong reference cycle".
    ⚠️ You resolve "strong reference cycles" by defining some of the relationships between classes as "weak" or "unowned references" instead of as strong references.
        → However, before you learn how to resolve a strong reference cycle, it’s useful to understand how such a cycle is caused.

             class Person {
                 let name: String
                 init(name: String) { self.name = name }
                 var apartment: Apartment?
                 deinit { print("\(name) is being deinitialized") }
             }
             class Apartment {
                 let unit: String
                 init(unit: String) { self.unit = unit }
                 var tenant: Person?
                 deinit { print("Apartment \(unit) is being deinitialized") }
             }

            * The apartment property is optional, because a person may not always have an apartment.
            * Similarly, every Apartment instance has an optional tenant property that’s initially nil. The tenant property is optional because an apartment may not always have a tenant.

        → Both of these variables have an initial value of nil, by virtue of being optional:

             var john: Person?
             var unit4A: Apartment?

        → You can now create a specific Person instance and Apartment instance and assign these new instances to the john and unit4A variables:
    ❗️ The john variable now has a strong reference to the new Person instance, and the unit4A variable has a strong reference to the new Apartment instance:
 
             john = Person(name: "John Appleseed")
             unit4A = Apartment(unit: "4A")

    ⭕️ You can now link the two instances together so that the person has an apartment, and the apartment has a tenant. And unfortunately, linking these two instances creates a strong reference cycle between them.

             john!.apartment = unit4A
             unit4A!.tenant = john

    ❗️ The Person instance now has a strong reference to the Apartment instance, and the Apartment instance has a strong reference to the Person instance.
    ❗️ Therefore, when you break the strong references held by the john and unit4A variables, the reference counts don’t drop to zero, and the instances aren’t deallocated by ARC:

             john = nil
             unit4A = nil

    ❗️ The strong reference cycle prevents the Person and Apartment instances from ever being deallocated, causing a memory leak in your app.
 */

/*
    🔴 Resolving Strong Reference Cycles Between Class Instances
        → Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.

        → Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it.
        → The instances can then refer to each other without creating a strong reference cycle.

    1. Use a weak reference when the other instance has a shorter lifetime — that is, when the other instance can be deallocated first.
    2. In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.
 */

/*
         class Person {
             let name: String
             init(name: String) { self.name = name }
             var apartment: Apartment?
             deinit { print("\(name) is being deinitialized") }
         }


         class Apartment {
             let unit: String
             init(unit: String) { self.unit = unit }
             weak var tenant: Person?
             deinit { print("Apartment \(unit) is being deinitialized") }
         }
 */
