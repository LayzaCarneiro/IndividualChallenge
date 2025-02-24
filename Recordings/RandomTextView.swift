
//
//  RandomTextView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct RandomTextView: View {
    @ObservedObject private var audioRecorder = AudioRecorder()
    @State var randomText = randomStory()

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isCompact: Bool {
        verticalSizeClass == .compact || horizontalSizeClass == .compact
    }

    private var textBoxWidth: CGFloat {
        isCompact ? UIScreen.main.bounds.width * 0.9 : max(770, UIScreen.main.bounds.width * 0.9)
    }

    private var textBoxHeight: CGFloat {
        isCompact ? UIScreen.main.bounds.height * 0.6 : min(730, UIScreen.main.bounds.height * 0.6)
    }

    private var fontSizeTitle: CGFloat {
        isCompact ? 20 : 24
    }

    private var fontSizeText: CGFloat {
        isCompact ? 18 : 24
    }

    private var buttonSize: CGFloat {
        isCompact ? 70 : 100
    }

    private var iconSize: CGFloat {
        isCompact ? 30 : 40
    }

    private var buttonBackgroundSize: CGFloat {
        isCompact ? 60 : 80
    }

    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("offWhite"))
                    .stroke(.black)
                    .frame(width: textBoxWidth, height: textBoxHeight)
                    .overlay(text)

                Spacer()
                recordingButton
                    .buttonStyle(PlainButtonStyle())
            }
            .padding() // Add padding to the whole VStack
            .navigationTitle("Recordings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        randomText = randomStory()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                    }
                }
            }
        }
    }

    private var text: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                Text(randomText?.title ?? "")
                    .font(.system(size: fontSizeTitle, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(randomText?.text ?? "")
                    .font(.system(size: fontSizeText))

                Spacer()
            }
            .padding()
        }
    }

    private var recordingButton: some View {
        Group {
            if audioRecorder.recording == false {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.audioRecorder.startRecording()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: buttonSize, height: buttonSize)
                            .overlay(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 4)
                                    .scaleEffect(1.0)
                                    .opacity(0.8)
                            )

                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue).frame(width: buttonBackgroundSize, height: buttonBackgroundSize))
                            .shadow(color: .blue.opacity(0.5), radius: 8)
                    }
                }
            } else {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.audioRecorder.stopRecording()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.red.opacity(0.3))
                            .frame(width: buttonSize, height: buttonSize)
                            .overlay(
                                Circle()
                                    .stroke(Color.red, lineWidth: 4)
                                    .scaleEffect(1.3)
                                    .opacity(0.6)
                            )

                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color("darkOrange")).frame(width: buttonBackgroundSize, height: buttonBackgroundSize))
                            .shadow(color: Color("darkOrange").opacity(0.7), radius: 8)
                    }
                }
            }
        }
    }
}
