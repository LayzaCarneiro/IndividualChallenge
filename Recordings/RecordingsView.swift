//
//  SwiftUIView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct RecordingsView: View {
    @State private var selectedIndex = 0
    @ObservedObject private var audioRecorder = AudioRecorder()
    
    var body: some View {
        VStack {
            Picker("Select View", selection: $selectedIndex) {
                Text("Random Text").tag(0)
                Text("Recordeds").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedIndex == 0 {
                RandomTextView()
            } else {
                RecordedView(audioRecorder: AudioRecorder())
            }
            
            Spacer()
        }
        .padding()}
}
