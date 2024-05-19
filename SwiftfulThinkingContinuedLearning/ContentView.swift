//
//  ContentView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 14.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest(sortDescriptors: []) var drivers: FetchedResults<F1Driver>
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ]) var drivers: FetchedResults<F1Driver>
    
    @State private var driverTextField: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                TextField("", text: $driverTextField, prompt: Text("Add driver...").foregroundStyle(.white))
                    .foregroundStyle(.red)
                    .padding(.horizontal)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.yellow.opacity(0.5), in: RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal)
                
                Button {
                    addDriver()
                } label: {
                    Text("Add Driver")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.blue, in: RoundedRectangle(cornerRadius: 25))
                }
                .padding(.horizontal)
                List {
                    ForEach(drivers) { driver in
                        Text(driver.name ?? "Unknown")
                            .onTapGesture {
                                updateDriver(driver: driver)
                            }
                    }
                    .onDelete(perform: deleteDrivers)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addSergio()
                        } label: {
                            Text("Add Sergio")
                        }
                    }
                }
                Button {
                    let _names = ["Lewis Hamilton", "Michael Schumacher", "Max Verstappen", "Sebastian Vettel", "Alain Prost", "Fernando Alonso"]
                    let chosenName = _names.randomElement()!
                    
                    let driver = F1Driver(context: viewContext)
                    driver.id = UUID()
                    driver.name = chosenName
                    
                    try? viewContext.save()
                } label: {
                    Text("Add")
                }
                
            }
        }
    }
    
    private func addDriver() {
        let newDriver = F1Driver(context: viewContext)
        newDriver.id = UUID()
        newDriver.name = driverTextField
        
        saveDrivers()
    }
    private func addSergio() {
        let newDriver = F1Driver(context: viewContext)
        newDriver.id = UUID()
        newDriver.name = "Sergio Perez"
        
        saveDrivers()
        driverTextField = ""
    }
    private func updateDriver(driver: F1Driver) {
        let currentName = driver.name ?? " "
        let newName = currentName + " a"
        driver.name = newName
        saveDrivers()
    }
    private func deleteDrivers(offsets: IndexSet) {
        offsets.map { drivers[$0] }.forEach(viewContext.delete)
        saveDrivers()
    }
    private func saveDrivers() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataStack.shared.persistentContainer.viewContext)
}
