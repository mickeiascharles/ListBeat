import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MusicaViewModel()

    var body: some View {
        VStack {
            if let musica = viewModel.musica {
//puxa com musica.ano
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "menucard.fill")
                            Text("Menu")
                        }
                    Text("Carrinho")
                        .tabItem {
                            Image(systemName: "cart.fill")
                            Text("Carrinho")
                        }
                    Text("Configurações")
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Configurações")
                        }
                }
            } else {
                Text("Carregando música...")
                    .font(.headline)
            }
        }
        .onAppear {
            viewModel.buscarMusicaAleatoria()
        }
    }
}

// Preview atualizado com ContentView
#Preview {
    HomeView()
}
