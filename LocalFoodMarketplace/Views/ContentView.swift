import SwiftUI

struct ContentView: View {
    @State private var comidas: [ComidaArtesanal] = ComidaArtesanal.mockList
    @State private var searchText = ""
    @State private var selectedCategory = "Todos"
    @State private var apenasFavoritos = false
    
    // Categorias disponíveis no aplicativo
    let categorias = ["Todos", "Festas", "Bolos", "Sem Glúten", "Vegano", "Jantar", "Mexicana", "Asiática"]
    
    // Configuração do Grid Adaptativo conforme requisito (mínimo 160 pontos)
    let colunasGrid = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    // Filtro dos pratos com base na categoria, busca e filtro de favoritos
    var comidasFiltradas: [ComidaArtesanal] {
        comidas.filter { comida in
            let matchesCategory = selectedCategory == "Todos" || comida.categoria == selectedCategory
            let matchesSearch = searchText.isEmpty ||
                comida.nome.localizedCaseInsensitiveContains(searchText) ||
                comida.cozinheiro.localizedCaseInsensitiveContains(searchText) ||
                comida.categoria.localizedCaseInsensitiveContains(searchText)
            let matchesFavorito = !apenasFavoritos || comida.isFavorito
            
            return matchesCategory && matchesSearch && matchesFavorito
        }
    }
    
    // Helper para obter a vinculação (Binding) de um item específico na lista
    private func binding(for comida: ComidaArtesanal) -> Binding<ComidaArtesanal> {
        guard let index = comidas.firstIndex(where: { $0.id == comida.id }) else {
            fatalError("Item não encontrado")
        }
        return $comidas[index]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Cabeçalho Interno Premium
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Descobrir")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                        
                        Text("Mercado Caseiro")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Filtro de Categorias Horizontal
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categorias, id: \.self) { categoria in
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedCategory = categoria
                                    }
                                }) {
                                    Text(categoria)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(
                                            Capsule()
                                                .fill(selectedCategory == categoria ? Color.primary : Color(.secondarySystemBackground))
                                        )
                                        .foregroundColor(selectedCategory == categoria ? Color(.systemBackground) : .primary)
                                }
                                .accessibilityLabel("Categoria: \(categoria)")
                                .accessibilityHint("Toque para filtrar por \(categoria)")
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Banner de Favoritos Ativo
                    if apenasFavoritos {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text("Exibindo apenas favoritos")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Spacer()
                            Button("Mostrar Todos") {
                                withAnimation {
                                    apenasFavoritos = false
                                }
                            }
                            .font(.footnote)
                            .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Vitrine Virtual com LazyVGrid
                    if comidasFiltradas.isEmpty {
                        VStack(spacing: 20) {
                            Spacer(minLength: 40)
                            Image(systemName: apenasFavoritos ? "heart.slash" : "magnifyingglass")
                                .font(.system(size: 60))
                                .foregroundColor(.secondary)
                            Text(apenasFavoritos ? "Nenhum favorito encontrado" : "Nenhum prato encontrado")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text(apenasFavoritos ? "Adicione pratos aos favoritos para visualizá-los aqui." : "Tente buscar por outra categoria ou cozinheiro.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        LazyVGrid(columns: colunasGrid, spacing: 16) {
                            ForEach(comidasFiltradas) { comida in
                                NavigationLink(destination: DetalhesProdutoView(comida: binding(for: comida))) {
                                    ComidaCardView(comida: binding(for: comida))
                                }
                                .buttonStyle(PlainButtonStyle()) // Remove estilo de botão padrão na célula inteira
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Buscar prato, categoria ou cozinheiro")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            apenasFavoritos.toggle()
                        }
                    }) {
                        Image(systemName: apenasFavoritos ? "heart.fill" : "heart")
                            .foregroundColor(apenasFavoritos ? .red : .primary)
                    }
                    .frame(minWidth: 44, minHeight: 44) // A11y Touch Target
                    .accessibilityLabel(apenasFavoritos ? "Mostrar todos os pratos" : "Mostrar apenas pratos favoritos")
                }
            }
        }
    }
}

// Card Individual de Comida para o Grid
struct ComidaCardView: View {
    @Binding var comida: ComidaArtesanal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Imagem Decorativa (Gradiente + SF Symbol)
            ZStack(alignment: .topTrailing) {
                LinearGradient(
                    colors: comida.gradienteCores,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 130)
                
                Image(systemName: comida.imagemNome)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.white)
                    .position(x: 80, y: 65) // Centralizado na imagem
                
                // Botão de Favoritar com área de toque mínima de 44x44
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        comida.isFavorito.toggle()
                    }
                }) {
                    Image(systemName: comida.isFavorito ? "heart.fill" : "heart")
                        .foregroundColor(comida.isFavorito ? .red : .white)
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.3))
                        )
                        .padding(8)
                }
                .frame(minWidth: 44, minHeight: 44) // A11y Touch Target
                .accessibilityLabel(comida.isFavorito ? "Remover \(comida.nome) dos favoritos" : "Favoritar \(comida.nome)")
            }
            .frame(height: 130)
            .clipped()
            .accessibilityElement(children: .ignore) // Ignora componentes internos na leitura de imagem direta
            .accessibilityLabel(comida.acessibilidadeDescricaoImagem)
            
            // Informações do Prato
            VStack(alignment: .leading, spacing: 6) {
                // Nome da comida (Dynamic Type amigável, cresce naturalmente)
                Text(comida.nome)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Cozinheiro
                Text("por \(comida.cozinheiro)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                // Distância
                HStack(spacing: 4) {
                    Image(systemName: "mappin")
                        .font(.caption2)
                        .foregroundColor(.red)
                    Text(comida.distancia)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Distância: \(comida.distancia)")
                
                Spacer(minLength: 4)
                
                // Preço Formatado
                Text(comida.precoFormatado)
                    .font(.subheadline)
                    .fontWeight(.extrabold)
                    .foregroundColor(.primary)
                    .accessibilityLabel("Preço: \(comida.precoFormatado)") // A11y leitura correta de preços
            }
            .padding(12)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
