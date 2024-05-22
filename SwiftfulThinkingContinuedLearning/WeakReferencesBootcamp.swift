//
//  WeakReferencesBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 22.05.2024.
//

import SwiftUI

struct WeakReferencesBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                WeakReferencesBootcampSecondScreen()
            } label: {
                Text("Navigate")
            }
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}

class WeakReferencesSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        // 🚨 0..1 0..1 0..1 0..1 0..1
        //        DispatchQueue.main.async {
        //            // → This creates a strong reference.
        //            // → While creating a strong reference basically what you're telling the system is that while these tasks are running (this self.) so this class absolutely needs to stay alive.
        //            // 🟢 Right now, this is a very quick task so it wouldn't actuallt be a problem.
        //            // ❗️ But if you were downloading like a lot of data from the internet...
        //            self.data = "NEW DATA!!!!"
        //        }
        
        // 🚨 0..1 1..2 2..3 3..4 4..5
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
        //            self.data = "NEW DATA!!!!"
        //        }
        
        // 🚨 0..1 0..1 0..1 0..1 0..1
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!!"
        }
    }
    
}

struct WeakReferencesBootcampSecondScreen: View {
    
    @StateObject var vm: WeakReferencesSecondScreenViewModel = WeakReferencesSecondScreenViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Arial", size: 32)!]
    }
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

#Preview {
    WeakReferencesBootcamp()
}

/*
    🔴 Weak References
        → A weak reference is a reference that doesn’t keep a strong hold on the instance it refers to, and so doesn’t stop ARC from disposing of the referenced instance.
        → This behavior prevents the reference from becoming part of a strong reference cycle.
        → You indicate a weak reference by placing the weak keyword before a property or variable declaration.

        → Because a weak reference doesn’t keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it.
        → Therefore, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated.
        → And, because weak references need to allow their value to be changed to nil at runtime, they’re always declared as variables, rather than constants, of an optional type.
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
