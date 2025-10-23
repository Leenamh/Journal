//
//  Welcome.swift
//  JournalApp
//
//  Created by leena almusharraf on 19/10/2025.
//

import SwiftUI

struct SplashPage: View {
    @State private var animateBook = false
    @State private var navigateToMain = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color("BG2"), Color("BG1")],
                startPoint: .topLeading,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()

            VStack(spacing: 10) {
                Image("BOOKCLOSE")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 111)
                    .shadow(radius: 10)
                    .scaleEffect(animateBook ? 1.1 : 1.0)
                    .opacity(animateBook ? 1 : 0.8)
                    .padding(.bottom, 10)
                    .animation(.easeInOut(duration: 1).repeatCount(2, autoreverses: true), value: animateBook)

                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .foregroundColor(Color("white"))

                Text("Your thoughts, your story")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(Color("white"))
            }
        }
        .onAppear {
            // Start the book pop-up animation
            animateBook = true
            
            // After 5 seconds, navigate to MainView
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    navigateToMain = true
                }
            }
        }
        .fullScreenCover(isPresented: $navigateToMain) {
            MainView()
        }
    }
}

#Preview {
    SplashPage()
}
