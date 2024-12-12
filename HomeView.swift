import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 30) {
                        HStack(spacing: 21) {
                            CustomRectangle(text: "suggestion")
                            CustomRectangle(text: "offensive")
                        }
                        
                        Text("Phonemes")
                            .font(.title)
                            .fontWeight(.medium)
                        
                        PhonemeListView()
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Hi Little Person")
        }
    }
}
