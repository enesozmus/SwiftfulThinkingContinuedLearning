//
//  DownloadWithCombineBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 24.05.2024.
//

import SwiftUI
import Combine

struct Post: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    // 💚 A set of AnyCancellable objects is created to keep track of any Combine subscriptions that are made during the API call. These subscriptions will be canceled when the API call is completed or canceled.
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine discussion:
        /*
            1. sign up for monthly subscription for package to be delivered
            2. the company would make the package behind the scene
            3. recieve the package at your front door
            4. make sure the box isn't damaged
            5. open and make sure the item is correct
            6. use the item!!!!
            7. cancellable at any time!!
         
            1. create the publisher
            2. subscribe publisher on background thread
            3. recieve on main thread
            4. tryMap (check that the data is good)
            5. decode (decode data into PostModels)
            6. sink (put the item into our app)
            7. store (cancel subscription if needed)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedPosts) in
                // [weak self] -> to prevent strong reference cycles
                // 💚 Handling receiveValue
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
        
        var body: some View {
            List {
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
}

#Preview {
    DownloadWithCombineBootcamp()
}

/*
    🔴 URLSession
        → An object that coordinates a group of related, network data transfer tasks.
        → In the expansive landscape of networking, URLSession emerges as a stalwart ally, simplifying the intricacies of making network requests in Swift.
    ❓ What is URLSession?
        → URLSession is a part of the Foundation framework, offering a set of APIs for making HTTP and HTTPS requests.
        → The URLSession class and related classes provide an API for downloading data from and uploading data to endpoints indicated by URLs.
        → It provides a comprehensive suite of tools to interact with web services, fetch data, and perform tasks like file uploads and downloads.
 
    🔴 Creating URLSession Instances
        🟡 URLSession.shared
            → A shared singleton instance that’s suitable for most use cases.
            → For basic requests, the URLSession class provides a shared singleton session object that gives you a reasonable default behavior for creating tasks.
        🟡 Custom Instances
            → Creating your own instances allows for more customization, such as configuring timeouts and caching policies.
 
    🔴 dataTaskPublisher(for:)
        → Returns a publisher that wraps a URL session data task for a given URL.
        → Performing tasks with URL sessions is inherently asynchronous; it takes time to fetch data from network endpoints, file systems, and other URL-based sources.
        → The URL Loading System accounts for this by delivering results asynchronously to delegates or completion handlers.
        → The Combine framework also handles asynchronicity; using it to process your URL task results simplifies and empowers your code.
        → URLSession offers a Combine publisher, URLSession.DataTaskPublisher, which publishes the results of fetching data from a URL or URLRequest.
        → You create this publisher with the method dataTaskPublisher(for:).
            1️⃣ A tuple that contains the fetched data and a URLResponse, if the task succeeds.
            2️⃣ An error, if the task fails.

        → When using URLSession’s completion handler-based code, you need to do all your work in the handler closure: error-handling, data parsing, and so on.
        → When you instead use the data task publisher, you can move many of these responsibilities to Combine operators.
 */

/*
    🔴 Combine
        → a framework
        → The iOS Combine framework was introduced by Apple in 2019 as part of iOS 13.
        → The Combine framework provides a declarative Swift API for processing values over time.
        →  It allows you to write functional reactive code by providing a declarative Swift API.
        → This means that it allows you to write reactive programming code, which is a popular paradigm for handling asynchronous data streams.
        → Before the Combine framework, iOS developers had to rely on third-party reactive frameworks like RxSwift and ReactiveSwift to write reactive code.
        → However, with the introduction of the Combine framework, iOS developers can now write reactive programming without depending on external libraries.
        → By adopting Combine, you’ll make your code easier to read and maintain, by centralizing your event-processing code and eliminating troublesome techniques like nested closures and convention-based callbacks.
        → If you’ve been trying out SwiftUI, you’ve likely been using Combine quite a lot already. Types like ObservableObject and Property Wrappers like @Published all use Combine under the hood. It’s a powerful framework to dynamically respond to value changes over time.

        → Combine framework is provides a declarative model for handling asynchronous data streams.
        → Examples of these kinds of values include network responses, user interface events, and other types of asynchronous data.
        → This means that we can use the framework’s APIs to handle closures, delegates, KVO, and notifications more efficiently, and transform, filter, and combine data streams in powerful ways.
        → For example, if we need to handle a chain of events, such as waiting for a network request to complete before updating the UI, we can use the Combine framework to write more concise and readable code.

    🔴 How Does Combine Work?
        → Combine is mainly working as publisher and subscriber model.
        → Combine framework works on the basis of following three key concepts
            1️⃣ Publisher
            2️⃣ Subscriber
            3️⃣ Operator

        * Publishers are the same as Observables
        * Subscribers are the same as Observers

    🔴 Publisher
        → a protocol
        → The Publisher is a protocol that defines a value type with two associated types: Output and Failure.
        → Publishers allow the registration of subscribers and emit values to those subscribers.
        → Publishers can be thought of as the source of the data stream.
        → We can create a publisher that emits a value when the network request completes, and subscribe to that publisher to update the UI.
        → The Publisher protocol declares that a type can transmit a sequence of values over time.
        → Publishers have operators to act on the values received from upstream publishers and republish them.
    🔴 Subscriber
        → a protocol
        → The Subscriber is also a protocol, but it is a reference type.
        → Subscribers can receive values from publishers and can be notified when the publisher has finished emitting values.
        → The subscriber has two associated types: Input and Failure.
        → Subscribers can be thought of as the destination of the data stream.
        → The Subscriber protocol declares a type that can receive input from a publisher.
    🔴 Operators
        →  Operators are extensions of publishers.
        → Operators are methods that are called by the publisher and return a value to the publisher.
        → There may be multiple operators for a single publisher, allowing for complex data transformations and manipulations.
 
    ⚫️ Convert incoming raw data to your types with Combine operators
        → When a data task completes successfully, it delivers a block of raw Data to your app.
        → Most apps need to convert this data to their own types.
        → Combine provides operators to perform these conversions, allowing you to declare a chain of processing operations.
 
    🟡 receive(on:options:)
        → This is a Combine operator that specifies the scheduler on which to receive the value.
        → In this case, it specifies the main thread’s RunLoop, which is necessary for updating the user interface.
        → When moving data downloaded from a background thread to a local location, it must be done on the main thread.
        → Use receive(on:options:) to specify how you want later operators in the chain and your subscriber, to schedule the work.
        → DispatchQueue and RunLoop both implement Combine’s Scheduler protocol, so you can use them to receive URL session data.
        → The following snippet ensures that the sink logs its results on the main dispatch queue.

             cancellable = urlSession
                 .dataTaskPublisher(for: url)
                 .receive(on: DispatchQueue.main)
                 .sink(receiveCompletion: { print ("Received completion: \($0).") },
                       receiveValue: { print ("Received data: \($0.data).")})
 
    🟡 map(_:), tryMap(_:)
        → The data task publisher produces a tuple that contains a Data and a URLResponse.
        → You can use the map(_:) operator to convert the contents of this tuple to another type.
        → If you want to inspect the response before inspecing the data, use tryMap(_:) and throw an error if the response is unacceptable.
        → A closure that handles the data from where you subscribed.
        → In this case, it checks the HTTP status code of the response and throws an error if it is not in the 200–299 range: If there is not any error, it emit data.
 
    🟡 decode(type:decoder:)
        → To convert raw data to your own types that conform to the Decodable protocol, use Combine’s decode(type:decoder:) operator.

                 struct User: Codable {
                     let name: String
                     let userID: String
                 }
 
                 let url = URL(string: "https://example.com/endpoint")!
 
                 cancellable = urlSession
                     .dataTaskPublisher(for: url)
                     .tryMap() { element -> Data in
                         guard let httpResponse = element.response as? HTTPURLResponse,
                             httpResponse.statusCode == 200 else {
                                 throw URLError(.badServerResponse)
                             }
                         return element.data
                         }
                     .decode(type: User.self, decoder: JSONDecoder())
                     .sink(receiveCompletion: { print ("Received completion: \($0).") },
                           receiveValue: { user in print ("Received user: \(user).")})
 
    🟡 catch(_:)
        → You can also use Combine operators to replace the error, rather than letting it reach the subscriber.
        → catch(_:) replaces the error with another publisher.
        → You can use this with another URLSession.DataTaskPublisher, such as one that loads data from a fallback URL.

    🟡 replaceError(with:)
        → replaceError(with:) replaces the error with an element you provide.
        → If it makes sense in your application, you can use this to provide a substitute for the value you expected to load from the URL.

        → The following example shows both of these techniques, retrying a failed request once, and using a fallback URL after that.
        → If either the original request, the retry, or the fallback request succeeds, the sink(receiveValue:) operator receives data from the endpoint.
        → If all three fail, the sink receives a Subscribers.Completion.failure(_:).

                     let pub = urlSession
                         .dataTaskPublisher(for: url)
                         .retry(1)
                         .catch() { _ in
                             self.fallbackUrlSession.dataTaskPublisher(for: fallbackURL)
                         }
                     cancellable = pub
                         .sink(receiveCompletion: { print("Received completion: \($0).") },
                               receiveValue: { print("Received data: \($0.data).") })
 
    🟡 sink(receiveValue:)
        → This is a Combine operator that creates a subscriber to receive the publisher’s values and errors.
        → Check success/failure depending on whether is completed.
            1️⃣ receiveValue -> If successful, you can receive.
            2️⃣ failure(throw) -> otherwise will give an error.
        → Use sink(receiveValue:) to observe values received by the publisher and print them to the console.
        → This operator can only be used when the stream doesn’t fail, that is, when the publisher’s Failure type is Never.
        → Attaches a subscriber with closure-based behavior to a publisher that never fails.
 
    🟡 store(in: &self.cancellables):
        → This is a method of AnyCancellable that adds the subscription to the cancellables set.
        → This allows the subscription to be canceled later if needed.
 
    🟡 retry(_:)
        → Any app that uses the network should expect to encounter errors, and your app should handle them gracefully.
        → Because transient network errors are fairly common, you may want to immediately retry a failed data task.
        → With URLSession’s completion handler idiom, you need to create a whole new task to perform a retry.
        → With the data task publisher, you can instead use Combine’s retry(_:) operator.
        → This handles errors by recreating the subscription to the upstream publisher a specified number of times.
        → However, since network operations are expensive, only retry a small number of times, and ensure all requests are idempotent.
 */
