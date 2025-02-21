import SwiftUI

struct HomeView: View {
    @AppStorage("username") var username: String = ""
    @State private var showProfileView: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    greetingSection
                    
                    VStack(alignment: .leading, spacing: 30) {
                        HStack(spacing: 21) {
                            CustomRectangle(
                                text: "Challenge yourself!",
                                gradient: LinearGradient(
                                    colors: [Color.blue, Color.cyan],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                info: "Tongue Twister",
                                icon: "sparkles",
                                view: AnyView(TongueTwisterView())
                            )
                            CustomRectangle(
                                text: "Review your audios",
                                gradient: LinearGradient(
                                    colors: [Color.red, Color.orange],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                info: "Recordings",
                                icon: "mic.fill",
                                view: AnyView(RecordingsView())
                            )
                        }
                        
                        Text("Phonemes")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        
                        PhonemeListView()
                        
                    }
                    .padding()
                }
                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
//                .padding(.top, 35)
                .padding(.vertical, 30)
                .font(.system(.body, design: .rounded))
                .sheet(isPresented: $showProfileView) {
                    ProfileView()
                }
            }
        }
    }
    
    var greetingSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(username)")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Text("Welcome back! Keep practicing.")
                    .foregroundStyle(.gray)
            }
            .padding()
            
            Spacer()
            
            Button {
                showProfileView.toggle()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundStyle(.blue)
                    
                    Text(username.prefix(1))
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            
            Spacer().frame(maxWidth: 20)
        }
//        .padding(.top)
    }
}

// Para deficiência auditiva, considere suporte a dispositivos de audição Bluetooth ou implantes cocleares.
