//
//  DeleteAlertView.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 22/10/2025.
//

import SwiftUI

struct DeleteAlertView: View {
    let journal: Journal
    let onCancel: () -> Void
    let onDelete: () -> Void

    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture { onCancel() }

            VStack(spacing: 20) {
                // Title
                Text("Delete Journal?")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)

                // Message
                Text("Are you sure you want to delete this journal?")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                // Buttons
                HStack(spacing: 12) {
                    // Cancel
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("buttonColor"))
                                    .glassEffect(
                                        .regular
                                            .tint(Color("buttonColor")),
                                        in: RoundedRectangle(cornerRadius: 16)
                                    )
                            )
                    }

                    // Delete
                    Button(action: onDelete) {
                        Text("Delete")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.red)
                            )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 22)
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("buttonColor"))
                    .glassEffect(
                        .regular
                            .tint(Color("buttonColor")),
                        in: RoundedRectangle(cornerRadius: 20)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.8)
            )
            .shadow(color: .black.opacity(0.6), radius: 12, x: 0, y: 4)
        }
    }
}
