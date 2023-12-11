//
//  FilterView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 10/12/2023.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var isPresenting: Bool
    
    private let topSpace: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height:topSpace)
            titleView()
            radioButtonOptionsView()
            applyFilterButtonView()
        }
    }
}

extension FilterView {
    func titleView() -> some View {
        HStack {
            Spacer()
            Text("Select Camera:")
                .font(.title2).bold()
            Spacer()
        }
    }
    
    func radioButtonOptionsView() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                RadioButton(value: nil, selectedValue: $viewModel.selectedCameraFilter, action: {
                    viewModel.setSelectedCamera(to: nil)
                })
                ForEach(viewModel.getCameras(), id: \.self) { camera in
                    RadioButton(value: camera, selectedValue: $viewModel.selectedCameraFilter, action: {
                        viewModel.setSelectedCamera(to: camera)
                    })
                }
            }
        }
    }
    
    func applyFilterButtonView() -> some View {
        HStack {
            Spacer()
            Button("Apply", action: {
                isPresenting = false
                viewModel.getPhotoListViewModel().fetchPhotos(isForceLoading: true)
            })
            .bold()
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Spacer()
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: HomeViewModel(), isPresenting: .constant(true))
    }
}
