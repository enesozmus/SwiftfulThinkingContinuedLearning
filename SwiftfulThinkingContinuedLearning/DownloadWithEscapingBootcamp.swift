//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 23.05.2024.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        //downloadPosts()
        downloadPosts2()
    }
    
    //    func downloadPosts() {
    //        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            guard
    //                let data = data,
    //                error == nil,
    //                let response = response as? HTTPURLResponse,
    //                response.statusCode >= 200 && response.statusCode < 300 else {
    //                print("Error downloading data")
    //                return
    //            }
    //            guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
    //            DispatchQueue.main.async { [weak self] in
    //                self?.posts = newPosts
    //            }
    //
    //        }.resume()
    //    }
    
    func downloadPosts2() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned.")
            }
        }
    }
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
    
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm: DownloadWithEscapingViewModel = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                Text(post.title)
            }
        }
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
