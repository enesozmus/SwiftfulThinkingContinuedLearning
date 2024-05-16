//
//  ProfileView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 16.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text(currentUserName ?? "Your name here")
            Text("This user is \(currentUserAge ?? 0) years old!")
            Text("Their gender is \(currentUserGender ?? "unknown")")
            
            Text("SIGN OUT")
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                .onTapGesture {
                    signOut()
                }
        }
        .font(.title)
        .foregroundStyle(.purple)
        .padding()
        .padding(.vertical, 40)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
        .shadow(radius: 10)
    }
    
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring) {
            currentUserSignedIn = false
        }
    }
}

#Preview {
    ProfileView()
}
