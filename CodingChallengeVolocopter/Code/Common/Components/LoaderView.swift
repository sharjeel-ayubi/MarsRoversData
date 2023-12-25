//
//  LoaderView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 26/12/2023.
//

import Foundation
import SwiftUI

struct LoaderView: ViewModifier {
    
    var isLoading: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 5 : 0)
            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .controlSize(.large)
                }
                .frame(maxWidth: 100, maxHeight: 100)
                .background(Color.secondary)
                .opacity(isLoading ? 1 : 0)
                .cornerRadius(10)
            }
        }
    }
}

extension View {
    func loader(isLoading: Bool) -> some View {
        modifier(LoaderView(isLoading: isLoading))
    }
}
