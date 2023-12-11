//
//  RadioButton.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 11/12/2023.
//

import SwiftUI

struct RadioButton<T: Hashable>: View {
    var value: T?
    @Binding var selectedValue: T?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: value == selectedValue ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.blue)
                if let value = value {
                    Text(String(describing: value))
                } else {
                    Text("None")
                }
            }
            .foregroundColor(.primary)
            .font(.body)
            .padding()
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(value: CameraType.FHAZ, selectedValue: .constant(.FHAZ), action: {})
    }
}
