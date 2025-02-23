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
                    .listRowBackground(Color("offWhite"))
            }
            .onDelete(perform: delete)
        }
        .scrollContentBackground(.hidden)

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
    @ObservedObject var audioPlayer = AudioPlayer()
    var audioURL: URL
    
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
    
            Text(getRecordingDate(from: audioURL))
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
    
    func getRecordingDate(from url: URL) -> String {
        let fileAttributes = try? FileManager.default.attributesOfItem(atPath: url.path)
        
        if let creationDate = fileAttributes?[.creationDate] as? Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy - HH:mm" // Formato da data
            return formatter.string(from: creationDate)
        }
        
        return "Unknown date"
    }
}
