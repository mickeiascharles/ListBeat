import Foundation

class MusicaViewModel: ObservableObject {
    @Published var musica: Musica?

    func buscarMusicaAleatoria() {
        let urlString = "http://192.168.128.90:1880/leitura" // URL local do seu servidor Node-RED
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Supondo que a resposta seja uma lista de músicas
                    let musicas = try JSONDecoder().decode([Musica].self, from: data)
                    if let musicaAleatoria = musicas.randomElement() {
                        DispatchQueue.main.async {
                            self.musica = musicaAleatoria
                        }
                    }
                } catch {
                    print("Erro ao decodificar dados: \(error)")
                }
            } else if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
            }
        }.resume()
    }
}
