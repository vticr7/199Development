//
//  CustomSecureField.swift
//  ActiveVibe
//
//  Created by Vaibhav on 04/03/24.
//
import SwiftUI
import Foundation
struct CustomSecureField: View {
    var image: String
    var placeholder: String
    @Binding var text: String
    var isValid: Bool

    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.white)

            SecureField(placeholder, text: $text)
                .foregroundColor(.white)
                .autocapitalization(.none)

            if text.count != 0 {
                Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isValid ? .green : .red)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(isValid ? Color.white : Color.red, lineWidth: 2))
        .padding(.horizontal)
    }
}
