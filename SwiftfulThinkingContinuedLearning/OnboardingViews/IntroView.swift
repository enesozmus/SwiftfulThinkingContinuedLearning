//
//  IntroView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 16.05.2024.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color.purple, Color.blue],
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height
            )
            .ignoresSafeArea()
            
            if currentUserSignedIn {
                ProfileView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .top)
                    ))
            } else {
                OnboardingView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .top),
                        removal: .move(edge: .bottom)
                    ))
            }
        }
        .animation(.spring(), value: currentUserSignedIn)
    }
}

#Preview {
    IntroView()
}
