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
    var existingJournal: Journal? = nil          // 🆕 optional for editing
    var onSave: (Journal) -> Void

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showDiscardAlert = false

    private let startOffset: CGFloat = 60

    // MARK: - Current date
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }

    // MARK: - Init with prefilled data
    init(
        showCard: Binding<Bool>,
        offset: Binding<CGFloat>,
        existingJournal: Journal? = nil,
        onSave: @escaping (Journal) -> Void
    ) {
        _showCard = showCard
        _offset = offset
        self.existingJournal = existingJournal
        self.onSave = onSave

        // Pre-fill data if editing
        _title = State(initialValue: existingJournal?.title ?? "")
        _content = State(initialValue: existingJournal?.content ?? "")
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                // Handle (drag to close)
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                    .gesture(
                        DragGesture()
                            .onChanged { value in offset = value.translation.height }
                            .onEnded { _ in
                                if offset > 120 { showCard = false }
                                offset = 0
                            }
                    )

                // MARK: - Top buttons
                HStack {
                    // ❌ Cancel
                    Button {
                        showDiscardAlert = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(
                                .regular
                                    .tint(Color("buttonColor"))
                                    .interactive(),
                                in: Circle()
                            )
                    }

                    Spacer()

                    // ✅ Save
                    Button {
                        var updatedJournal = existingJournal ?? Journal(
                            title: title.isEmpty ? "Untitled" : title,
                            date: currentDate,
                            content: content,
                            isBookmarked: existingJournal?.isBookmarked ?? false
                        )
                        updatedJournal.title = title
                        updatedJournal.content = content
                        onSave(updatedJournal)
                        showCard = false
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .glassEffect(
                                .regular
                                    .tint(Color("PurpleButton").opacity(0.7))
                                    .interactive(),
                                in: Circle()
                            )
                    }
                }
                .padding(.horizontal)

                // MARK: - Text Fields
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: $title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color("textColor"))
                        .padding(.top, 6)

                    Text(existingJournal?.date ?? currentDate)
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
            .ignoresSafeArea(edges: .bottom)

            // MARK: - Discard Alert
            if showDiscardAlert {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture { showDiscardAlert = false }

                VStack(spacing: 14) {
                    Text("Are you sure you want to discard\nchanges on this journal?")
                        .font(.system(size: 17))
                        .foregroundColor(Color.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)

                    VStack(spacing: 8) {
                        // Discard
                        Button {
                            showCard = false
                            showDiscardAlert = false
                        } label: {
                            Text("Discard Changes")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color("buttonColor").opacity(0.7))
                                        .glassEffect(
                                            .regular
                                                .tint(Color("buttonColor").opacity(0.8))
                                                .interactive(),
                                            in: RoundedRectangle(cornerRadius: 24)
                                        )
                                )
                        }

                        // Keep editing
                        Button {
                            showDiscardAlert = false
                        } label: {
                            Text("Keep Editing")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color("buttonColor").opacity(0.6))
                                        .glassEffect(
                                            .regular
                                                .tint(Color("buttonColor").opacity(0.7))
                                                .interactive(),
                                            in: RoundedRectangle(cornerRadius: 24)
                                        )
                                )
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.vertical, 22)
                .frame(width: 280)
                .background(
                    RoundedRectangle(cornerRadius: 26)
                        .fill(Color("buttonColor").opacity(0.6))
                        .glassEffect(
                            .regular
                                .tint(Color("buttonColor").opacity(0.7))
                                .interactive(),
                            in: RoundedRectangle(cornerRadius: 26)
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.8)
                )
                .shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 3)
                .zIndex(2)
            }
        }
    }
}

#Preview {
    NewJournalCard(
        showCard: .constant(true),
        offset: .constant(0),
        existingJournal: Journal(
            title: "Sample Entry",
            date: "27/10/2025",
            content: "Preview content here.",
            isBookmarked: false
        )
    ) { _ in }
    .preferredColorScheme(.dark)
}
