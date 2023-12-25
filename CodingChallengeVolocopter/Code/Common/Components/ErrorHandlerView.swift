//
//  ErrorHandlerView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 26/12/2023.
//

import SwiftUI

struct ErrorHandlerView<T>: ViewModifier where T: AppErrorProtocol {
    @Binding var error: T?

    func body(content: Content) -> some View {
        content
            .background(
                EmptyView()
                    .alert(item: $error) { viewModelError in
                        return Alert(title: Text(viewModelError.title),
                                     message: Text(viewModelError.errorDescription),
                                     dismissButton: .default(Text("OK")))

                    }
            )
    }
}

extension View {
    func withErrorHandling<T: AppErrorProtocol>(error: Binding<T?>) -> some View {
        modifier(ErrorHandlerView(error: error))
    }
}
