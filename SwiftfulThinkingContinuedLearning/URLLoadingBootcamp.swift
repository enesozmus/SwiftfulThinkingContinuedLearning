//
//  URLLoadingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 23.05.2024.
//

import SwiftUI

struct URLLoadingBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    URLLoadingBootcamp()
}

/*
    Reference: https://elamir.medium.com/mastering-urlsession-in-swift-a-comprehensive-guide-d3a3aa740f6e

    → Embarking on the journey of Swift development means navigating the intricate landscape of networking, where URLSession emerges as a steadfast companion.
    → In the ever-evolving ecosystem of iOS and macOS app development, the need for robust and efficient networking solutions is undeniable.
    → In this exploration of URLSession, we not only unravel the core concepts but embark on a hands-on journey by integrating it into a full-fledged MVVM architecture.
    → Welcome to “Mastering URLSession in Swift: A Comprehensive Guide.”
    → As we navigate through the intricacies of URLSession, we’ll weave its capabilities into the fabric of an MVVM structure, demonstrating how to elegantly handle network requests, manage states, and seamlessly integrate networking into your projects.

    🔴 URL Loading System
        → Interact with URLs and communicate with servers using standard Internet protocols.
        → The URL Loading System provides access to resources identified by URLs, using standard protocols like https or custom protocols you create.
        → Loading is performed asynchronously, so your app can remain responsive and handle incoming data or errors as they arrive.
        ⭕️ You use a URLSession instance to create one or more URLSessionTask instances, which
            1️⃣ can fetch and return data to your app,
            2️⃣ can download files,
            3️⃣ or can upload data and files to remote locations.
        → To configure a session, you use a URLSessionConfiguration object, which controls behavior like how to use caches and cookies, or whether to allow connections on a cellular network.

    🔴 URL
        → A uniform resource locator (URL) is the address of a specific webpage or file (such as video, image, GIF, etc.) on the internet.
        → A value that identifies the location of a resource, such as an item on a remote server or the path to a local file.

    🔴 URLSession
        → In the expansive landscape of networking, URLSession emerges as a stalwart ally, simplifying the intricacies of making network requests in Swift.
        ❓ What is URLSession?
        → URLSession is a part of the Foundation framework, offering a set of APIs for making HTTP and HTTPS requests.
        → The URLSession class and related classes provide an API for downloading data from and uploading data to endpoints indicated by URLs.
        → An object that coordinates a group of related, network data transfer tasks.
        → It provides a comprehensive suite of tools to interact with web services, fetch data, and perform tasks like file uploads and downloads.

    🔴 Creating URLSession Instances
        🟡 URLSession.shared
            → A shared singleton instance that’s suitable for most use cases.
            → For basic requests, the URLSession class provides a shared singleton session object that gives you a reasonable default behavior for creating tasks.
        🟡 Custom Instances
            → Creating your own instances allows for more customization, such as configuring timeouts and caching policies.

    🔴 URLSessionConfiguration
        → URLSessionConfiguration plays a pivotal role in configuring the behavior of URLSession instances.
        → It encompasses settings like caching policies, timeout intervals, and the ability to allow or restrict certain types of network requests.

    🔴 URLSessionDataTask
        → As we embark on our exploration of URLSession, let’s start by demystifying the process of making simple GET requests using URLSessionDataTask.
        → This essential component of URLSession empowers us to retrieve data from a specified URL seamlessly.
 
    🔴 Creating a URLSessionDataTask
        → To initiate a basic data task, we use the dataTask(with:completionHandler:) method of URLSession.
        → This method takes a URL and a completion handler as parameters, allowing us to handle the data, response, and any errors that might occur during the request.
 
    🔴 Handling Data, Responses and Errors
        1️⃣ data → The data returned by the server.
        2️⃣ response → The response parameter in the completion handler provides metadata about the response, such as status code and headers. An object that provides response metadata, such as HTTP headers and status code. If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
        3️⃣ error → The error parameter allows us to gracefully handle any errors that might occur during the network request. An error object that indicates why the request failed, or nil if the request was successful.

    🔵 Example: Creating a URLSessionDataTask for a GET request
            
            🔵
             if let url = URL(string: "https://api.example.com/data") {
                 let task = URLSession.shared.dataTask(with: url) { data, response, error in
                     if let error = error {
                         // Handle the error
                         print("Error: \(error.localizedDescription)")
                     } else if let data = data {
                         // Process the data
                         print("Data received: \(data)")
                     }
                 }
                 task.resume()
             }
            🔵
            guard let url = getUrl() else {return}
         
             URLSession.shared.dataTaskPublisher(for: url)
                 .receive(on: DispatchQueue.main)
                 .tryMap(handleOutput)
                 .decode(type: [PostModel].self, decoder: JSONDecoder())
                 .replaceEmpty(with: [])
                 .sink { (completion)  in
                     switch completion{
                     case .finished:
                         print("SUCESS")
                     case .failure(let error):
                         print("FAILURE")
                         print(error.localizedDescription)
                     }
                 } receiveValue: { [weak self] (returnedPosts) in
                     self?.posts = returnedPosts
                 }
                 .store(in: &cancellables)
            🔵
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
 
             URLSession.shared.dataTaskPublisher(for: url)
                 //.subscribe(on: DispatchQueue.global(qos: .background))
                 .receive(on: DispatchQueue.main)
                 .tryMap(handleOutput)
                 .decode(type: [PostModel].self, decoder: JSONDecoder())
                 .replaceError(with: [])
                 .sink(receiveValue: { [weak self] (returnedPosts) in
                     self?.posts = returnedPosts
                 })
                 .store(in: &cancellables)
 */

/*
    🔴 URLSessionUploadTask and URLSessionDownloadTask
        → These tasks open the door to more complex scenarios, enabling the seamless exchange of data between your app and external servers.
        → With URLSessionUploadTask, you can easily upload data to a server. This is particularly useful when dealing with scenarios like submitting forms or uploading user-generated content.
 
             if let url = URL(string: "https://api.example.com/upload") {
                 var request = URLRequest(url: url)
                 request.httpMethod = "POST"
                 
                 let dataToUpload = "Hello, Server!".data(using: .utf8)
                 
                 let task = URLSession.shared.uploadTask(with: request, from: dataToUpload) { data, response, error in
                     // Handle the response or error
                 }
                 task.resume()
             }
 
    → When dealing with large files, such as images or documents, URLSessionDownloadTask comes to the rescue. It allows you to efficiently download and save files to the local file system.
 
             if let url = URL(string: "https://example.com/image.jpg") {
                 let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
                     if let localURL = localURL {
                         // Move the downloaded file to a desired location
                         let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent("downloadedImage.jpg")
                         try? FileManager.default.moveItem(at: localURL, to: destinationURL)
                     }
                 }
                 task.resume()
             }
 */

/*
    🔴 Managing Sessions
        → As we advance in our exploration of URLSession, it’s essential to understand how to manage sessions effectively.
        → URLSession provides mechanisms to control, suspend, resume, and cancel tasks, ensuring that your app can handle various scenarios gracefully.
    🔴 Task Lifecycle Management
        → URLSession tasks transition through states such as suspended, resumed, and completed.
        → Understanding these states is crucial for managing tasks effectively.
        → Understanding how to manipulate task states and cancel tasks is crucial for optimizing network requests and ensuring a smooth user experience.
            0️⃣ Suspend the task
                task.suspend()
            1️⃣ Resume the suspended task
                task.resume()
            2️⃣ Cancel the task
                task.cancel()
 */

/*
    🔴 Background Sessions
        → Background sessions are particularly beneficial for scenarios like downloading large files, syncing content, or performing periodic updates.
        → These sessions continue to execute tasks in the background, providing a seamless user experience.
        → Configure a background session using a unique identifier.

             let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "com.example.backgroundSession")
             let backgroundSession = URLSession(configuration: backgroundConfiguration, delegate: self, delegateQueue: nil)

             let task = backgroundSession.downloadTask(with: url)
             task.resume()
 
    🔴 Handling Background Events
        → By incorporating background sessions into your URLSession repertoire, you empower your app to provide a seamless and responsive user experience, even when network tasks extend beyond the confines of the foreground.
        → Implement the urlSession(_:downloadTask:didFinishDownloadingTo:) delegate method to handle downloaded files when the app is in the background.
        → URLSession invokes this method when a background task completes.

             // Example: Handling Download Completion in the Background
             func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
                 // Process the downloaded file
             }
 
    🔴 Handling Cookies and Sessions
        → In the intricate dance of web communication, cookies play a crucial role in maintaining state and preserving user sessions.
        → URLSession seamlessly manages cookies, ensuring the persistence of user-related information across multiple network requests.
        → Understanding how URLSession handles cookies is crucial for applications that rely on maintaining user sessions and persisting state across various network interactions.
    🟡 Automated Cookie Handling
        → URLSession automatically handles cookies for you, storing and sending them as needed.
        → Cookies received in a response are automatically included in subsequent requests to the same domain.
    🟡 Managing Sessions and State
        → Cookies play a pivotal role in maintaining user sessions.
        → They carry information such as authentication tokens or user preferences.
        → URLSession, by default, maintains a session’s state, preserving cookies and ensuring continuity across requests.
    🟡 Customizing Cookie Storage
        → While URLSession automates cookie handling, you can customize this process by providing your own HTTPCookieStorage.
        → This allows for more fine-grained control over which cookies are stored and sent.

             // Example: Customizing Cookie Storage
             let configuration = URLSessionConfiguration.default
             let cookieStorage = HTTPCookieStorage.shared
             let customCookieStorage = CustomCookieStorage() // Your custom cookie storage class
             configuration.httpCookieStorage = customCookieStorage

             let session = URLSession(configuration: configuration)
 */

/*
    🔴 Error Handling and Debugging
        → In the dynamic landscape of networked applications, robust error handling and effective debugging strategies are indispensable.
        → Network requests can encounter various errors, such as network unavailability, timeouts, or server-side issues.
        → Understanding common errors is essential for providing meaningful feedback to users and maintaining a smooth user experience.
        → URLSession provides error information in the completion handler of tasks, allowing you to inspect and respond to issues.
        → Common error types include network connectivity issues, server errors, and timeouts.

             // Example: Handling Errors in URLSession
             let task = URLSession.shared.dataTask(with: url) { data, response, error in
                 if let error = error {
                     switch (error as NSError).code {
                     case NSURLErrorNetworkConnectionLost:
                         // Handle network connection lost
                     case NSURLErrorTimedOut:
                         // Handle timeout
                     default:
                         // Handle other errors
                     }
                 }
             }
             task.resume()

    🟡 Debugging URLSession Interactions
        → Use tools like print statements, breakpoints, and logging to debug URLSession interactions.
        → Leverage Xcode’s network debugging tools to inspect request and response details.
        → Understanding how to handle errors gracefully and employing effective debugging techniques empowers you to build robust and resilient networking components in your app.
 */

/*
    🔴 Concurrency and DispatchQueues
        → Efficiently managing concurrency is a cornerstone of building responsive and performant applications.
        → URLSession inherently operates asynchronously, ensuring that networking tasks don’t block the main thread.
        → Asynchronous networking prevents the app’s UI from freezing, providing a responsive experience for users.
        → URLSession seamlessly integrates with Grand Central Dispatch (GCD), allowing you to execute network requests concurrently and asynchronously without compromising the user experience.
    🟡 Grand Central Dispatch Integration
        → Use GCD to perform networking tasks concurrently with other operations.
        → Leverage DispatchQueue to execute tasks on different threads, enhancing parallelism.
        ❗️ Avoid blocking the main thread with synchronous network requests to prevent UI freezes.
        ❗️  Consider using background queues for time-consuming tasks, ensuring a responsive user interface.
        ✅ Understanding how to harness the power of concurrency with GCD and URLSession enhances the responsiveness and efficiency of your app.

             // Example: Using DispatchQueue with URLSession
             let url = URL(string: "https://api.example.com/data")

             // Create a background queue
             let backgroundQueue = DispatchQueue.global(qos: .background)

             backgroundQueue.async {
                 let task = URLSession.shared.dataTask(with: url) { data, response, error in
                     // Handle the response or error
                 }
                 task.resume()
             }
 */

/*
    🔴 Authentication and Security
        → In the ever-evolving landscape of networked applications, handling authentication challenges and ensuring robust security measures is paramount.
        → When a server requires authentication, URLSession invokes the URLAuthenticationChallenge delegate method.
        → Here, you can provide credentials or handle the challenge in a custom manner.

             func urlSession(
                 _ session: URLSession,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
             ) {
                 if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
                     let credential = URLCredential(user: "username", password: "password", persistence: .forSession)
                     completionHandler(.useCredential, credential)
                 } else {
                     // Handle other authentication methods or cancel the challenge
                     completionHandler(.cancelAuthenticationChallenge, nil)
                 }
             }
 */
