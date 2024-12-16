import SwiftUI

struct WaveSound: View {
    @State private var recording = false
    @State private var audioLevels: [Double] = [0.1, 0.2, 0.3, 0.4, 0.5]
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(audioLevels.indices, id: \.self) { index in
                    WaveBar(level: audioLevels[index], isRecording: recording)
                }
            }
            .padding(.bottom, 20)
            
            Button {
                if recording {
                    stopRecording()
                } else {
                    startRecording()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(recording ? Color.red.opacity(0.3) : Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .scaleEffect(recording ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: recording)
                    
                    Image(systemName: recording ? "stop.fill" : "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(recording ? .red : .blue)
                }
            }
        }
        .padding()
        .onAppear(perform: simulateAudioLevels)
    }
    
    // Simula níveis de áudio dinâmicos
    func simulateAudioLevels() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if recording {
                // Atualiza níveis de áudio durante gravação
                audioLevels = audioLevels.map { _ in Double.random(in: 0.1...1.0) }
            } else {
                // Mantém níveis baixos quando não está gravando
                audioLevels = audioLevels.map { _ in Double.random(in: 0.1...0.2) }
            }
        }
    }
    
    func startRecording() {
        recording = true
    }
    
    func stopRecording() {
        recording = false
    }
}

struct WaveBar: View {
    let level: Double
    let isRecording: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(LinearGradient(
                colors: [
                    isRecording ? Color.blue : Color.gray,
                    isRecording ? Color.green.opacity(level) : Color.gray.opacity(0.5)
                ],
                startPoint: .bottom,
                endPoint: .top
            ))
            .frame(width: 6, height: CGFloat(level * 100))
            .animation(.easeInOut(duration: 0.2), value: level)
    }
}
