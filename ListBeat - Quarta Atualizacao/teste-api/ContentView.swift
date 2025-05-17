import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MusicaViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let musica = viewModel.musica {
                    VStack(spacing: 20) {
                        // Imagem da capa da música
                        AsyncImage(url: URL(string: musica.foto)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(12)
                                    .shadow(radius: 10)
                            } else if phase.error != nil {
                                Color.red.frame(width: 200, height: 200)
                            } else {
                                ProgressView().frame(width: 200, height: 200)
                            }
                        }

                        // Título da música
                        Text(musica.nome)
                            .font(.title2)
                            .foregroundColor(.primary)

                        // Botão para ir à AvaliacaoView
                        NavigationLink(destination: AvaliacaoView(musica: musica, viewModel: viewModel)) {
                            Text("Avaliar Música")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                } else {
                    Spacer()
                    ProgressView("Carregando música...")
                        .font(.headline)
                    Spacer()
                }
            }
            .navigationTitle("Sopro do Dia")
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            viewModel.buscarMusicaAleatoria()
        }
        .tabViewWrapper
    }
}

// Wrapper para TabView com extensão
extension View {
    var tabViewWrapper: some View {
        TabView {
            self
                .tabItem {
                    Label("Menu", systemImage: "menucard.fill")
                }

            Text("Carrinho")
                .tabItem {
                    Label("Carrinho", systemImage: "cart.fill")
                }

            Text("Configurações")
                .tabItem {
                    Label("Configurações", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}

