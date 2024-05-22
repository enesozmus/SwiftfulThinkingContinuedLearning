//
//  IntroductionToCodable2.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 23.05.2024.
//

import SwiftUI

struct GroceryProduct: Identifiable, Codable {
    let id: UUID
    var name: String
    var points: Int
    var description: String?
}

class IntroductionToCodableViewModel2: ObservableObject {
    
    init() {
        decode()
        encode()
    }
    
    func decode() {
        let json = """
        {
            "id": "8D31B96A-02AC-4531-976F-A455686F8FE2",
            "name": "Emily",
            "points": 600,
            "description": "A fruit with a distinctive scent."
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let product = try? decoder.decode(GroceryProduct.self, from: json)
        guard let returnedData = product else { return }
        print(returnedData.name) // Prints "Emily"
    }
    
    func encode() {
        let pear = GroceryProduct(id: UUID(), name: "Gerald", points: 250, description: "A ripe pear.")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try? encoder.encode(pear)
        guard let returnedData = data else { return }
        print(String(data: returnedData, encoding: .utf8)!)

        /* Prints:
         {
           "id" : "93CD1..........random",
           "name" : "Gerald",
           "points" : 250,
           "description" : "A ripe pear."
         }
        */
    }
}

struct IntroductionToCodableBootcamp2: View {
    
    @StateObject var vm: IntroductionToCodableViewModel2 = IntroductionToCodableViewModel2()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    IntroductionToCodableBootcamp2()
}

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
