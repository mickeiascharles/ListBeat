import SwiftUI

struct Main: View {
    @StateObject private var viewModel = AvaliacoesViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea() // Fundo preto
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Carregando avaliações...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.white)
                            .padding()
                    } else if viewModel.avaliacoes.isEmpty {
                        Text("Nenhuma avaliação encontrada.")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                ForEach(viewModel.avaliacoes) { avaliacao in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(avaliacao.nome)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(avaliacao.artista)
                                            .font(.subheadline)
                                            .foregroundColor(Color.customColor.primaryColor)
                                        
                                        HStack(spacing: 2) {
                                            ForEach(1...5, id: \.self) { index in
                                                Image(systemName: index <= avaliacao.avaliacao ? "star.fill" : "star")
                                                    .foregroundColor(index <= avaliacao.avaliacao ? .white : .gray)
                                                    .padding(.top)
                                                    .font(.system(size: 14)) // ⭐️ Reduz tamanho da estrela
                                            }
                                        }
                                        
                                        HStack(alignment: .top, spacing: 16) {
                                            AsyncImage(url: URL(string: avaliacao.foto)) { phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                } else if phase.error != nil {
                                                    Color.red
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                } else {
                                                    ProgressView()
                                                        .frame(width: 100, height: 100)
                                                }
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 6) {
                                            
                                                
                                                Text(" \(avaliacao.comentario)")
                                                    .font(.body)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    .padding()
                                    .cornerRadius(12)
                                    Divider()
                                        .frame(minHeight: 1.5)
                                        .background(Color.gray)
                                        .opacity(0.3)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchAvaliacoes()
            }
            .navigationBarTitle("Avaliações", displayMode: .inline)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
