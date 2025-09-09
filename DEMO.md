# 🎵 Demonstração da Pokedex Musical

## 🚀 Como Executar

1. **Instalar dependências:**
   ```bash
   flutter pub get
   ```

2. **Executar o aplicativo:**
   ```bash
   flutter run
   ```

3. **Ou compilar APK:**
   ```bash
   flutter build apk --debug
   ```

## 🎯 Funcionalidades Demonstradas

### 1. **Tela Inicial**
- Cabeçalho com título "POKÉDEX MUSICAL"
- Contador de artistas descobertos
- Barra de busca integrada
- Estatísticas da Pokedex (quando há artistas)

### 2. **Busca de Artistas**
- Digite o nome de qualquer artista (ex: "Matuê", "Anitta", "Drake")
- Resultados aparecem em cards no estilo Pokedex
- Cada card mostra:
  - Número sequencial (#001, #002, etc.)
  - Imagem do artista
  - Nome
  - Gêneros musicais (tipos)
  - Estatísticas resumidas

### 3. **Tela de Detalhes**
- Layout fiel à Pokedex original
- Nome e número do artista
- Imagem centralizada
- Tipos (gêneros musicais) coloridos
- Dados criativos (anos de carreira, álbuns, etc.)
- Estatísticas baseadas nas músicas
- Top 8 músicas do artista
- Álbuns principais

## 🎵 Exemplos de Busca

### Artistas Brasileiros:
- **Matuê** → Hip-Hop/Trap
- **Anitta** → Pop/Funk
- **Luísa Sonza** → Pop
- **Projota** → Hip-Hop
- **Emicida** → Hip-Hop
- **Criolo** → Hip-Hop
- **Racionais** → Hip-Hop
- **O Rappa** → Rock/Reggae
- **Legião Urbana** → Rock
- **Tim Maia** → Soul/Funk

### Artistas Internacionais:
- **Drake** → Hip-Hop/R&B
- **Taylor Swift** → Pop/Country
- **The Weeknd** → R&B/Pop
- **Ed Sheeran** → Pop/Folk
- **Beyoncé** → R&B/Pop
- **Coldplay** → Rock/Alternative
- **Dua Lipa** → Pop/Dance
- **Post Malone** → Hip-Hop/Pop

## 📊 Mapeamento de Dados

| Pokedex Original | Pokedex Musical | Exemplo |
|------------------|-----------------|---------|
| Nome + Número | Nome do Artista + #Número | "Matuê #001" |
| Foto | Imagem do Artista | Foto do Spotify |
| Tipos | Gêneros Musicais | HIP-HOP, TRAP |
| Altura/Peso | Anos de Carreira / Álbuns | "8 anos", "3 álbuns" |
| HP | 1ª música mais popular | Baseado em "Vampiro" |
| Attack | 2ª música mais popular | Baseado em "M4" |
| Defense | 3ª música mais popular | Baseado em "Coração de Gelo" |
| Sp. Attack | 4ª música mais popular | Baseado em "Diz Quem Ta Na Pista" |
| Sp. Defense | 5ª música mais popular | Baseado em "Kenny G" |
| Speed | 6ª música mais popular | Baseado em "Conexões de Máfia" |
| Movimentos | Top 8 músicas do artista | Lista completa |

## 🎨 Cores dos Gêneros

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

## 🔧 Tecnologias Utilizadas

- **Flutter**: Framework principal
- **Provider**: Gerenciamento de estado
- **HTTP**: Integração com Spotify API
- **Cached Network Image**: Cache de imagens
- **Material Design**: Componentes UI

## 📱 Screenshots Esperados

### Tela Principal
```
┌─────────────────────────────────┐
│        POKÉDEX MUSICAL           │
│    Artistas Descobertos: 0      │
├─────────────────────────────────┤
│  [🔍 Buscar artista... 🎵]      │
├─────────────────────────────────┤
│                                 │
│    [🎵] Sua Pokedex Musical     │
│         está vazia!             │
│                                 │
│  Use a barra de busca para      │
│  descobrir seus primeiros       │
│  artistas!                      │
│                                 │
└─────────────────────────────────┘
```

### Card do Artista
```
┌─────────────────────────────────┐
│ #001                    [✓]     │
├─────────────────────────────────┤
│                                 │
│         [🖼️ Imagem]             │
│                                 │
│         Matuê                   │
│                                 │
│    [HIP-HOP] [TRAP]             │
│                                 │
│  HP: 145  ATK: 132  DEF: 128    │
└─────────────────────────────────┘
```

### Tela de Detalhes
```
┌─────────────────────────────────┐
│        Matuê #001                │
│      Artista Musical             │
├─────────────────────────────────┤
│                                 │
│         [🖼️ Imagem Grande]      │
│                                 │
│         Tipos: [HIP-HOP] [TRAP] │
│                                 │
│  Anos: 8    Álbuns: 3           │
│  Pop: 85    Seguidores: 12.5M    │
│                                 │
│  Base Stats:                    │
│  HP: ████████████████ 145       │
│  ATK: ███████████████ 132       │
│  DEF: ███████████████ 128       │
│                                 │
│  Top Músicas:                   │
│  1. Vampiro                     │
│  2. M4                          │
│  3. Coração de Gelo              │
│                                 │
└─────────────────────────────────┘
```

## 🎉 Resultado Final

A Pokedex Musical é uma aplicação completa que:

✅ **Replica fielmente** a experiência da Pokedex original
✅ **Integra com Spotify API** para dados reais
✅ **Mapeia criativamente** dados musicais para formato Pokedex
✅ **Interface responsiva** e intuitiva
✅ **Sistema de numeração** automático
✅ **Estatísticas dinâmicas** baseadas em músicas
✅ **Design consistente** com cores e elementos da Pokedex

## 🚀 Próximos Passos

1. Teste a busca com diferentes artistas
2. Explore as estatísticas e detalhes
3. Compare artistas de diferentes gêneros
4. Observe como as cores dos tipos variam
5. Verifique a numeração sequencial

---

**🎵 Divirta-se explorando o mundo da música através da lente da Pokedex! 🎵**
