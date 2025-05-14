import SwiftUI

struct AvaliacaoView: View {
    var musica: Musica

    @State private var rating: Int = 0
    @State private var comentario: String = ""

    var body: some View {
        ZStack {
            // Background com a imagem da música
            AsyncImage(url: URL(string: musica.foto)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .blur(radius: 3)
                        .overlay(Color.black.opacity(0.6)) // escurece o fundo para contraste
                } else {
                    Color.black.ignoresSafeArea()
                }
            }

            // Conteúdo principal
            VStack(spacing: 20) {
                // Título "Curtiu?"
                Text("Curtiu?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.yellow)

                // Texto "Qual sua nota?"
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

                // Campo de comentário com avatar e fundo preto
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

                // Botão de avaliação
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
                .padding(.top, 20)

                Spacer()
            }
            .padding(.top, 50)
            .padding(.bottom)
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

