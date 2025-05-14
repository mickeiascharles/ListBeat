import SwiftUI
//atualizado
struct AvaliacaoView: View {
    var musica: Musica

    @State private var rating: Int = 0
    @State private var comentario: String = ""

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Imagem no topo (1/3 da tela)
                    AsyncImage(url: URL(string: musica.foto)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.33)
                                .clipped()
                                .blur(radius: 5)
                                .overlay(Color.black.opacity(0.4))
                        } else {
                            Color.gray
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.33)
                        }
                    }

                    // Conteúdo principal
                    VStack(spacing: 20) {
                        // Título "Curtiu?" com leve sobreposição na imagem
                        Text("Curtiu?")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.yellow)
                            .padding(.top, -60)
                            .padding(.bottom, 10)

                        Text("Qual sua nota?")
                            .foregroundColor(.gray)
                            .font(.headline)

                        // Estrelas
                        HStack {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        rating = star
                                    }
                            }
                        }

                        // Campo de comentário
                        HStack(alignment: .top) {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)

                            ZStack(alignment: .topLeading) {
                                if comentario.isEmpty {
                                    Text("Adicione um comentário...")
                                        .foregroundColor(.gray)
                                        .padding(12)
                                }

                                TextEditor(text: $comentario)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.8))
                                    .cornerRadius(10)
                            }
                            .frame(height: 100)
                        }
                        .padding(.horizontal)

                        // Botão
                        Button(action: {
                            print("Nota: \(rating), Comentário: \(comentario)")
                        }) {
                            Text("AVALIAR")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .font(.headline)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 10)

                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    AvaliacaoView(musica: Musica(
        _id: "1",
        nome: "Fake Plastic Trees",
        foto: "https://upload.wikimedia.org/wikipedia/en/0/0e/Radioheadthebends.png",
        artista: "Radiohead",
        ano: 1995,
        album: "The Bends"
    ))
}

