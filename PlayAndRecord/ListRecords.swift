//
//  ListRecords.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 11/12/24.
//

import SwiftUI

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
        .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordedLast: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        if let lastRecording = audioRecorder.recordings.last {
            VStack {
                RecordingRow(audioURL: lastRecording.fileURL)
            }
            .padding()
        } else {
            Text("Nenhuma gravação encontrada.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            if audioPlayer.isPlaying == false {
                Button {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                    print(audioURL)

                } label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button {
                    self.audioPlayer.stopPlayback()
                    print(audioURL)

                } label: {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
            
            Text("Your recording")
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}
