//
//  JSONSerialization.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI


// 🚨 What's really cool thing about Codable is that it does all of this for us on its own.

// ... ⬛️
struct CondradModel: Identifiable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}


// ... ⬛️
class JSONSerializationViewModel: ObservableObject {
    
    @Published var customer: CondradModel? = nil
    
    init() {
        getData()
    }
    // ... 🟦
    func getData() {
        guard let returnedData = getJSONData() else { return }
        
        //        print(".............")
        //        // ✅ 58 bytes
        //        print(returnedData)
        
        //        let jsonString: String? = String(data: returnedData, encoding: .utf8)
        //        // ✅ Optional("{\"name\":\"Emily\",\"id\":\"111\",\"points\":100,\"isPremium\":false}")
        //        print(jsonString)
        
        // 🚨 yes a lot of work
        // 🚨 What's really cool thing about Codable is that it does all of this for us on its own.
        if
            let localData: Any = try? JSONSerialization.jsonObject(with: returnedData, options: []),
            let dictionary: [String: Any] = localData as? [String:Any],
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let points = dictionary["points"] as? Int,
            let isPremium = dictionary["isPremium"] as? Bool {
            
            let newCustomer = CondradModel(id: id, name: name, points: points, isPremium: isPremium)
            customer = newCustomer
        }
    }
    
    // To simulate downloading data from the Internet
    func getJSONData() -> Data? {
        // fake json data
        let dictionary: [String:Any] = [
            "id" : "12345",
            "name" : "Joe",
            "points" : 5,
            "isPremium" : true
        ]
        // convert to json
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData;
    }
}


// ... ⬛️
struct JSONSerializationBootcamp: View {
    
    @StateObject var vm: JSONSerializationViewModel = JSONSerializationViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

#Preview {
    JSONSerializationBootcamp()
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
    🔴 JSONSerialization
        → An object that converts between JSON and the equivalent Foundation objects.
        → You use the JSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON.
        → If you want to parse JSON by hand rather than using Codable, iOS has a built-in alternative called JSONSerialization.

    🔴 .jsonObject(with:options:)
        → Returns a Foundation object from given JSON data.

    🔴 .data(withJSONObject:options:)
        → Returns JSON data from a Foundation object.
 */
