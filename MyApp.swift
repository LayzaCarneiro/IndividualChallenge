import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            AudioApp(audioRecorder: AudioRecorder())
        }
    }
}
