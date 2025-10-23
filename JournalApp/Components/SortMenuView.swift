//
//  SortMenuView.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 22/10/2025.
//

import SwiftUI

struct SortMenuView: View {
    @Binding var sortOption: MainView.SortOption
    @Binding var showSortMenu: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // MARK: - Sort by Bookmark
            Button {
                withAnimation(.spring()) {
                    sortOption = .bookmark
                    showSortMenu = false
                }
            } label: {
                Text("Sort by Bookmark")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Divider()
                .background(Color.white.opacity(0.2))

            // MARK: - Sort by Entry Date
            Button {
                withAnimation(.spring()) {
                    sortOption = .entryDate
                    showSortMenu = false
                }
            } label: {
                Text("Sort by Entry Date")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(width: 220)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color("buttonColor")) // dark base
                .glassEffect(
                    .regular
                        .tint(Color("buttonColor")) // match your dark theme
                        .interactive(),             // subtle motion & reflection
                    in: RoundedRectangle(cornerRadius: 18)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.1), lineWidth: 1) // soft edge glow
        )
        .shadow(color: .black.opacity(0.6), radius: 10, x: 0, y: 3)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}
