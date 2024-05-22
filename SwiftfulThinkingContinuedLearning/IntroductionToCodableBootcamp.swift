//
//  CodableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI

// 🚨 What's really cool thing about Codable is that it does all of this for us on its own.
struct RolandModel: Identifiable, Decodable, Encodable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
        case isPremium
    }
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    // 🚨 What's really cool thing about Codable is that it does all of this for us on its own.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    // 🚨 What's really cool thing about Codable is that it does all of this for us on its own.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
    }
}

class IntroductionToCodableViewModel: ObservableObject {
    
    @Published var roland: RolandModel? = nil
    
    
    init() {
        getData()
    }
    
    // ... 🟦
    func getData() {
        guard let returnedData = getJSONData() else { return }
        self.roland = try? JSONDecoder().decode(RolandModel.self, from: returnedData)
    }
    // To simulate downloading data from the Internet
    func getJSONData() -> Data? {
        let roland = RolandModel(id: "1", name: "Ari", points: 10, isPremium: false)
        let jsonData = try? JSONEncoder().encode(roland)
        return jsonData;
    }
}

struct IntroductionToCodableBootcamp: View {
    
    @StateObject var vm: IntroductionToCodableViewModel = IntroductionToCodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let roland = vm.roland {
                Text(roland.id)
                Text(roland.name)
                Text("\(roland.points)")
                Text(roland.isPremium.description)
            }
        }
    }
}

#Preview {
    IntroductionToCodableBootcamp()
}

/*
    1️⃣ We know that not every computer, every program, every application, every platform, and every software developer speaks the same language among themselves.
    2️⃣ For communication, two separate structures need a common language, and at the same time, this language must also have the desired qualities.

    → A lot of apps have online features that require a network connection in order to work.
    → For example, you need to be online to see the photos in your Instagram feed, or to load and read the latest news in Reddit.
    → If you’re creating an app with online functionality, you might need to depend on a backend API, and read or send data in the form of JSON.
    ✅ We’re going to explore the Encodable and Decodable protocols, and how it can be used to convert to and from an external representation such as JSON.

    🔴 JSON
        → JavaScript Object Notation
        → (JSON) is a standard text-based format for representing structured data based on JavaScript object syntax.
        → JSON is an open standard file format, and data interchange format, that uses human-readable to store and transmit data objects consisting of attribute-value pairs and array data types.
        → Thanks to its simplicity, flexibility, and compatibility with popular programming languages, JSON is a lightweight data interchange format that provides a standardized and efficient way for different systems, platforms, and programming languages to exchange data.
        ✅ Yes, we have the common file format to easily communicate with other developers or fetch the data!

    🔴 Why Is JSON Used?
        → JSON's language-independent nature makes it an ideal format for exchanging data across different programming languages and platforms.
        → For instance, an application written in Java can easily send JSON data to a Python application.
        → Or a mobile app written in JavaScript can use JSON to communicate with a back-end server written in PHP.
        → Why?
        → Because both systems can parse and generate JSON.
        → JSON is also used within an application or an IT system for storing and managing configuration settings.
        → For example, configuration files written in JSON format can contain essential information, such as database connection details, API keys, or user preferences.
 */

/*
    ✅ Many programming tasks involve sending data over a network connection, saving data to disk, or submitting data to APIs and services.
        → These tasks often require data to be encoded and decoded to and from an intermediate format while the data is being transferred.
        → The Swift standard library defines a standardized approach to data encoding and decoding.
        → You adopt this approach by implementing the Encodable and Decodable protocols on your custom types.
        → Adopting these protocols lets implementations of the Encoder and Decoder protocols take your data and encode or decode it to and from an external representation such as JSON or property list.
        → To support both encoding and decoding, declare conformance to Codable, which combines the Encodable and Decodable protocols.
        → This process is known as making your types codable.
*/

/*
    🔴 protocol Decodable
        → A type that can decode itself from an external representation.
        → (bytes to object)
    🔴 protocol Encodable
        → A type that can encode itself to an external representation.
        → (object to bytes)
    🔴 protocol Codable
        → A type that can convert itself into and out of an external representation.
        → Codable is to convert the JSON data object to an actual Swift class or struct and vice versa.
        → Codable is a type alias for the Encodable and Decodable protocols.
        → When you use Codable as a type or a generic constraint, it matches any type that conforms to both protocols(Encodable and Decodable).
 */

/*
    ✅ To model relevant JSON data, we’ll create a struct reflecting the properties from the JSON data, and conforming the model to the Codable protocol.
 
            struct RolandModel: Identifiable, Decodable, Encodable {
                ❗️ The only requirement of declaring a Codable is that all of its stored properties must also be Codable.
            }
            or
            struct RolandModel: Identifiable, Codable {
                ❗️ The only requirement of declaring a Codable is that all of its stored properties must also be Codable.
            }

    → The stored properties of the relevant struct model consists of each of the fields from the JSON data, and the types of each property depends on its respective value from the JSON data.
    → The Codable conformance declaration makes the relevant struct model as both Encodable and Decodable without having the necessary declarations for both protocols.
    → Adopting Codable to our custom types allows us to serialize them from and to a data format using a built-in Encoder and Decoder.


    1️⃣ We’ll use the JSONDecoder to decode a JSON string into its equivalent model type in Swift.
    2️⃣ We’ll use JSONEncoder to encode a codable Swift struct back to JSON.
*/

/*
    🔴 JSONDecoder
        → An object that decodes instances of a data type from JSON objects.
    🔴 decode(_:from:)
        → Returns a value of the type you specify, decoded from a JSON object.
 
         struct GroceryProduct: Codable {
             var name: String
             var points: Int
             var description: String?
         }


         let json = """
         {
             "name": "Durian",
             "points": 600,
             "description": "A fruit with a distinctive scent."
         }
         """.data(using: .utf8)!


         let decoder = JSONDecoder()
         let product = try decoder.decode(GroceryProduct.self, from: json)


         print(product.name) // Prints "Durian"

    🔴 JSONEncoder
        → An object that encodes instances of a data type as JSON objects.
    🔴 encode(_:)
        → Returns a JSON-encoded representation of the value you supply.
 
         struct GroceryProduct: Codable {
             var name: String
             var points: Int
             var description: String?
         }


         let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear.")


         let encoder = JSONEncoder()
         encoder.outputFormatting = .prettyPrinted


         let data = try encoder.encode(pear)
         print(String(data: data, encoding: .utf8)!)


         /* Prints:
          {
            "name" : "Pear",
            "points" : 250,
            "description" : "A ripe pear."
          }
         */
 */

/*
    → In some cases, the property names of the data model coming from an external API may be written in ways we do not want.
    → They may not be using naming conventions.
    ✅ Therefore, the quality of your code may decrease. To prevent this from happening, we use the CodingKeys structure.

    🔴 CodingKey
        → A type that can be used as a key for encoding and decoding.
        → Codable types can declare a special nested enumeration named CodingKeys that conforms to the CodingKey protocol.

         struct Landmark: Codable {
             var name: String
             var foundingYear: Int
             var location: Coordinate
             var vantagePoints: [Coordinate]
             
             enum CodingKeys: String, CodingKey {
                 case name = "title"
                 case foundingYear = "founding_date"
                 
                 case location
                 case vantagePoints
             }
         }
 
    🔴 container(keyedBy:)
        → Returns the data stored in this decoder as represented in a container keyed by the given key type.

    1️⃣ .container(keyedBy:) is basically a function that you can call on any instance of Decoder or Encoder that you create.
    2️⃣ .container(keyedBy:) function takes some type of CodingKey as a parameter, and returns that same type of KeyedDecodingContainer.
    3️⃣ We are giving it CodingKeys.self as a parameter, and it will return a KeyedDecodingContainer based on that.
    4️⃣ The KeyedDecodingContainer is basically just a container holding keys and the encoded values associated with them.

        let container = try decoder.container(keyedBy: CodingKeys.self)

    5️⃣ That basically says, "Take all those ones and zeroes stored in the .name key of the container, and try to see if you can make a String out of it them. If you can, then store it in the name variable."

        name = try container.decode(String.self, forKey: .name)

    ✅ String.self is referring to the String type. You are telling the decoder or encoder what type you are de|encoding.
 */
