import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var isPresented = false
    
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
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(1...12, id: \.self) { index in
                                Button {
                                    isPresented = true
                                } label: {
                                    Text("Button \(index)")
                                        .frame(width: 250, height: 150)
                                        .background(Color.blue.opacity(0.7))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .fullScreenCover(isPresented: $isPresented, content: ExerciseView.init)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Hi Layza")
        }
    }
}
