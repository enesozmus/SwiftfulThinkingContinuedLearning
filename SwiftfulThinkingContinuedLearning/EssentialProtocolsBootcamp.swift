//
//  EssentialProtocolsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 17.05.2024.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct EssentialProtocolsBootcamp: View {
        
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.title)
                }
            }
            .padding(.top, 72)
        }
    }
}

#Preview {
    EssentialProtocolsBootcamp()
}

/*
    🔴 Identifiable
        → a protocol
        → A class of types whose instances hold the value of an entity with stable identity.
        → Identifiable is a protocol in Swift that enforces types to include a unique identifier property.
        → The Identifiable protocol is used to provide a stable notion of identity to a class or value type.
 
        Identities can have any of the following characteristics:
          1. ✅ Guaranteed always unique, like UUIDs.
          2. Persistently unique per environment, like database record keys.
          3. Unique for the lifetime of a process, like global incrementing integers.
          4. Unique for the lifetime of an object, like object identifiers.
          5. Unique within the current collection, like collection indices.
 */

/*
    🔴 Equatable
        → a protocol
        → A type that can be compared for value equality.
        → Types that conform to the Equatable protocol can be compared for equality using the equal-to operator (==) or inequality using the not-equal-to operator (!=).

         struct Person: Equatable {
             var name: String
             var age: String

             static func ==(lhs: Person, rhs: Person) -> Bool {
                 return lhs.name == rhs.name && lhs.age == rhs.age
             }
         }
 */

/*
    🔴 Comparable
        → a protocol
        → A type that can be compared using the relational operators <, <=, >=, and >.
        → Add Comparable conformance to your own custom types when you want to be able to compare instances using relational operators or use standard library methods that are designed for Comparable types.
        → The Comparable protocol allows use to use the <, >, <=, and >= operators with conforming data types, which in turn means that Swift knows how to sort arrays of those types.

         struct Person {
             var name: String

             static func <(lhs: Person, rhs: Person) -> Bool {
                 return lhs.name < rhs.name
             }
         }
         let taylor = Person(name: "Taylor Swift")
         let justin = Person(name: "Justin Bieber")
         print(taylor < justin)
 */

/*
    🔴 Hashable
        → a protocol
        → A type that can be hashed into a Hasher to produce an integer hash value.
        → You can use your own custom type or any type that conforms to the Hashable protocol in a set or as a dictionary key.
        → The Hashable protocol is very similar to the Identifiable protocol - it's another way to give a unique identifier to an object.

        → Now when we create instances of Employee, the protocol will provide hash values to the instances.
 
         struct Employee: Hashable {
           var name: String
         }

        → SwiftUI needs to know how to identify each dynamic view uniquely so that it can animate changes correctly.
        → If an object conforms to the Identifiable protocol, then SwiftUI will automatically use its id property for uniquing.
        → If we don’t use Identifiable, then we can use a keypath for a property we know to be unique, such as a book’s ISBN number.
        → But if we don’t conform to Identifiable and don’t have a keypath that is unique, we can often use \.self.
        → \.self works for anything that conforms to Hashable, because Swift will generate the hash value for the object and use that to uniquely identify it.
        → So what actually happens is that Swift computes the hash value of the struct, which is a way of representing complex data in fixed-size values, then uses that hash as an identifier.
        → Hashes are commonly used for things like data verification. For example, if you download a 8GB zip file, you can check that it’s correct by comparing your local hash of that file against the server’s – if they match, it means the zip file is identical. Hashes are also used with dictionary keys and sets; that’s how they get their fast look up.

        ⚠️ In Swift, the following types conforms to the Hashable protocol by default: Int, UInt, Float, Double, Bool, String, Character, Tuples, Optionals, Enums.
        ⚠️  The Hashable protocol inherits from the Equatable protocol, so you must also satisfy that protocol’s requirements.
 */
