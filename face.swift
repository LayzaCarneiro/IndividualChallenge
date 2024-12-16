import SwiftUI
import ARKit

struct ARFaceTrackingView: UIViewRepresentable {
    @Binding var feedbackText: String // Para o texto dinâmico de feedback

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator

        // Configuração do rastreamento facial
        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)

        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(feedbackText: $feedbackText)
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        @Binding var feedbackText: String

        init(feedbackText: Binding<String>) {
            _feedbackText = feedbackText
        }

        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return }

            // Recupera os valores de jawOpen e tongueOut
            let jawOpenValue = faceAnchor.blendShapes[.jawOpen]?.floatValue ?? 0.0
            let tongueOutValue = faceAnchor.blendShapes[.tongueOut]?.floatValue ?? 0.0

            DispatchQueue.main.async {
                // Atualiza o texto com base no estado da língua
                if tongueOutValue > 0.0000005 {
                    self.feedbackText = "Língua para fora!"
                } else if jawOpenValue > 0.5 {
                    self.feedbackText = "Boca aberta!"
                }
                else {
                    self.feedbackText = "Boa abertura!"
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var feedbackText: String = "Movimente a boca e a língua!"

    var body: some View {
        ZStack {
            // ARKit para rastreamento facial
            ARFaceTrackingView(feedbackText: $feedbackText)
                .edgesIgnoringSafeArea(.all)

            // Feedback visual para o usuário
            VStack {
                Spacer()
                Text(feedbackText)
                    .font(.headline)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

