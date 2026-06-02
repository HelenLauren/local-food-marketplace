# Local Food Marketplace - Mercado Caseiro Local

Um aplicativo iOS nativo desenvolvido em **SwiftUI** que simula uma vitrine virtual de comidas caseiras e artesanais focada em conexões locais (estilo classificados de bairro). O foco central deste projeto é a implementação rigorosa das diretrizes de **Acessibilidade (A11y)** e boas práticas de design moderno.

---

## 📱 Funcionalidades Principais

* **Vitrine Dinâmica (`LazyVGrid`):** Grade adaptativa responsiva que se ajusta automaticamente a diferentes tamanhos de tela (iPhone e iPad) com limite mínimo de 160 pontos por card.
* **Barra de Pesquisa Nativa (`.searchable`):** Permite filtrar pratos por nome, categoria ou cozinheiro de forma fluida.
* **Filtros por Categoria:** Pílulas de filtro deslizantes no topo para acesso rápido às principais seções (Vegano, Sem Glúten, Massas, Festas, etc.).
* **Filtro de Favoritos:** Visualize apenas os itens favoritados alternando o botão na barra de navegação.
* **Sincronização de Estado:** O status de favoritado é compartilhado de forma reativa, atualizando instantaneamente no grid quando alterado na tela de detalhes (e vice-versa).
* **Fluxo de Simulação de Compra:** Um botão proeminente "Fazer Pedido" na tela de detalhes simula o envio do pedido direto para o cozinheiro local com um alerta interativo.

---

## ♿ Implementação de Acessibilidade (A11y)

Este aplicativo foi construído seguindo as diretrizes fundamentais de acessibilidade da Apple para ser totalmente utilizável por pessoas com deficiências visuais ou motoras:

1. **Rótulos Descritivos no VoiceOver (`.accessibilityLabel`):**
   * As imagens mockadas utilizam descrições textuais ricas em vez de apenas ler o nome do arquivo/ícone. (Ex: *"Foto de um Bolo da vovó de fubá tradicional fofinho, com casca dourada e erva-doce recém-assado."*).
2. **Leitura Correta de Preços:**
   * Garantimos que o leitor de tela leia o valor monetário de forma natural (Ex: *"Preço: vinte e cinco reais"* em vez de *"vinte e cinco vírgula zero zero"*), usando a propriedade `.accessibilityLabel("Preço: \(precoFormatado)")`.
3. **Alvos de Toque Apropriados (Touch Targets):**
   * Todos os botões interativos (como o botão de favoritar no grid e na tela de detalhes) possuem uma área clicável de pelo menos **48x48 pontos** (acima dos 44x44 mínimos exigidos pela Apple).
4. **Suporte a Dynamic Type:**
   * O layout dos textos não utiliza alturas fixas (`.frame(height: ...)`). Se o usuário aumentar o tamanho da fonte do sistema nas configurações do iOS, o texto crescerá e quebrará linhas naturalmente sem cortar ou sobrepor outros elementos.
5. **Ordem de Leitura Customizada (`.accessibilitySortPriority`):**
   * Na tela de detalhes, usamos prioridades de classificação para fazer o VoiceOver ler primeiro o Nome do Prato (`priority = 2`) antes da Capa Ilustrativa (`priority = 1`), proporcionando um fluxo de informação muito mais contextual e intuitivo.

---

## 🛠️ Como Executar no macOS (Xcode)

Você tem duas opções simples para rodar o projeto no seu Mac:

### Opção 1: Abrir Diretamente (Recomendado)
1. Transfira a pasta do projeto para o seu macOS.
2. Dê dois cliques sobre o arquivo **`LocalFoodMarketplace.xcodeproj`** para abrir o projeto diretamente no Xcode.
3. Use o atalho **cmd + R** (ou clique no botão de Play) para buildar e rodar o projeto no Simulador iOS.

### Opção 2: Regenerar via XcodeGen
Caso queira modificar a estrutura e recriar o arquivo de projeto a partir do `project.yml`:
1. Instale o XcodeGen (se não possuir):
   ```bash
   brew install xcodegen
   ```
2. Na raiz do projeto, execute o comando:
   ```bash
   xcodegen generate
   ```
3. Abra o arquivo gerado `LocalFoodMarketplace.xcodeproj` no Xcode.

---

## 📂 Estrutura de Arquivos

* `LocalFoodMarketplace.xcodeproj/`: Arquivo de projeto empacotado para abertura imediata no Xcode.
* `project.yml`: Arquivo de configuração de geração do XcodeGen.
* `LocalFoodMarketplace/`: Código fonte e recursos do app.
  * `LocalFoodMarketplaceApp.swift`: Ponto de entrada do aplicativo.
  * `Info.plist`: Configurações de manifesto.
  * `Assets.xcassets/`: Catálogo contendo a paleta de cores e configurações do ícone do aplicativo.
  * `Models/`
    * `ComidaArtesanal.swift`: Modelo de dados com mock dos 8 pratos e metadados de acessibilidade.
  * `Views/`
    * `ContentView.swift`: Vitrine principal em grade com filtros e busca nativa.
    * `DetalhesProdutoView.swift`: Tela de detalhes estruturada com foco em acessibilidade e ação de pedido.
