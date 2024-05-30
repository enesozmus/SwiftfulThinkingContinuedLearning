//
//  DownloadingImageView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader: ImageLoadingViewModel
        
        init(url: String, key: String) {
            _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
        }
        
        var body: some View {
            ZStack {
                if loader.isLoading {
                    ProgressView()
                } else if let image = loader.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
                }
            }
        }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
}
