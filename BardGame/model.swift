import Foundation

class BardsGame {
    

    var pontosJogador: Int = 5
    let pontosVitoria: Int = 12
    let pontosDerrota: Int = 0

    func iniciarJogo() {

        print("⚜️Bardo: 'Rápido, como te chamas e qual o teu título?' \n(ex: Gerson-O-Bardo)")
        var nomeJogador = "Aventureiro"
        var conector =  "O"

        if let entrada = readLine() {

            let partes = entrada.split(separator: "-")

            if !partes.isEmpty {
                nomeJogador = String(partes[0])
            }
            if partes.count >= 2 {
                conector = String(partes[1])
            }
        }
        print("")

        print("""
              ⚜️Bardo: 'Nobre \(nomeJogador)! Preciso de sua ajuda para compor uma canção para o Rei.
              Me encontro com um pequeno... bloqueio criativo.'
              """)

        print("\n--- Você começa com \(pontosJogador) pontos de Inspiração Real ---")


        Loop: while true {

            for cancao in todasAsCancoes.shuffled() {

                let humorAtualDoRei = HumorDoRei.allCases.randomElement()!

                print("\n--- O Bardo se prepara para iniciar: \(cancao.titulo) ---")

                for desafio in cancao.desafios {

                    let tagEscolhida = apresentarDesafio(desafio)

                    let (pontosGanhos, feedbackRei) = calcularFeedback(tag: tagEscolhida, humor: humorAtualDoRei)

                    pontosJogador += pontosGanhos
                    print("\n\(feedbackRei)")
                    print("Pontuação: \(pontosJogador)")
                    
                    if pontosJogador < 2 {
                        print ("\n⚜️Bardo: Desse jeito vamos ser mandados para a forca!")
                    }
                    
                    if pontosJogador > 10 {
                        print ("\n⚜️Bardo: Estamos quase lá, é melhor não desafinar")
                    }

                    if pontosJogador >= pontosVitoria {
                        print("\n🫅REI: 'GENIAL! PERFEITO! NUNCA OUVI ALGO TÃO BOM!'")

                        let tituloVitoria = ["Gogódeouro", "Puxasaco",  "Sudito", "Docecantar", "Heraldo", "Bobodacorte"]
                        let tituloPartes = tituloVitoria.randomElement() ?? "Trovador"

                        print("🎉🎉🎉 Você e o Bardo são ovacionados! Você ganha o titulo de '\(nomeJogador)-\(conector)-\(tituloPartes)'!!!.")
                        print("\n--- E TODOS VIVERAM FELIZES PARA SEMPRE! ---")

                        print("\n\n[Pressione qualquer tecla para jogar novamente...]")
                        _ = readLine()
                        pontosJogador = 5
                        print("\n--- Você tem \(pontosJogador) pontos de Inspiração Real ---")
                        continue Loop

                    } else if pontosJogador <= pontosDerrota {
                        print("\n🫅REI: 'GUARDAS! TIREM ESSES PATETAS DA MINHA FRENTE!'")
                        print("Você e o Bardo são expulsos do reino para nunca mais voltar.")
                        print("\n--- GAME OVER ---")

                        print("\n\n[Pressione qualquer tecla para jogar novamente...]")
                        _ = readLine()
                        pontosJogador = 5
                        print("\n--- Você tem \(pontosJogador) pontos de Inspiração Real ---")
                        continue Loop
                    }
                }
            }
            
            print("\n⚜️Bardo: 'Ufa! O Rei parece engajado...mas ele quer mais!'")
        }
    }

    private func apresentarDesafio(_ desafio: (bardoInicia: String, opcoes: [(texto: String, tag: TagVerso)])) -> TagVerso {
        print("\n⚜️Bardo: '\(desafio.bardoInicia)'")

        for (index, opcao) in desafio.opcoes.enumerated() {
            print("[\(index + 1)] \(opcao.texto)")
        }

        while true {
            
            print("\nDigite 1, 2, ou 3:")

            if let textoEntrada = readLine(), let escolhaNum = Int(textoEntrada) {

                if escolhaNum >= 1 && escolhaNum <= desafio.opcoes.count {
                    return desafio.opcoes[escolhaNum - 1].tag
                }
            }
            print("'Pare de falar abobrinha!', resmunga o Bardo.")
        }
    }

    private func calcularFeedback(tag: TagVerso, humor: HumorDoRei) -> (pontos: Int, feedback: String) {

        switch (tag, humor) {

        case (.exaltando, .vaidoso):
            return (2, "+2 Pontos! | 🫅REI: 'Exatamente! Eu sou incrível!'")
        case (.comico, .brincalhao):
            return (2, "+2 Pontos! | 🫅REI: 'HAHA! Adorei essa!'")
        case (.exaltando, .brincalhao):
            return (-2, "-2 Pontos! | 🫅REI: 'Quanta BAJULAÇÃO! PATÉTICO!'")
        case (.comico, .vaidoso):
            return (-2, "-2 Pontos! | 🫅REI: 'Está zombando de mim?!'")
        case (.neutro, .brincalhao):
            return (1, "+1 Ponto. | 🫅REI: '...hm. Prossiga.'")
        case (.neutro, .vaidoso):
            return (-1, "-1 Ponto. | 🫅REI: 'zZzzZZZzzzzZZZzzz.'")
        }
    }
}

