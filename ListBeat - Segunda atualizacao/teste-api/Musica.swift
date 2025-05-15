import Foundation

// Estrutura que corresponde ao JSON
struct Musica: Identifiable, Codable {
    var id: String { _id ?? UUID().uuidString }  // Usando um UUID gerado caso _id seja nulo
    var _id: String?
    var nome: String
    var foto: String
    var artista: String
    var ano: Int
    var album: String
    
    

}
