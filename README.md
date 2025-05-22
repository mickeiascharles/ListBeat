# ListBeat

Objetivo do Projeto:
Criar um catálogo musical pessoal, no estilo Letterboxd (para filmes), mas adaptado para músicas. O usuário pode adicionar músicas ou álbuns, avaliá-los, deixar comentários, criar listas de favoritos e acompanhar o histórico das músicas que já ouviu. O sistema será offline e utilizará um banco de dados não relacional (JSON ou SQLite) para armazenamento local dos dados.

Funcionalidades Principais:

Cadastro de Músicas/Álbuns: O usuário pode adicionar músicas ou álbuns ao seu catálogo pessoal com informações como:

- Nome da música/álbum
- Artista
- Gênero
- Ano de lançamento
- Avaliação e Comentários:
- O usuário pode avaliar a música ou o álbum com uma nota de 1 a 5 estrelas.
- Ele também pode comentar sobre a música, deixando uma resenha pessoal.

Listas Personalizadas:

O usuário pode criar listas personalizadas de músicas/álbuns, como "Melhores de 2025", "Músicas para Relaxar", etc.

Histórico de Músicas:
O sistema mantém um histórico das músicas/álbuns que o usuário já adicionou, com data e avaliação.
Catálogo Visual:
O usuário pode visualizar as músicas ou álbuns que ele já adicionou, filtrando por gênero, artista ou nota.

Motivação:
O projeto foi criado para resolver a falta de uma plataforma simples e pessoal para quem deseja catalogar, avaliar e organizar suas músicas e álbuns de forma completamente independente. Ao invés de depender de plataformas de streaming, o usuário tem total controle sobre o seu próprio catálogo musical, sem necessitar de uma conexão constante à internet.

Impacto Esperado:
Ao finalizar o projeto, o usuário terá uma plataforma dinâmica e acessível para manter seu catálogo musical pessoal, podendo acompanhar suas músicas favoritas, suas avaliações e descobrir novas faixas com base no que já escutou e avaliou. Isso vai melhorar a forma como ele organiza e revisita suas músicas preferidas.

link notion: https://vanilla-pantydraco-c7e.notion.site/ListBeat-HackaTruck-1f48248be9aa80ab9f64d540ea5a4ab5

if isLoading {
                    VideoPlayer(player: player)
                        .ignoresSafeArea()
                        .onAppear {
                            if let url = Bundle.main.url(forResource: "ANIMAÇÃO LISTBEAT", withExtension: "mp4") {
                                player.replaceCurrentItem(with: AVPlayerItem(url: url))
                                player.isMuted = true
                                player.play()
                            }
                        }
                        .frame(height: 180)
