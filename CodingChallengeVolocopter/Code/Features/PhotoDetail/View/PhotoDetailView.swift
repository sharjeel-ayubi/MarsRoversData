//
//  PhotoDetailView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/12/2023.
//

import SwiftUI

struct PhotoDetailView: View {
    
    var photo: Photo
    var body: some View {
        VStack(alignment: .center) {
            displayImage()
            displayText(with: "Capture Date", value: photo.earthDate)
            displayText(with: "Vehicle Name", value: photo.rover.name)
            displayText(with: "Vehicle Launch Date", value: photo.rover.launchDate)
            displayText(with: "Vehicle Landing Date", value: photo.rover.landingDate)
            Spacer()
        }
    }
}

extension PhotoDetailView {
    func displayText(with title: String, value: String) -> some View {
        HStack(spacing:5) {
            Text("\(title):")
                .bold()
            Text(value)
        }
    }
    
    func displayImage() -> some View {
        AsyncImage(url: URL(string: photo.imgSrc)) { image in
            image.resizable().aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo(id: 0, sol: 100, camera: PhotoCamera(id: 1, name: "camera", roverID: 2, fullName: "rover camera"), imgSrc: "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631210305218E01_DXXX.jpg", earthDate: "2006-11-17", rover: Rover(id: 3, name: "Curiosity", landingDate: "2004-01-25", launchDate: "2003-07-07", status: "ok", maxSol: 2, maxDate: "2023", totalPhotos: 10, cameras: [])))
    }
}
