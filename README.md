# 🎵 Pokedex Musical - Flutter App

Uma aplicação Flutter que transforma a experiência clássica da Pokedex em uma ferramenta para descobrir e catalogar artistas musicais usando a API do Spotify.

## 🎯 Conceito

A Pokedex Musical funciona exatamente como uma Pokedex tradicional, mas substitui Pokémon por artistas musicais:

- **Numeração**: Cada artista recebe um número sequencial (ex: "Matuê #333")
- **Tipos**: Gêneros musicais representam os tipos do Pokémon
- **Estatísticas**: Baseadas nas músicas mais populares do artista
- **Dados Criativos**: Anos de carreira, número de álbuns, etc. (equivalente a altura/peso)
- **Movimentos**: Top 8 músicas mais populares do artista

## 🚀 Funcionalidades

### ✅ Implementadas
- **Tela Inicial**: Apresentação da Pokedex Musical com estatísticas
- **Busca de Artistas**: Integração com Spotify API para buscar artistas
- **Sistema de Numeração**: Numeração automática sequencial
- **Tela de Detalhes**: Layout fiel à Pokedex original
- **Estatísticas Musicais**: Baseadas em dados reais do Spotify
- **Interface Responsiva**: Funciona em diferentes tamanhos de tela
- **Cache de Imagens**: Otimização de performance
- **Gerenciamento de Estado**: Provider para controle de dados

### 🎨 Design Fiel à Pokedex Original
- Cores vermelho/branco características
- Layout de cards idêntico ao original
- Tipos coloridos por gênero musical
- Barras de estatísticas no estilo clássico
- Navegação intuitiva

## 📱 Screenshots

### Tela Principal
- Cabeçalho com título e contador de artistas descobertos
- Barra de busca integrada
- Grid de artistas descobertos
- Estatísticas da Pokedex

### Tela de Detalhes
- Nome e número do artista
- Imagem centralizada
- Tipos (gêneros musicais)
- Estatísticas baseadas em músicas
- Top músicas do artista
- Álbuns principais

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework principal
- **Provider**: Gerenciamento de estado
- **HTTP**: Integração com Spotify API
- **Cached Network Image**: Cache de imagens
- **Material Design**: Componentes UI

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  cached_network_image: ^3.3.0
  provider: ^6.1.1
  flutter_svg: ^2.0.9
  lottie: ^2.7.0
  flutter_staggered_animations: ^1.1.1
```

## 🔧 Configuração

### 1. Clone o repositório
```bash
git clone [url-do-repositorio]
cd pokedex_menos_pokedex_que_tem
```

### 2. Instale as dependências
```bash
flutter pub get
```

### 3. Execute o aplicativo
```bash
flutter run
```

## 🎵 Como Usar

### Buscar Artistas
1. Digite o nome do artista na barra de busca
2. Aguarde os resultados aparecerem
3. Toque no artista desejado para ver os detalhes

### Explorar Pokedex
1. Artistas descobertos aparecem na tela principal
2. Toque em qualquer artista para ver detalhes completos
3. Acompanhe suas estatísticas de descoberta

### Mapeamento de Dados

| Pokedex Original | Pokedex Musical |
|------------------|-----------------|
| Nome + Número | Nome do Artista + #Número |
| Foto | Imagem do Artista |
| Tipos | Gêneros Musicais |
| Altura/Peso | Anos de Carreira / Número de Álbuns |
| HP | 1ª música mais popular |
| Attack | 2ª música mais popular |
| Defense | 3ª música mais popular |
| Sp. Attack | 4ª música mais popular |
| Sp. Defense | 5ª música mais popular |
| Speed | 6ª música mais popular |
| Movimentos | Top 8 músicas do artista |

## 🏗️ Arquitetura

```
lib/
├── main.dart                 # Ponto de entrada
├── models/
│   └── artist.dart          # Modelo de dados do artista
├── services/
│   ├── spotify_service.dart # Integração com Spotify API
│   └── pokedex_provider.dart # Gerenciamento de estado
├── screens/
│   ├── home_screen.dart     # Tela principal
│   └── artist_detail_screen.dart # Tela de detalhes
├── widgets/
│   ├── artist_card.dart     # Card do artista
│   ├── type_badge.dart      # Badge de tipo/gênero
│   └── stats_bar.dart       # Barra de estatísticas
└── utils/
    └── constants.dart       # Constantes e cores
```

## 🎨 Personalização

### Cores dos Gêneros Musicais
- **Hip-Hop/Trap**: Marrom escuro
- **Pop**: Rosa
- **Rock**: Vermelho escuro
- **Electronic/EDM**: Roxo
- **R&B/Soul**: Azul real
- **Country**: Verde escuro
- **Jazz**: Dourado
- **Classical**: Cinza
- **Reggae**: Verde lima
- **Metal**: Cinza escuro

### Estatísticas
As estatísticas são calculadas dinamicamente baseadas em:
- Comprimento do nome da música
- Posição na lista de popularidade
- Dados de popularidade do Spotify

## 🔮 Próximas Funcionalidades

- [ ] Persistência local de dados
- [ ] Filtros por gênero musical
- [ ] Comparação entre artistas
- [ ] Modo escuro
- [ ] Animações de transição
- [ ] Compartilhamento de descobertas
- [ ] Lista de favoritos

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 🙏 Agradecimentos

- **Nintendo/Game Freak**: Inspiração na Pokedex original
- **Spotify**: API para dados musicais
- **Flutter Team**: Framework incrível
- **Comunidade Flutter**: Suporte e recursos

---

**Desenvolvido com ❤️ e 🎵 para os amantes de música e Pokémon!**
