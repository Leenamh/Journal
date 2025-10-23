//
//  MainView.swift
//  JournalApp
//
//  Created by Leena Almusharraf on 21/10/2025.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
    @State private var showCard = false
    @State private var cardOffset: CGFloat = 0
    @State private var journals: [Journal] = []
    @State private var showSortMenu = false
    @State private var sortOption: SortOption = .entryDate
    @State private var journalToDelete: Journal? = nil

    enum SortOption {
        case bookmark, entryDate
    }

    // MARK: - Filter + Sort Logic
    var filteredJournals: [Journal] {
        var result = journals
        if sortOption == .bookmark {
            result = result.filter { $0.isBookmarked }
        }
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let query = searchText.lowercased()
            result = result.filter {
                $0.title.lowercased().contains(query) ||
                $0.content.lowercased().contains(query)
            }
        }
        result.sort { $0.date > $1.date }
        return result
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color("BG").ignoresSafeArea()

            VStack(spacing: 20) {
                // MARK: - Top Bar
                HStack {
                    Text("Journal")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)

                    Spacer()

                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("buttonColor"))
                        .frame(width: 104, height: 48)
                        .glassEffect(
                            .regular
                                .tint(Color("buttonColor")),
                            in: RoundedRectangle(cornerRadius: 50)
                        )
                        .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 3)
                        .overlay(
                            HStack {
                                Button { showSortMenu.toggle() } label: {
                                    Image(systemName: "line.3.horizontal.decrease")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(
                                            showSortMenu ? Color("Purple") : Color.white.opacity(0.65)
                                        )
                                }

                                Spacer()

                                Button { showCard.toggle() } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color.white.opacity(0.65))
                                }
                            }
                            .padding(.horizontal, 15)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                // MARK: - Journal List
                if filteredJournals.isEmpty {
                    Spacer()
                    VStack(spacing: 10) {
                        Image("OPENBOOK")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 151, height: 97)
                        Text("Begin Your Journal")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(Color("Purple"))
                        Text("Craft your personal diary, tap the plus icon to begin")
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filteredJournals.indices, id: \.self) { index in
                                let journal = filteredJournals[index]
                                JournalCardView(
                                    journal: journal,
                                    onDeleteRequest: { journalToDelete = journal },
                                    onToggleBookmark: {
                                        if let i = journals.firstIndex(where: { $0.id == journal.id }) {
                                            journals[i].isBookmarked.toggle()
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }

            // MARK: - Sort Menu
            if showSortMenu {
                SortMenuView(sortOption: $sortOption, showSortMenu: $showSortMenu)
                    .padding(.trailing, 30)
                    .padding(.top, 85)
                    .zIndex(3)
            }

            // MARK: - Delete Alert
            if let selected = journalToDelete {
                DeleteAlertView(
                    journal: selected,
                    onCancel: { journalToDelete = nil },
                    onDelete: {
                        journals.removeAll { $0.id == selected.id }
                        journalToDelete = nil
                    }
                )
                .zIndex(10)
            }

            // MARK: - New Journal Card
            if showCard {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture { showCard = false }

                    NewJournalCard(showCard: $showCard, offset: $cardOffset) { newJournal in
                        journals.insert(newJournal, at: 0)
                    }
                    .zIndex(4)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            if !showCard {
                SearchBarView(searchText: $searchText)
            }
        }
    }
}

#Preview {
    MainView()
}
