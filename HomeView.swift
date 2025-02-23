import SwiftUI

struct HomeView: View {
    @AppStorage("username") var username: String = "Little Person"
    @State private var showProfileView: Bool = false
    @State private var isExerciseViewPresented: Bool = false
    @State private var phonemeExercise: Phoneme = Phoneme(letter: "s", symbol: "/s/", description: "", tips: [], words: [], soundFile: "s.mp4", icon: "")

    var body: some View {
        NavigationStack {
            ZStack {
                Color("offWhite").ignoresSafeArea()
                
                if(isExerciseViewPresented) {
                    ExerciseView(isPresented: $isExerciseViewPresented, phoneme: phonemeExercise)
                }
                else {
                    ScrollView {
                        greetingSection
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 11) {
                                CustomRectangle(gradient: LinearGradient(
                                    colors: [Color.blue, Color.cyan],
                                    startPoint: .top,
                                    endPoint: .bottom),
                                                title: "Tongue Twister",
                                                imageName: "tongueTwisterIcon",
                                                icon: "sparkles",
                                                subtitle: "Challenge yourself!",
                                                view: AnyView(TongueTwisterView())
                                )
                                
                                CustomRectangle(gradient: LinearGradient(
                                    colors: [Color("lightYellow"), Color("darkYellow")],
                                    startPoint: .top,
                                    endPoint: .bottom),
                                                title: "Review your audios",
                                                imageName: "waveSound",
                                                icon: "mic.fill",
                                                subtitle: "Review your audios",
                                                view: AnyView(RecordingsView())
                                )
                            
                                WeekView()
                            }
                            
                            Text("Phonemes")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            PhonemeListView(isExerciseViewPresented: $isExerciseViewPresented, phonemeExercise: $phonemeExercise)
                            
                            Text("Tongue Twisters")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            TongueTwisterListView()
                            
                            
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
            .padding()
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
