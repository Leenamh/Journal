//
//  SearchBarView.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 22/10/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack(spacing: 12) {
            // Left icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("gray"))

            // Text field
            TextField(
                "",
                text: $searchText,
                prompt: Text("Search")
                    .foregroundColor(Color("gray"))
            )
            .foregroundColor(.white)

            // Right icon
            Image(systemName: "mic.fill")
                .foregroundColor(Color("gray"))
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(
            Capsule()
                .fill(Color("buttonColor")) // your dark theme color
                .glassEffect(
                    .regular
                        .tint(Color("buttonColor")) // glass tint for dark tone
                        .interactive(),             // subtle reflective motion
                    in: Capsule()
                )
        )
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.08), lineWidth: 0.8) // faint rim highlight
        )
        .shadow(color: .black.opacity(0.6), radius: 10, x: 0, y: 3)
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }
}
