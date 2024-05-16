//
//  EnvironmentObjectBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 15.05.2024.
//

import SwiftUI

class OurViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    init() {
        getData()
    }
    
    func getData() {
        self.dataArray.append(contentsOf: ["iPhone", "iPad", "iMac", "Apple Watch"])
    }
    
    
}

struct EnvironmentObjectBootcamp: View {
    @StateObject var viewModel: OurViewModel = OurViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink {
                        DetailView(selectedItem: item)
                    }
                label: {
                    Label(item, systemImage: "folder")
                }
                    
                }
            }
            .navigationTitle("iOS Devices")
        }
        .environmentObject(viewModel)
    }
}

struct DetailView: View {
    let selectedItem: String
    //@ObservedObject var viewModel: OurViewModel
    
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            NavigationLink {
                FinalView()
            } label: {
                Text(selectedItem)
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            }
        }
    }
}

struct FinalView: View {
    
    //@ObservedObject var viewModel: OurViewModel
    @EnvironmentObject var viewModel: OurViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.dataArray, id: \.self) { item in
                        Text(item)
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
            }
            
        }
    }
}

#Preview {
    EnvironmentObjectBootcamp()
}

/*
    🔴 EnvironmentObject
        → A property wrapper type for an observable object that a parent or ancestor view supplies.
        → An environment object invalidates the current view whenever the observable object that conforms to ObservableObject changes.

        🔳 You’ve seen how @State declares simple properties for a type that automatically cause a refresh of the view when it changes, and how @ObservedObject declares a property for an external type that may or may not cause a refresh of the view when it changes.

        → There’s another type of property wrapper available to use, which is @EnvironmentObject.
        → This is a value that is made available to your views through the application itself – it’s shared data that every view can read if they want to.
        → So, if your app had some important model data that all views needed to read, you could either hand it from view to view to view or just put it into the environment where every view has instant access to it.
        → Think of @EnvironmentObject as a massive convenience for times when you need to pass lots of data around your app.
        → Because all views point to the same model, if one view changes the model all views immediately update – there’s no risk of getting different parts of your app out of sync.

    ✅ Use @State for simple properties that belong to a single view. They should usually be marked private.
    ✅ When you have a custom type you want to use that might have multiple properties and methods, or might be shared across multiple views – you will often use @StateObject and @ObservedObject instead.
    ✅ Use @StateObject once for each observable object you use, in whichever part of your code is responsible for creating it.
    ✅ Think of @EnvironmentObject as a massive convenience for times when you need to pass lots of data around your app.
    ❗️ Of the four you will find that @ObservedObject is both the most useful and the most commonly used, so if you’re not sure which to use start there.
 
    🔴 .environmentObject(_:)
        → Supplies an observable object to a view’s hierarchy.
        → Use this modifier to add an observable object to a view’s environment.
        → Adding an object to a view’s environment makes the object available to subviews in the view’s hierarchy.
        → We use send the data into a modifier called environmentObject(), which makes the object available in SwiftUI’s environment for that view plus any others inside it. If you need to add multiple objects to the environment, you should add multiple environmentObject() modifiers – just call them one after the other.
 */
