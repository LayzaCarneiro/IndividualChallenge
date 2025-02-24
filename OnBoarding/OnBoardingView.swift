//
//  OnBoardingView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var firstLaunch: Bool
    @AppStorage("username") var username: String = "Caterpillar 🐛"

    @State private var onBoardStep = "Start"

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }

    private var titleFontSize: CGFloat {
        isCompact ? 28 : 32
    }

    private var subtitleFontSize: CGFloat {
        isCompact ? 16 : 18
    }

    var body: some View {
        ZStack {

            VStack(alignment: .center, spacing: 30) { // Center alignment, added spacing
                Spacer().frame(maxHeight: 40)

                if onBoardStep == "Start" {
                    Text("Unlock Your Voice Potential!")
                        .font(.system(size: titleFontSize, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 20) {
                        FeatureRow(imageName: "list.bullet.clipboard.fill",
                                  title: "Phoneme Exercises",
                                  description: "Improve specific sounds with tailored exercises for individual phonemes.")

                       FeatureRow(imageName: "brain.fill",
                                  title: "Tongue Twisters",
                                  description: "Practice fluency and articulation with fun and challenging tongue twisters.")

                       FeatureRow(imageName: "waveform.badge.mic",
                                  title: "Read, Record, & Monitor",
                                  description: "Read texts, record your voice, and track your pronunciation progress over time.")
                    }
                    .padding(.horizontal, 20)

                } else {
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.blue)

                    Text("Create Your Profile")
                        .font(.system(size: titleFontSize, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)

                    TextField("Enter your name", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .autocapitalization(.words)

                }
                Spacer()

                Button {
                    withAnimation {
                        if onBoardStep == "Start" {
                            onBoardStep = "Data"
                        } else {
                            firstLaunch = false
                        }
                    }

                } label: {
                    CustomButton(text: onBoardStep == "Start" ? "Next" : "Get Started", gradient: LinearGradient(
                        colors: [Color.red, Color.orange],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                }
                .padding(.horizontal, 20)
                
                Spacer()

            }
            .onTapGesture {
                self.hideKeyboard()
            }
            .padding() // Added general padding
            .background(Color.white) // Ensure white background
            .font(.system(.body, design: .rounded))
            .cornerRadius(15)
            .frame(maxWidth: 500, maxHeight: 600)
            .shadow(radius: 5) //Add shadow
        }
        .opacity(firstLaunch ? 1 : 0)
        .animation(.easeInOut, value: firstLaunch)
    }
}

struct FeatureRow: View {
    let imageName: String
    let title: String
    let description: String

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }

    private var subtitleFontSize: CGFloat {
        isCompact ? 14 : 16
    }

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(.blue)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: subtitleFontSize + 2, weight: .semibold, design: .rounded))
                Text(description)
                    .font(.system(size: subtitleFontSize, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
