//
//  DownloadingJSONBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 23.05.2024.
//

import SwiftUI

/*
    ✅ To be able to accommodate the relevant JSON data in our application, we need to create a model to represent the relevant JSON data.
    ✅ That is why the Jaskier struct must conform to the “Codable” protocol.
    ✅ In this particular case it will conform to the “Identifiable” protocol too because it has an “id” property so we can use ForEach later in code to display all users in a list.
 
    Jaskier -> a random name
 */
struct Jaskier: Codable, Identifiable {
    
    let id: UUID
    
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
}
struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}


// ... ⬛️
class DownloadingJSONViewModel: ObservableObject {
    
    @Published var jaskiers: [Jaskier] = []
    
    func loadJaskiers() async {
        guard let downloadedJaskiers = await downloadJaskiers() else { return }
        self.jaskiers = downloadedJaskiers
    }
    
    // → create a function that does the networking and returns an array of users[]
    // → then assign the result to the @Published variable called “jaskiers”.
    // → downloadJaskiers() function is marked “async” because retrieving data might take some time.
    func downloadJaskiers() async -> [Jaskier]? {
        /*
            🔴 URL
                → A uniform resource locator (URL) is the address of a specific webpage or file (such as video, image, GIF, etc.) on the internet.
                → A value that identifies the location of a resource, such as an item on a remote server or the path to a local file.
                → You can construct URLs and access their parts.
         */
        
        // ✅ Creating the URL we want to read.
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        /*
            🔴 URLRequest
                → A URL load request that is independent of protocol or URL scheme.
                → URLRequest encapsulates two essential properties of a load request: the URL to load and the policies used to load it.
                → In addition, for HTTP and HTTPS requests, URLRequest includes the HTTP method (GET, POST, and so on) and the HTTP headers.
                → URLRequest only represents information about the request.
            ❗️ Use other classes, such as URLSession, to send the request to a server.
         */
        var request = URLRequest(url: url)
        
        // → httpMethod is “GET” because we are retrieving data from the internet
        request.httpMethod = "GET"
        
        /*
            🔴 .addValue()
                Adds a value to the header field.
                    value → The value for the header field.
                    field → The name of the header field. In keeping with the HTTP RFC, HTTP header field names are case insensitive.
         */
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // → A type that can decode itself from an external representation.
        // → (bytes to object)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        
        // ✅ Fetching the data for that URL.
        // → Run that request and process the response.
        do {
            /*
                🔴 URLSession
                    → An object that coordinates a group of related, network data transfer tasks.
                    → The URLSession class and related classes provide an API for downloading data from and uploading data to endpoints indicated by URLs.
             
                    → Our work is being done by the data(from:) method, which takes a URL and returns the Data object at that URL.
                    → This method belongs to the URLSession class.
                    → The return value from data(from:) is a tuple containing the data at the URL and some metadata describing how the request went.
                    → We don’t use the metadata, but we do want the URL’s data, hence the underscore(_)
             */
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // ✅ Decoding the result of that data into a Response struct.
            let decodedData = try decoder.decode([Jaskier].self, from: data)
            // → Handle the result
            return decodedData
        } catch {
            // → So, if our download succeeds our data constant will be set to whatever data was sent back from the URL,
            // → but if it fails for any reason our code prints “Invalid data” and does nothing else.
            print("Invalid data")
            print("Check out failed: \(error.localizedDescription)")
        }
        return nil;
    }
}


// ... ⬛️
struct DownloadingJSONBootcamp: View {
    
    @StateObject var vm: DownloadingJSONViewModel = DownloadingJSONViewModel()
    
    var body: some View {
        List {
            VStack {
                ForEach(vm.jaskiers) { jaskier in
                    Text(jaskier.name)
                }
            }
        }
        .task {
            await vm.loadJaskiers()
        }
    }
}

#Preview {
    DownloadingJSONBootcamp()
}
