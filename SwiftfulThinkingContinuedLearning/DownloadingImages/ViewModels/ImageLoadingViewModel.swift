//
//  ImageLoadingViewModel.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import Combine
import Foundation
import SwiftUI

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let manager: ImageModelCacheManager = ImageModelCacheManager.instance
    
    let urlString: String
    let imageKey: String
    
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("ImageLoadingViewModel -> Getting saved image!")
        } else {
            downloadImage()
            print("ImageLoadingViewModel -> Downloading image now!")
        }
    }
    func downloadImage() {
        isLoading = true
        guard let url: URL = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let image = returnedImage else { return }
                
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}
