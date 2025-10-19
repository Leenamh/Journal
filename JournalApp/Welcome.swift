//
//  Welcome.swift
//  JournalApp
//
//  Created by leena almusharraf on 19/10/2025.
//

import SwiftUI

struct SplashPage: View {
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [
                    Color("BG2"), Color("BG1")
                ],
                startPoint: .topLeading,
                endPoint: .bottomLeading
                
            ).ignoresSafeArea()
            
            VStack{
                Image("BOOKCLOSE")
                    .resizable()
                    .scaledToFit()
                    .frame(width:90, height: 111)
                    .shadow(radius: 10)
                
                
                
                Text("Journali")
            }
            
            
        }// end of Zstake
    }}

#Preview {
    SplashPage()
}
