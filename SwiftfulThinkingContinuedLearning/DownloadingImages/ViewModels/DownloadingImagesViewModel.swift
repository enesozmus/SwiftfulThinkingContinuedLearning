//
//  DownloadingImagesViewModel.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import Combine
import Foundation

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [ImageModel] = []
    
    let imageModelDataService: ImageModelDataService = ImageModelDataService.instance
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        imageModelDataService.$imageModels
            .sink { [weak self] (returnedImageModels) in
                self?.dataArray = returnedImageModels
            }
            .store(in: &cancellables)
    }
}
