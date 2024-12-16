import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        HStack {
                            Text("Welcome back! Keep practicing.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.leading, 7)
                            
                            Spacer()
                            
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.black)
                                .padding(.top, -60)
                                .padding(.trailing, 7)
                        }
                        .padding(.top, -18)
                        
                        HStack(spacing: 21) {
                            CustomRectangle(
                                text: "Challenge yourself!",
                                gradient: LinearGradient(
                                    colors: [Color.blue, Color.cyan],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                info: "Tongue Twister",
                                icon: "sparkles"
                            )
                            CustomRectangle(
                                text: "Review your audios",
                                gradient: LinearGradient(
                                    colors: [Color.red, Color.orange],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                info: "Recordings",
                                icon: "mic.fill"
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
            }
            .navigationTitle("Hi, Layza")
        }
    }
}

// Para deficiência auditiva, considere suporte a dispositivos de audição Bluetooth ou implantes cocleares.
