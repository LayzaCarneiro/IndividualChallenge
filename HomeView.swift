import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 30) {
                        HStack {
                            Rectangle()
                                .frame(width: 350, height: 150)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .frame(width: 350, height: 150)
                                .cornerRadius(10)
                        }
                        
                        Text("Phonemes")
                            .font(.title)
                            .fontWeight(.medium)
                        
                        PhonemeListView()
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Hi Layza")
        }
    }
}
