//
//  DataManipulationBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 18.05.2024.
//

import SwiftUI

struct CustomerModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class DataManipulationViewModel: ObservableObject {
    @Published var customers: [CustomerModel] = []
    //    @Published var customersSortedByName: [CustomerModel] = []
    @Published var customersSortedByPoints: [CustomerModel] = []
    
    @Published var customersFilteredByPoints: [CustomerModel] = []
    @Published var customersFilteredIsVerified: [CustomerModel] = []
    
    @Published var mappedCustomers: [String] = []
    
    init() {
        getUsers()
        //        sortByName()
        sortByPoints()
        filterByPoints()
        filterByIsVerified()
        mapByName()
    }
    
    func sortByName() {
        // ⚠️
        //            customersSortedByName = customers.sorted { customer1, customer2 in
        //                guard
        //                    let flag1 = customer1.name,
        //                    let flag2 = customer2.name
        //                else {return false}
        //                return customer1.name! > customer2.name!
        //            }
    }
    func sortByPoints() {
        //        customersSortedByPoints = customers.sorted { customer1, customer2 in
        //            return customer1.points > customer2.points
        //        }
        
        //        customersSortedByPoints = customers.sorted(by: {$0.points > $1.points })
        
        customersSortedByPoints = customers.sorted { $0.points > $1.points }
    }
    func filterByPoints() {
        //        customersFilteredByPoints = customers.filter({ (customer) in
        //            return customer.points > 50
        //        })
        customersFilteredByPoints = customers.filter({$0.points > 50})
    }
    func filterByIsVerified() {
        //        customersFilteredIsVerified = customers.filter({ (customer) in
        //            return customer.isVerified
        //        })
        
        //        customersFilteredIsVerified = customers.filter({ $0.isVerified})
        
        customersFilteredIsVerified = customers.filter { $0.isVerified }
    }
    func mapByName() {
        //        mappedCustomers = customers.map({ (customer) in
        //            return customer.name ?? " "
        //        })
        
        // mappedCustomers = customers.map { $0.name ?? " " }
        
        
        mappedCustomers = customers
            .sorted(by: { $0.points > $1.points })
            .filter({ $0.isVerified })
        // Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
            .compactMap({ $0.name })
    }
    
    func getUsers() {
        let user1 = CustomerModel(name: "Nick", points: 5, isVerified: true)
        let user2 = CustomerModel(name: "Chris", points: 0, isVerified: false)
        let user3 = CustomerModel(name: nil, points: 20, isVerified: true)
        let user4 = CustomerModel(name: "Emily", points: 50, isVerified: false)
        let user5 = CustomerModel(name: "Samantha", points: 45, isVerified: true)
        let user6 = CustomerModel(name: "Jason", points: 23, isVerified: false)
        let user7 = CustomerModel(name: "Sarah", points: 76, isVerified: true)
        let user8 = CustomerModel(name: nil, points: 45, isVerified: false)
        let user9 = CustomerModel(name: "Steve", points: 1, isVerified: true)
        let user10 = CustomerModel(name: "Amanda", points: 100, isVerified: false)
        let user11 = CustomerModel(name: "Zara", points: 99, isVerified: true)
        self.customers.append(contentsOf: [ user1, user2, user3, user4, user5,
                                            user6,
                                            user7,
                                            user8,
                                            user9,
                                            user10,
                                            user11
                                          ])
    }
}

struct DataManipulationBootcamp: View {
    
    @StateObject var vm: DataManipulationViewModel = DataManipulationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(vm.mappedCustomers, id: \.self) { name in
                    Text(name)
                        .font(.headline)
                    
                }
                //                ForEach(vm.customersFilteredByPoints) { customer in
                //                    VStack(alignment: .leading) {
                //                        if let reliableData = customer.name {
                //                            Text(reliableData)
                //                                .font(.headline)
                //                        }
                //                        HStack {
                //                            Text("Points: \(customer.points)")
                //                            Spacer()
                //                            if customer.isVerified {
                //                                Image(systemName: "flame.fill")
                //                            }
                //                        }
                //                    }
                //                    .foregroundStyle(.white)
                //                    .padding()
                //                    .background(.blue, in: RoundedRectangle(cornerRadius: 12.0))
                //                    .padding(.horizontal)
                //                }
            }
        }
    }
}

#Preview {
    DataManipulationBootcamp()
}

/*
    🔴 sorted()
        → Returns the elements of the sequence, sorted.

     let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
     let sortedStudents = students.sorted()
     print(sortedStudents)
     ✅ ["Abena", "Akosua", "Kofi", "Kweku", "Peter"]

    var numbers = [2, 144, 3, 5, 89, 13, 21, 1, 34, 8, 1, 55, 0]
     let ascendingNumbers = numbers.sorted(by: <)
     ✅ [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
     let descendingNumbers = numbers.sorted(by:
     ✅ [144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0]


    🔴 sort(by:)
        → Sorts the collection in place, using the given predicate as the comparison between elements.
        → The sort() method sorts the items of an array in a specific order (ascending or descending).
        → array.sort(by: operator)

     var numbers = [1, 3, 8, 5, 2]
     numbers.sort()
     ✅ [1, 2, 3, 5, 8]

     var names = ["Adam", "Jeffrey", "Fabiano", "Danil", "Ben"]
     names.sort(by: >)
     ✅ ["Jeffrey", "Fabiano", "Danil", "Ben", "Adam"]

     func sortItemsByDate(_ items: [TodoItem]) -> [TodoItem] {
         items.sorted { itemA, itemB in
         itemA.date < itemB.date
        }
     }

 
    🔴 filter(_:)
        → Republishes all elements that match a provided closure.
        → The filter() method returns all the elements from the array that satisfy the provided condition.
        → array.filter(condition)

     var numbers = [2, 3, 6, 9]
     var result = numbers.filter({ $0 > 5})
     ✅ [6, 9]

     var numbers = [2, 4, 5, 7, 8, 9]
     var result = numbers.filter({ $0 % 2 == 0 })
     ✅ [2, 4, 8]


     var languages = ["Swedish", "Nepali", "Slovene", "Norwegian"]
     var result = languages.filter( { $0.hasPrefix("N") } )
    ✅ ["Nepal", "Norwegian"]


     let numbers: [Int] = [1, 2, 3, 4, 5]
     cancellable = numbers.publisher
         .filter { $0 % 2 == 0 }
         .sink { print("\($0)", terminator: " ") }

    🔴 map(_:)
        → Returns an array containing the results of mapping the given closure over the sequence’s elements.
        → The map() method transforms the array by applying the same operation to each element in the array.
        → array.map(transform)

     var numbers = [1, 2, 3, 4]
     var result = numbers.map({ $0 + 2})
     ✅ [3, 4, 5, 6]

     var numbers = [1, 2, 3]
     var result = numbers.map { $0 * 3 }
     ✅ [3, 6, 9]

     var languages = ["swift", "java", "python"]
     var result = languages.map { $0.uppercased() }
     ✅ ["SWIFT", "JAVA", "PYTHON"]
 */
