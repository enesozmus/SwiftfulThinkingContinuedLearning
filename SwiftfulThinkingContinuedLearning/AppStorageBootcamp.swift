//
//  AppStorageBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 16.05.2024.
//

import SwiftUI

struct AppStorageBootcamp: View {
    @AppStorage("name") var currentUserName: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(currentUserName ?? "Add Name Here")
            
            if let name = currentUserName {
                Text(name)
            }
            
            Button("Save") {
                let name: String = "Emily"
                //UserDefaults.standard.set(name, forKey: "name")
                currentUserName = name
            }
        }
    }
}

#Preview {
    AppStorageBootcamp()
}

/*
    🔴 AppStorage
        → A property wrapper type that reflects a value from UserDefaults and invalidates a view on a change in value in that user default.
        → SwiftUI has a dedicated property wrapper for reading values from UserDefaults, which will automatically reinvoke your view’s body property when the value changes.
        → That is, this wrapper effectively watches a key in UserDefaults, and will refresh your UI if that key changes.
        → @AppStorage writes your data to UserDefaults, which is not secure storage. As a result, you should not save any personal data using @AppStorage, because it’s relatively easy to extract.

     struct ContentView: View {
         @AppStorage("username") var username: String = "Anonymous"

         var body: some View {
             VStack {
                 Text("Welcome, \(username)!")

                 Button("Log in") {
                     username = "@twostraws"
                 }
             }
         }
     }

    UserDefaults.standard.set("@twostraws", forKey: "username")
    @AppStorage("username", store: UserDefaults(suiteName: "group.com.hackingwithswift.unwrap")) var username: String = "Anonymous"
 */
