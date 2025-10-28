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
            // 🔍 Left icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("gray"))

            // ✏️ Text field
            TextField(
                "",
                text: $searchText,
                prompt: Text("Search")
                    .foregroundColor(Color("gray"))
            )
            .foregroundColor(.white)

            // 🎤 Right icon
            Image(systemName: "mic.fill")
                .foregroundColor(Color("gray"))
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(
            Capsule()
                .fill(Color.clear)
                .glassEffect(
                    .regular
                        .tint(Color.white.opacity(0.05))  // soft bright glass tint
                        .interactive(),                   // subtle reflection
                    in: Capsule()
                )
        )
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.15), lineWidth: 0.8) // faint bright rim
        )
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 3)
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
        .background(Color("BG"))
}
