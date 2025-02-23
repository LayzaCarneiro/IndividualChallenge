import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {                
                ContentView()
                    .ignoresSafeArea(.all)
            }
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
