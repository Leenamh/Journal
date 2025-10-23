//
//  JournalCardView.swift
//  JournalApp
//
//  Created by leena almusharraf on 22/10/2025.
//


//
//  JournalCardView.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 22/10/2025.
//

import SwiftUI

struct JournalCardView: View {
    let journal: Journal
    let onDeleteRequest: () -> Void
    let onToggleBookmark: () -> Void

    @State private var offsetX: CGFloat = 0

    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Spacer()
                Button {
                    withAnimation(.spring()) { onDeleteRequest() }
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                .padding(.trailing, 20)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(journal.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("Purple"))
                    Spacer()
                    Button(action: onToggleBookmark) {
                        Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(journal.isBookmarked ? Color("Purple") : .white.opacity(0.8))
                    }
                }

                Text(journal.date)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(journal.content)
                    .foregroundColor(.white)
                    .lineLimit(3)
            }
            .padding()
            .background(Color("BgCard"))
            .cornerRadius(20)
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            offsetX = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if value.translation.width < -80 {
                                offsetX = -80
                            } else {
                                offsetX = 0
                            }
                        }
                    }
            )
        }
        .frame(maxWidth: .infinity)
    }
}
