import SwiftUI

struct DetalhesProdutoView: View {
    @Binding var comida: ComidaArtesanal
    @State private var mostrarAlertaPedido = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header com imagem do prato
                // A11y: Prioridade 1 (será lido depois do nome do prato)
                ZStack {
                    LinearGradient(
                        colors: comida.gradienteCores,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 260)
                    .cornerRadius(24)
                    
                    Image(comida.imagemNome)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 260)
                        .cornerRadius(24)
                        .clipped()
                }
                .shadow(color: comida.gradienteCores.first?.opacity(0.3) ?? .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(comida.acessibilidadeDescricaoImagem)
                .accessibilitySortPriority(1)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Cabeçalho com Nome e Botão de Favoritar
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            // Categoria
                            Text(comida.categoria.uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(comida.gradienteCores.first ?? Color.accentColor)
                                )
                            
                            // Nome do Prato - A11y: Prioridade 2 (será lido PRIMEIRO pelo VoiceOver)
                            Text(comida.nome)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .accessibilitySortPriority(2)
                        }
                        
                        Spacer()
                        
                        // Botão de Favoritar com área de toque mínima de 44x44
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                comida.isFavorito.toggle()
                            }
                        }) {
                            Image(systemName: comida.isFavorito ? "heart.fill" : "heart")
                                .font(.system(size: 26))
                                .foregroundColor(comida.isFavorito ? .red : .gray)
                                .frame(width: 48, height: 48)
                                .background(
                                    Circle()
                                        .fill(Color(.systemBackground))
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                                )
                        }
                        .frame(minWidth: 44, minHeight: 44) // A11y Touch Target
                        .accessibilityLabel(comida.isFavorito ? "Remover \(comida.nome) dos favoritos" : "Favoritar \(comida.nome)")
                    }
                    
                    Divider()
                    
                    // Detalhes do Cozinheiro e Distância
                    HStack(spacing: 20) {
                        // Cozinheiro
                        HStack(spacing: 8) {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.secondary)
                            VStack(alignment: .leading) {
                                Text("Cozinheiro(a)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(comida.cozinheiro)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Preparado por: \(comida.cozinheiro)")
                        
                        // Distância
                        HStack(spacing: 8) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.red)
                            VStack(alignment: .leading) {
                                Text("Distância")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(comida.distancia)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Distância: \(comida.distancia)")
                    }
                    
                    Divider()
                    
                    // Descrição
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Descrição do Prato")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(comida.descricao)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Seção de Preço e Compra
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Valor")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(comida.precoFormatado)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .accessibilityLabel("Preço: \(comida.precoFormatado)")
                        }
                        
                        Spacer()
                        
                        // Botão "Fazer Pedido"
                        Button(action: {
                            mostrarAlertaPedido = true
                        }) {
                            HStack {
                                Text("Fazer Pedido")
                                    .fontWeight(.bold)
                                Image(systemName: "arrow.right.circle.fill")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: comida.gradienteCores,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .cornerRadius(16)
                                .shadow(color: comida.gradienteCores.first?.opacity(0.3) ?? .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                        }
                        .frame(minWidth: 44, minHeight: 44) // A11y Touch Target
                        .accessibilityLabel("Fazer pedido deste prato com o cozinheiro \(comida.cozinheiro)")
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $mostrarAlertaPedido) {
            Alert(
                title: Text("Pedido Enviado! 🎉"),
                message: Text("O cozinheiro \(comida.cozinheiro) já recebeu a sua notificação e entrará em contato em breve para combinar a entrega."),
                dismissButton: .default(Text("Entendido"))
            )
        }
    }
}

struct DetalhesProdutoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetalhesProdutoView(comida: .constant(ComidaArtesanal.mockList[0]))
        }
    }
}
