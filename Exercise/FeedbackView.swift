//
//  FeedbackView.swift
//  Phono
//
//  Created by Layza Maria Rodrigues Carneiro on 23/02/25.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isExerciseViewPresented: Bool
    let phoneme: Phoneme

    // MARK: - Responsive Properties
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isCompact: Bool {
        verticalSizeClass == .compact || horizontalSizeClass == .compact
    }

    private var titleFontSize: CGFloat {
        isCompact ? 32 : 48
    }

    private var subtitleFontSize: CGFloat {
        isCompact ? 18 : 24
    }

    private var iconWidth: CGFloat {
        isCompact ? UIScreen.main.bounds.width * 0.8 : 540
    }

    private var iconHeight: CGFloat {
        isCompact ? 80 : 100
    }

    private var buttonWidth: CGFloat {
        isCompact ? UIScreen.main.bounds.width * 0.8 : 540
    }

    private var buttonHeight: CGFloat {
        isCompact ? 50 : 72
    }

    private var bodyFontSize: CGFloat {
        isCompact ? 20 : 26
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) { // Reduced spacing a bit
                    Spacer() // Push content down a bit

                    phonemeIcon

                    Text("Congratulations! 🎉")
                        .font(.system(size: titleFontSize, weight: .bold))
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("You've completed the exercise for the \(phoneme.symbol) sound! Remember to breathe and take your time when speaking.")
                        .font(.system(size: subtitleFontSize))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Image(systemName: "hands.clap.fill") // A celebratory image
                        .font(.system(size: 80))
                        .foregroundColor(.yellow)
                        .shadow(radius: 5)

                    Text("Ready for another challenge? Try a new exercise or review other sounds.")
                        .font(.system(size: subtitleFontSize))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    doneExerciseButton

                    Spacer() // Push content up a bit
                }
                .padding() // Add general padding around the content
            }
            .navigationTitle("Well Done!") // More positive title
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var phonemeIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [Color.blue, Color.cyan],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: iconWidth, height: iconHeight)
                .padding(.horizontal)

            VStack {
                Text(phoneme.symbol)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(phoneme.description)
                    .font(.body)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .padding(.vertical)
        }

    }

    private var doneExerciseButton: some View {
        Button {
            self.isExerciseViewPresented = false
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
                .frame(width: buttonWidth, height: buttonHeight)
                .overlay(
                    Text("Done")
                        .font(.system(size: bodyFontSize, weight: .bold))
                        .foregroundStyle(.white)
                )
        }
    }
}
