# 🚧 SwiftUI
Kaynak/Reference: [Swiftful Thinking](https://www.youtube.com/@SwiftfulThinking/videos)

> - ⚙️ [Custom Models](./SwiftfulThinkingContinuedLearning/ModelBootcamp.swift)
>  > Building a custom data type
> - ⚙️ [ObservableObject Protocol](./SwiftfulThinkingContinuedLearning/ObservableObjectBootcamp.swift)
>  > State management 1
> - ⚙️ [StateObject and ObservedObject](./SwiftfulThinkingContinuedLearning/StateObjectAndObservedObjectBootcamp.swift)
>  > State management 2
> - ⚙️ [ViewModel](./SwiftfulThinkingContinuedLearning/ViewModelBootcamp.swift)
>  > State management 3, Custom model, Identifiable Protocol, ViewModel, ObservableObject Protocol, @Published, init(){}, @StateObject, @ObservedObject
> - ⚙️ [EnvironmentObject](./SwiftfulThinkingContinuedLearning/EnvironmentObjectBootcamp.swift)
>  > State management 4, @EnvironmentObject, .environmentObject()
> - ⚙️ [AppStorage](./SwiftfulThinkingContinuedLearning/AppStorageBootcamp.swift)
>  > @AppStorage()
> - ⚙️ [Review](./SwiftfulThinkingContinuedLearning/OnboardingViews)
>  > We will create a fake user onboarding experience in which a user can sign up, add their name, age, gender, and then log in to our application. In this example we will focus on persisting the data with @AppStorage and making beautiful animations with the .transition modifier.
> - ⚙️ [Essential Protocols](./SwiftfulThinkingContinuedLearning/EssentialProtocolsBootcamp.swift)
>  > Identifiable, Equatable, Comparable, and Hashable Protocols
> - ⚙️ [Core Data](./SwiftfulThinkingContinuedLearning/CoreDataBootcamp.swift)
>  > Creating a Core Data model, Adding entities, Setting the properties of these entities
> - ⚙️ [Core Data 2](./SwiftfulThinkingContinuedLearning/CoreDataBootcamp.swift)
>  > Setting up a Core Data stack, Initialize a Persistent Container
> - ⚙️ [Core Data 3](./SwiftfulThinkingContinuedLearning/Root/SwiftfulThinkingContinuedLearningApp.swift)
>  > Inject the managed object context
> - ⚙️ [Core Data 4](./SwiftfulThinkingContinuedLearning/ContentView.swift)
>  > Data manipulations in Core Data
> - ⚙️ [Core Data 5](https://github.com/enesozmus/iSchool)
>  >  Entity relationships, predicates, and delete rules in Core Data
>  - ⚙️ [Background Threads](./SwiftfulThinkingContinuedLearning/BackgroundThreadBootcamp.swift)
>  > DispatchQueue, DispatchQueue.main.async { }, .global(qos:), .async, Thread.isMainThread, Thread.current, .background, .userInteractive, .userInitiated 
>  - ⚙️ [Automatic Reference Counting](./SwiftfulThinkingContinuedLearning/AutomaticReferenceCountingBootcamp.swift)
>  > How ARC works
>  - ⚙️ [Strong Reference Cycles](./SwiftfulThinkingContinuedLearning/StrongReferenceCyclesBootcamp.swift)
>  > Strong reference cycles between class instances and Resolving strong reference cycles between class instances
>  - ⚙️ [Weak References](./SwiftfulThinkingContinuedLearning/WeakReferencesBootcamp.swift)
>  > weak, weak self
>  - ⚙️ [Typealias](./SwiftfulThinkingContinuedLearning/TypealiasBootcamp.swift)
>  > typealias name = existing type, typealias CompletionHandler = (Int)->(String)
>  - ⚙️ [Escaping Closures](./SwiftfulThinkingContinuedLearning/EscapingBootcamp.swift)
>  > @escaping, [weak self], self?
>  - ⚙️ [JSONSerialization](./SwiftfulThinkingContinuedLearning/JSONSerializationBootcamp.swift)
>  > JSON, Why Is JSON Used?, Modeling relevant JSON data, JSONSerialization, .jsonObject(with:options:), .data(withJSONObject:options:)
>  - ⚙️ [Introduction To Codable 1](./SwiftfulThinkingContinuedLearning/IntroductionToCodableBootcamp.swift)
>  > JSON, Why Is JSON Used?, Modeling relevant JSON data, Codable (type alias) Decodable and Encodable protocols, protocol Decoder, protocol Encoder, JSONDecoder(), JSONEncoder(), container.decode(_:from:), container.encode(_:), CodingKeys, decoder.container(keyedBy:), encoder.container(keyedBy:)
>  - ⚙️ [Introduction To Codable 2](./SwiftfulThinkingContinuedLearning/IntroductionToCodableBootcamp2.swift)
>  > Modeling relevant JSON data, Codable, JSONDecoder(), JSONEncoder(), container.decode(_:from:), container.encode(_:)
>  - ⚙️ [Downloading some JSON from the Internet 1](./SwiftfulThinkingContinuedLearning/DownloadingJSONBootcamp.swift)
>  > Modeling relevant JSON data, Codable, @Published, URL(), URLRequest(), JSONDecoder(), URLSession, asyn/await, .task {}
>  - ⚙️ [Downloading some JSON from the Internet 2](./SwiftfulThinkingContinuedLearning/DownloadWithEscapingBootcamp.swift)
>  > Downloading JSON from an API using completionHandler and @escaping
>  - ⚙️ [URL Loading System and URLSession Class in Swift](./SwiftfulThinkingContinuedLearning/URLLoadingBootcamp.swift)
>  > URL, URLSession, URLSession.shared, URLSessionDataTask, Handling Data, Responses and Errors, URLSessionUploadTask, URLSessionDownloadTask, Managing Sessions, Task Lifecycle Management, Background Sessions, Handling Background Events, Handling Cookies and Sessions, Error Handling and Debugging, Concurrency and DispatchQueues, Grand Central Dispatch Integration, Authentication and Security, URLSessionConfiguration
>  - ⚙️ [Downloading JSON from an API using Combine framework](./SwiftfulThinkingContinuedLearning/DownloadWithCombineBootcamp.swift)
>  > URLSession, URLSession.shared, URLSession.shared.dataTaskPublisher(for:), .receive(on:options:), .tryMap(), .decode(type:decoder:), .replaceError(with:), .sink(receiveValue:), .store(in: &self.cancellables):
>  - ⚙️ [Timer and onReceive()](./SwiftfulThinkingContinuedLearning/TimerBootcamp.swift)
>  > Timer, .publish(), .autoconnect(), onReceive(publisher:perform:)
>  - ⚙️ [Publishers and Subscribers in Combine](./SwiftfulThinkingContinuedLearning/SubscriberBootcamp.swift)
>  > Publishers and Subscribers, Timer, .publish(), .autoconnect(), .sink{}, .debounce(for:scheduler:options:), .map(:), .combineLatest(:), .store(in: &self.cancellables):, AnyCancellable
>  - ⚙️ [File Manager](./SwiftfulThinkingContinuedLearning/FileManagerBootcamp.swift)
>  > Managing data and images via File Manager
>  - ⚙️ [Caching Images](./SwiftfulThinkingContinuedLearning/CachingImagesBootcamp.swift)
>  > Caching images in the assets folder
>  - ⚙️ [Downloading and saving images](./SwiftfulThinkingContinuedLearning/DownloadingImages.swift)
>  > Downloading and saving images using Codable, Combine Framework, Background threads, FileManager and NSCache
