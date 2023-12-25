//
//  CachedImage.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 17/12/2023.
//

import SwiftUI

struct CachedImage<Content>: View where Content: View {
    
    @ObservedObject var viewModel: CachedImageViewModel
    @ViewBuilder let imageContent: (Image) -> Content
    @State private var image: UIImage?
    
    init(url: String,
         @ViewBuilder content: @escaping (Image) -> Content) {
        let imgUrl = URL(string: url)!
        viewModel = CachedImageViewModel(url: imgUrl)
        imageContent = content
    }
    
    var body: some View {
        if let image = image {
            imageContent(Image(uiImage: image))
        } else {
            ProgressView()
                .onAppear {
                    viewModel.loadImage() { data in
                        if let imgData = data {
                            DispatchQueue.main.async {
                                self.image = UIImage(data: imgData)
                            }
                        }
                    }
                }
        }
    }
    
    
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG", content: { image in
            image.resizable()
        })
    }
}

