//
//  DownloadingImagesRow.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 30.05.2024.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let imageModel: ImageModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: imageModel.url, key: "\(imageModel.id)")
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(imageModel.title)
                    .font(.headline)
                Text(imageModel.url)
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadingImagesRow(imageModel: ImageModel(
            albumId: 1,
            id: 1,
            title: "Title",
            url: "url here",
            thumbnailUrl: ""
        )
    )
}
