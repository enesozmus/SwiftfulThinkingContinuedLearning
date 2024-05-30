//
//  DownloadingImagesBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm: DownloadingImagesViewModel = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { imageModel in
                    DownloadingImagesRow(imageModel: imageModel)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
