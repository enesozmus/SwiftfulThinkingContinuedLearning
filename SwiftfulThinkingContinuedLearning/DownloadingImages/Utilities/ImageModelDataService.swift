//
//  ImageModelDataService.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import Combine
import Foundation

class ImageModelDataService {
    
    static let instance: ImageModelDataService = ImageModelDataService()
    private init() { downloadData() }
    
    @Published var imageModels: [ImageModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    
    func downloadData() {
        guard let url: URL = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [ImageModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("ImageModelDataService -> Error downloading data. \(error)")
                }
            } receiveValue: { [weak self] (returnedImageModels) in
                self?.imageModels = returnedImageModels
            }
            .store(in: &cancellables)
    }
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
