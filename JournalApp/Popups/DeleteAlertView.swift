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
            Color("buttonColor")
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture { onCancel() }


            // Alert box
            VStack(spacing: 18) {
                // Title
                Text("Delete Journal?")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                // Message
                Text("Are you sure you want to delete this journal?")
                    .font(.system(size: 16))
                    .foregroundColor(Color.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 24)

                // Buttons
                HStack(spacing: 12) {
                    // Cancel button
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("buttonColor").opacity(0.85))
                                    .glassEffect(
                                        .regular
                                            .tint(Color("buttonColor").opacity(0.9))
                                            .interactive(),
                                        in: RoundedRectangle(cornerRadius: 25)
                                    )
                            )
                    }

                    // Delete button
                    Button(action: onDelete) {
                        Text("Delete")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.red)
                            )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 24)
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color("buttonColor").opacity(0.65))
                    .glassEffect(
                        .regular
                            .tint(Color("buttonColor").opacity(0.7))
                            .interactive(),
                        in: RoundedRectangle(cornerRadius: 24)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.8)
            )
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 3)
        }
    }
}

