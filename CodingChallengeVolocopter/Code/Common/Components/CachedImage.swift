//
//  CachedImage.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 17/12/2023.
//

import SwiftUI

struct CachedImage<Content>: View where Content: View {
    
    let url: URL
    @ViewBuilder let imageContent: (Image) -> Content
    @State private var image: UIImage?
    
    init(url: String,
         @ViewBuilder content: @escaping (Image) -> Content) {
        self.url = URL(string: url)!
        imageContent = content
    }
    
    var body: some View {
        if let image = image {
            imageContent(Image(uiImage: image))
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    
}

//MARK: Image Loading Methods
extension CachedImage {
    private func loadImage() {
        let request = URLRequest(url: url)
        
        // Check if the image is available in the cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            image = UIImage(data: cachedResponse.data)
        } else {
            fetchImageFromNetwork(with: request)
        }
    }
    
    private func fetchImageFromNetwork(with request: URLRequest) {
        //fetch the image from the network
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                // Cache the downloaded image
                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: request)
                
                // Update the image
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG", content: { image in
            image.resizable()
        })
    }
}

