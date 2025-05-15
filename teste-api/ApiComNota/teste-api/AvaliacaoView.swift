import SwiftUI

struct AvaliacaoView: View {
    @State var musica: Musica
    @ObservedObject var viewModel: MusicaViewModel

    @State private var rating: Int = 0
    @State private var comentario: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Imagem no topo
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
                        Text("Curtiu?")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.yellow)
                            .padding(.top, -60)
                            .padding(.bottom, 10)

                        Text("Qual sua nota?")
                            .foregroundColor(.gray)
                            .font(.headline)

                        // Estrelas de avaliação
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

                        // Botão de avaliação
                        Button(action: {
                            guard rating > 0 else { return } // Evita salvar sem nota

                            musica.avaliacao = rating
                            musica.comentario = comentario
                            viewModel.salvarAvaliacao(musica: musica)
                            dismiss() // Volta para a tela anterior
                        }) {
                            Text("AVALIAR")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(rating > 0 ? Color.yellow : Color.gray)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .font(.headline)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                        .disabled(rating == 0)

                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    AvaliacaoView(
        musica: Musica(
            _id: "1",
            nome: "Fake Plastic Trees",
            foto: "https://upload.wikimedia.org/wikipedia/en/0/0e/Radioheadthebends.png",
            artista: "Radiohead",
            ano: 1995,
            album: "The Bends"
        ),
        viewModel: MusicaViewModel()
    )
}

