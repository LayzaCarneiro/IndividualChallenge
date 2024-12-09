//
//  RepeatWord.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct RepeatWord: View {
    @State var record = false
    @State var session: AVAudioSession!
    @State var recorder: AVAudioRecorder!
    @State var alert = false
    @State var audios: [URL] = []

    var body: some View {
        VStack(spacing: 40) {
            ZStack {
                Rectangle()
                    .frame(width: 650, height: 700)
                    .cornerRadius(10)
                    .foregroundStyle(.blue)
            }
            
            Button {
                do {
                    if self.record {
                        self.recorder.stop()
                        self.record.toggle()
                        self.getAudios()
                    }
                    
                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    
                    let filName = url.appendingPathComponent("record\(self.audios.count + 1).m4a")
                    
                    let settings = [
                        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey: 12000,
                        AVNumberOfChannelsKey: 1,
                        AVEncoderAudioQualityKey: AVAudioQuality.high
                    ]
                    
                    self.recorder = try AVAudioRecorder(url: filName, settings: settings)
                    self.recorder.record()
                    self.record.toggle()
                }
                catch {
                    print(error.localizedDescription)
                }
                
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    
                    if self.record {
                        Circle()
                            .stroke(.black, lineWidth: 2)
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.red)
                    }
                    
                    Image(systemName: "mic.fill")
                        .resizable()
                        .frame(width: 20, height: 30)
                        .foregroundStyle(.white)
                }
            }
            
            List(self.audios, id: \.self) { audio in
                Text(audio.relativeString)
            }
        }
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("Couldn't record audio."))
        })
        .onAppear {
            do {
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
                
                self.session.requestRecordPermission { (status) in
                    if !status {
                        self.alert.toggle()
                    }
                    else {
                        self.getAudios()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudios() {
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            self.audios.removeAll()
            
            for i in result {
                self.audios.append(i)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
