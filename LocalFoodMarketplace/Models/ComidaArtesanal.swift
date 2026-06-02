import Foundation
import SwiftUI

struct ComidaArtesanal: Identifiable, Hashable {
    let id: UUID
    var nome: String
    var cozinheiro: String
    var distancia: String
    var preco: Double
    var categoria: String
    var imagemNome: String // Nome do SF Symbol
    var descricao: String
    var isFavorito: Bool
    
    // Gradiente personalizado para cada comida para criar um visual premium na interface
    var gradienteCores: [Color] {
        switch categoria {
        case "Festas":
            return [Color.pink, Color.purple]
        case "Bolos":
            return [Color.orange, Color.red]
        case "Sem Glúten":
            return [Color.teal, Color.blue]
        case "Vegano":
            return [Color.green, Color.teal]
        case "Jantar":
            return [Color.blue, Color.indigo]
        case "Mexicana":
            return [Color.yellow, Color.orange]
        case "Asiática":
            return [Color.red, Color.orange]
        default:
            return [Color.gray, Color.black]
        }
    }
    
    // Formatador de preço em Reais (BRL)
    var precoFormatado: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: preco)) ?? String(format: "R$ %.2f", preco)
    }
    
    // Descrição detalhada para acessibilidade (VoiceOver)
    var acessibilidadeDescricaoImagem: String {
        switch nome {
        case "Kit Festa Completo":
            return "Foto ilustrativa de um Kit Festa com um lindo bolo de chocolate decorado, brigadeiros gourmet e salgadinhos variados."
        case "Bolo da Vovó de Fubá":
            return "Foto de um Bolo da vovó de fubá tradicional fofinho, com casca dourada e erva-doce recém-assado."
        case "Ceia de Natal Pronta":
            return "Foto de uma ceia de natal completa com Chester assado dourado, arroz à grega e rabanadas."
        case "Salgados Sem Glúten":
            return "Foto de salgadinhos assados sem glúten dourados e polvilhados com ervas."
        case "Salgados Veganos Assados":
            return "Foto de salgados veganos assados recheados com palmito e cogumelos."
        case "Janta Vegana Completa":
            return "Foto de um prato de janta vegana colorida com hambúrguer de grão-de-bico, arroz integral e salada fresca."
        case "Tacos Mexicanos Artesanais":
            return "Foto de três tacos mexicanos artesanais montados em tortillas de milho com guacamole e pico de gallo."
        case "Lámen Caseiro Especial":
            return "Foto de uma tigela fumegante de lámen caseiro japonês com caldo encorpado, ovo marinado e cebolinhas."
        default:
            return "Foto ilustrativa de \(nome)."
        }
    }
}

// Mock Data
extension ComidaArtesanal {
    static var mockList: [ComidaArtesanal] = [
        ComidaArtesanal(
            id: UUID(),
            nome: "Kit Festa Completo",
            cozinheiro: "Dona Maria Doces",
            distancia: "1.2 km de você",
            preco: 189.90,
            categoria: "Festas",
            imagemNome: "kit-festa",
            descricao: "Kit completo ideal para comemorações de até 10 pessoas. Inclui: 1 bolo decorado de chocolate (1.5kg), 50 brigadeiros gourmet enrolados na hora, 2 garrafas de refrigerante de 2L e 100 salgadinhos fritos variados (coxinha, bolinha de queijo, rissole). Tudo fresquinho e feito com ingredientes de primeira qualidade.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Bolo da Vovó de Fubá",
            cozinheiro: "Vovó Alzira",
            distancia: "0.8 km de você",
            preco: 25.00,
            categoria: "Bolos",
            imagemNome: "bolo-fuba",
            descricao: "Tradicional bolo de fubá com erva-doce, fofinho e recém-saído do forno. Perfeito para acompanhar o café da tarde em família. Feito com milho selecionado e carinho de avó. Não contém conservantes.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Ceia de Natal Pronta",
            cozinheiro: "Chef Roberto",
            distancia: "3.5 km de você",
            preco: 450.00,
            categoria: "Jantar",
            imagemNome: "ceia-natal",
            descricao: "Ceia natalina completa para até 6 pessoas. Acompanha: Chester assado decorado com frutas em calda, arroz à grega aromático, farofa rica natalina com bacon e frutas secas, salpicão de frango defumado clássico e uma travessa média de rabanadas tradicionais.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Salgados Sem Glúten",
            cozinheiro: "Fit & Tasty Cozinha",
            distancia: "2.1 km de você",
            preco: 45.00,
            categoria: "Sem Glúten",
            imagemNome: "salgados-sem-gluten",
            descricao: "Cento de mini salgadinhos assados sem glúten (coxinha de batata doce com frango, empadinha de palmito e bolinho de mandioca com carne seca). Preparados em cozinha 100% isolada e livre de contaminação cruzada, ideal para celíacos.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Salgados Veganos Assados",
            cozinheiro: "Horta no Prato",
            distancia: "1.5 km de você",
            preco: 48.00,
            categoria: "Vegano",
            imagemNome: "salgados-veganos",
            descricao: "Porção de 20 salgados assados artesanais totalmente livres de ingredientes de origem animal. Recheios de palmito cremoso com alho-poró, shimeji temperado e proteína de soja com ervas finas. Massa leve feita com farinha integral.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Janta Vegana Completa",
            cozinheiro: "NaturalMente Bistrô",
            distancia: "1.7 km de você",
            preco: 38.00,
            categoria: "Vegano",
            imagemNome: "janta-vegana",
            descricao: "Prato do dia vegano completo e balanceado. Acompanha: arroz integral com gergelim, feijão azuki temperado com louro, hambúrguer artesanal de grão-de-bico com especiarias, legumes grelhados (abobrinha, berinjela e cenoura) e uma salada verde fresca.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Tacos Mexicanos Artesanais",
            cozinheiro: "Viva Zapata Cocina",
            distancia: "2.8 km de você",
            preco: 35.00,
            categoria: "Mexicana",
            imagemNome: "tacos",
            descricao: "Combo com 3 tacos mexicanos crocantes com tortillas de milho feitas à mão. Acompanha recheio de carne desfiada temperada (ou opção de chilli vegano de lentilha), guacamole fresca feita no dia, pico de gallo e sour cream artesanal.",
            isFavorito: false
        ),
        ComidaArtesanal(
            id: UUID(),
            nome: "Lámen Caseiro Especial",
            cozinheiro: "Koji Ramen House",
            distancia: "4.0 km de você",
            preco: 52.00,
            categoria: "Asiática",
            imagemNome: "lamen",
            descricao: "Lámen tradicional japonês preparado com caldo de porco (Tonkotsu) cozido por 12 horas para máximo sabor, macarrão caseiro fresco, fatias de Chashu (panceta marinada), ovo Ajitama perfeitamente cozido com gema mole, menma (brotos de bambu) e cebolinha fresca.",
            isFavorito: false
        )
    ]
}
