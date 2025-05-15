import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MusicaViewModel()
    
    var body: some View {
        ZStack {
            // Fundo preto para toda a tela
            Color.black.ignoresSafeArea()
            
            if let musica = viewModel.musica {
                // Camada inferior com imagem de fundo em blur
                VStack(spacing: 0) {
                    // Imagem de fundo com blur e opacidade
                    AsyncImage(url: URL(string: musica.foto)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 10)
                                .opacity(0.8)
                        } else {
                            // Cor de fallback enquanto carrega
                            Color.gray
                        }
                    }
                    .frame(height: 150) // Altura do fundo
                    .ignoresSafeArea(edges: .top)
                    
                    Spacer().frame(height: 100) // Espaço abaixo da imagem
                        
                    // Parte inferior preta que completa o fundo
                    Rectangle()
                        .fill(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                // Imagem da capa da música (em destaque)
                AsyncImage(url: URL(string: musica.foto)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 200, height: 200)
                .offset(y: -200)
                .zIndex(1)
                
                // Informações da música
                VStack {
                    Text(musica.nome)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text(musica.artista)
                        .foregroundStyle(.gray)
                        .font(.system(size: 20))
                        .bold()
                    
                    Text(musica.ano)
                        .foregroundStyle(.gray)
                        .font(.system(size: 15))
                }
                .offset(y: -40)
                
                Spacer()
                
                // Ícones de players de música com botões alinhados
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Spotify
                    HStack {
                        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Spotify_logo_with_text.svg/800px-Spotify_logo_with_text.svg.png")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 80, height: 20)
                            }
                        }
                        Spacer()
                        Label("Play", systemImage: "play.fill")
                            .padding(.horizontal, 8)
                            .frame(width: 80, height: 36)
                            .background(RoundedRectangle(cornerRadius: 60)
                                .fill(Color.customColor.primaryColor))
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }
                    
                    // Apple Music
                    HStack {
                        AsyncImage(url: URL(string: "https://jeremysassoon.com/wp-content/uploads/2018/06/itunes-logo-png-transparent2-300x117.png")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 80, height: 26)
                            }
                        }
                        Spacer()
                        Label("Play", systemImage: "play.fill")
                            .padding(.horizontal, 8)
                            .frame(width: 80, height: 36)
                            .background(RoundedRectangle(cornerRadius: 60)
                                .fill(Color.customColor.primaryColor))
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }
                    
                    // YouTube Music
                    HStack {
                        AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_RaxzS2HDc8O5VR0Cd9niyRLdPeTwC_8W2w&s")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 80, height: 16)
                            }
                        }
                        Spacer()
                        Label("Play", systemImage: "play.fill")
                            .padding(.horizontal, 8)
                            .frame(width: 80, height: 36)
                            .background(RoundedRectangle(cornerRadius: 60)
                                .fill(Color.customColor.primaryColor))
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }
                }
                .padding(.top, 250)
                .padding(.horizontal, 40)
            } else {
                Text("Carregando música...")
                    .foregroundColor(Color.customColor.primaryColor)
            }
        }
        .onAppear {
            viewModel.buscarMusicaAleatoria()
        }
    }
}

#Preview {
    HomeView()
}
