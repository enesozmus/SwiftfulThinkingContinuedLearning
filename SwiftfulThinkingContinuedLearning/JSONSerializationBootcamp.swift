//
//  JSONSerialization.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI


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
    🔴 JSONSerialization
        → An object that converts between JSON and the equivalent Foundation objects.
        → You use the JSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON.
        → If you want to parse JSON by hand rather than using Codable, iOS has a built-in alternative called JSONSerialization.

    🔴 .jsonObject(with:options:)
        → Returns a Foundation object from given JSON data.

    🔴 .data(withJSONObject:options:)
        → Returns JSON data from a Foundation object.
 */
