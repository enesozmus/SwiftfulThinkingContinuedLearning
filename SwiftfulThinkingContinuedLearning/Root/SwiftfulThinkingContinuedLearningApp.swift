//
//  SwiftfulThinkingContinuedLearningApp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 14.05.2024.
//

import SwiftUI

@main
struct SwiftfulThinkingContinuedLearningApp: App {
    
    // 🚨 Create an observable instance of the Core Data stack.
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            // 🚨 Inject the persistent container's managed object context
            // into the environment.
                //.environment(\.managedObjectContext,
                              //coreDataStack.persistentContainer.viewContext)
            
            //AppStorageBootcamp()
            //IntroView()
            //BackgroundThreadBootcamp()
            //WeakReferencesBootcamp()
            //JSONSerializationBootcamp()
            //IntroductionToCodableBootcamp()
            IntroductionToCodableBootcamp2()
        }
    }
}

/*
    🔴 Managed object contexts
        → The third piece of the Core Data puzzle: managed object contexts.
        → These are effectively the “live” version of your data – when you load objects and change them, those changes only exist in memory until you specifically save them back to the persistent store.
        → So, the job of the view context is to let us work with all our data in memory, which is much faster than constantly reading and writing data to disk. When we’re ready we still do need to write changes out to persistent store if we want them to be there when our app runs next, but you can also choose to discard changes if you don’t want them.
 */
