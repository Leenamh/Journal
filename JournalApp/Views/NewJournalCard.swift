//
//  NewJournalCard.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 21/10/2025.
//

import SwiftUI

struct NewJournalCard: View {
    @Binding var showCard: Bool
    @Binding var offset: CGFloat
    var onSave: (Journal) -> Void

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showDiscardAlert = false

    private let startOffset: CGFloat = 60

    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                    .gesture(
                        DragGesture()
                            .onChanged { value in offset = value.translation.height }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    if offset > 120 { showCard = false }
                                    offset = 0
                                }
                            }
                    )

                HStack {
                    Button {
                        withAnimation(.spring()) { showDiscardAlert = true }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(
                                .regular
                                    .tint(Color("buttonColor")) // your dark glass color
                                    .interactive(),             // subtle motion / dynamic reflection
                                in: Circle()
                            )
                    }


                    Spacer()

                    Button {
                        let newJournal = Journal(
                            title: title.isEmpty ? "Untitled" : title,
                            date: currentDate,
                            content: content,
                            isBookmarked: false
                        )
                        onSave(newJournal)
                        withAnimation(.spring()) { showCard = false }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .glassEffect(
                                .regular
                                    .tint(Color("PurpleButton").opacity(0.7)) // stronger tint = deeper glass feel
                                    .interactive(),
                                in: Circle()
                            )

                    }

                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: $title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color("textColor"))
                        .padding(.top, 6)

                    Text(currentDate)
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray"))

                    TextEditor(text: $content)
                        .frame(height: 250)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 17))
                        .overlay(
                            Group {
                                if content.isEmpty {
                                    Text("Type your Journal...")
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundColor(Color("textColor"))
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                }
                            },
                            alignment: .topLeading
                        )
                }
                .padding(.horizontal)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.95)
            .background(Color("BgCard"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(y: max(offset + startOffset, 0))
            .animation(.spring(response: 0.45, dampingFraction: 0.85), value: offset)
            .ignoresSafeArea(edges: .bottom)

            if showDiscardAlert {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation(.easeOut) { showDiscardAlert = false } }

                VStack(spacing: 10) {
                    Text("Are you sure you want to discard\nchanges on this journal?")
                        .font(.system(size: 17))
                        .foregroundColor(Color.white.opacity(0.68))
                        .multilineTextAlignment(.center)
                        .frame(width: 252, height: 44)

                    VStack(spacing: 8) {
                        Button {
                            withAnimation(.spring()) {
                                showCard = false
                                showDiscardAlert = false
                            }
                        } label: {
                            Text("Discard Changes")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.red)
                                .frame(width: 240, height: 22)
                                .padding(.vertical, 12)
                                .frame(width: 272, height: 48)
                                .background(Color.white.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        }

                        Button {
                            withAnimation(.spring()) { showDiscardAlert = false }
                        } label: {
                            Text("Keep Editing")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 240, height: 22)
                                .padding(.vertical, 12)
                                .frame(width: 272, height: 48)
                                .background(Color(red: 118/255, green: 118/255, blue: 128/255).opacity(0.24))
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                    }
                }
                .padding(.vertical, 20)
                .frame(width: 268, height: 176)
                .background(Color.black.opacity(0.6).blur(radius: 10))
                .cornerRadius(20)
                .transition(.scale.combined(with: .opacity))
                .zIndex(2)
            }
        }
    }
}

#Preview {
    NewJournalCard(showCard: .constant(true), offset: .constant(0)) { _ in }
        .preferredColorScheme(.dark)
}
