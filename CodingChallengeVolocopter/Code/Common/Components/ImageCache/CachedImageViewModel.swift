//
//  CachedImageViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 26/12/2023.
//

import Foundation

class CachedImageViewModel: ObservableObject {
    
    let url: URL
    let urlSession: URLSession
    
    init(url: URL, urlSession: URLSession = URLSession.shared) {
        self.url = url
        self.urlSession = urlSession
    }
    
    func loadImage(completion: @escaping (Data?) -> Void) {
        let request = URLRequest(url: url)
        
        // Check if the image is available in the cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            completion(cachedResponse.data)
        } else {
            fetchImageFromNetwork(with: request) { data in
                completion(data)
            }
        }
    }
    
    func fetchImageFromNetwork(with request: URLRequest, completion: @escaping (Data?) -> Void) {
        //fetch the image from the network
        urlSession.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                // Cache the downloaded image
                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: request)
                //return the data in completion handler
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
