// Exemplos de uso da API Spotify no MelodyDex
// Este arquivo demonstra como a integração funciona

import '../services/spotify_service.dart';
import '../models/artist.dart';

class ApiExamples {
  static final SpotifyService _spotifyService = SpotifyService();

  // Exemplo 1: Buscar artistas brasileiros
  static Future<List<Artist>> searchBrazilianArtists() async {
    List<Artist> artists = [];

    // Buscar artistas populares brasileiros
    List<String> searchQueries = [
      'Matuê',
      'Anitta',
      'Luísa Sonza',
      'Projota',
      'Emicida',
      'Criolo',
      'Racionais',
      'O Rappa',
      'Legião Urbana',
      'Tim Maia',
    ];

    for (int i = 0; i < searchQueries.length; i++) {
      final results = await _spotifyService.searchArtistsAsPokemon(
        searchQueries[i],
      );
      if (results.isNotEmpty) {
        // Atribuir número sequencial
        final artist = results.first;
        final numberedArtist = Artist(
          id: artist.id,
          name: artist.name,
          number: i + 1,
          imageUrl: artist.imageUrl,
          genres: artist.genres,
          topTracks: artist.topTracks,
          stats: artist.stats,
          creativeData: artist.creativeData,
          albums: artist.albums,
        );
        artists.add(numberedArtist);
      }
    }

    return artists;
  }

  // Exemplo 2: Buscar por gênero específico
  static Future<List<Artist>> searchByGenre(String genre) async {
    return await _spotifyService.searchArtistsAsPokemon(genre);
  }

  // Exemplo 3: Obter detalhes de um artista específico
  static Future<Artist?> getArtistDetails(String artistId) async {
    return await _spotifyService.getArtistAsPokemon(artistId, 1);
  }

  // Exemplo 4: Demonstrar mapeamento de dados
  static void demonstrateDataMapping() {
    print('''
=== MAPEAMENTO MELODYDEX ===

POKEDEX ORIGINAL          | MELODYDEX
-------------------------|-------------------------
Nome + Número             | Nome do Artista + #Número
Foto                      | Imagem do Artista
Tipos                     | Gêneros Musicais
Altura/Peso               | Anos de Carreira / Álbuns
HP                        | 1ª música mais popular
Attack                    | 2ª música mais popular
Defense                   | 3ª música mais popular
Sp. Attack               | 4ª música mais popular
Sp. Defense              | 5ª música mais popular
Speed                     | 6ª música mais popular
Movimentos               | Top 8 músicas do artista

=== EXEMPLO PRÁTICO ===

Artista: Matuê #001
Tipos: HIP-HOP, TRAP
HP: 145 (baseado em "Vampiro")
Attack: 132 (baseado em "M4")
Defense: 128 (baseado em "Coração de Gelo")
Sp. Attack: 125 (baseado em "Diz Quem Ta Na Pista")
Sp. Defense: 118 (baseado em "Kenny G")
Speed: 112 (baseado em "Conexões de Máfia")

Movimentos:
1. Vampiro
2. M4
3. Coração de Gelo
4. Diz Quem Ta Na Pista
5. Kenny G
6. Conexões de Máfia
7. Máquina do Tempo
8. Anos Luz

Dados Criativos:
- Anos de Carreira: 8 anos
- Álbuns: 3
- Popularidade: 85
- Seguidores: 12.5M
    ''');
  }

  // Exemplo 5: Calcular estatísticas da Pokedex
  static Map<String, dynamic> calculatePokedexStats(List<Artist> artists) {
    if (artists.isEmpty) {
      return {'total': 0, 'genres': {}, 'avgPopularity': 0, 'completion': 0.0};
    }

    // Contar gêneros
    Map<String, int> genres = {};
    for (var artist in artists) {
      for (var genre in artist.genres) {
        genres[genre] = (genres[genre] ?? 0) + 1;
      }
    }

    // Calcular popularidade média
    double avgPopularity =
        artists
            .map((a) => a.creativeData['popularity_score'] as int)
            .reduce((a, b) => a + b) /
        artists.length;

    return {
      'total': artists.length,
      'genres': genres,
      'avgPopularity': avgPopularity.round(),
      'completion': (artists.length / 1000) * 100, // Assumindo 1000 como total
    };
  }

  // Exemplo 6: Filtrar artistas por gênero
  static List<Artist> filterArtistsByGenre(List<Artist> artists, String genre) {
    return artists
        .where(
          (artist) => artist.genres.any(
            (g) => g.toLowerCase().contains(genre.toLowerCase()),
          ),
        )
        .toList();
  }

  // Exemplo 7: Ordenar artistas por popularidade
  static List<Artist> sortArtistsByPopularity(List<Artist> artists) {
    List<Artist> sorted = List.from(artists);
    sorted.sort(
      (a, b) => (b.creativeData['popularity_score'] as int).compareTo(
        a.creativeData['popularity_score'] as int,
      ),
    );
    return sorted;
  }

  // Exemplo 8: Buscar artistas com estatísticas altas
  static List<Artist> findHighStatsArtists(
    List<Artist> artists,
    int minStatValue,
  ) {
    return artists.where((artist) {
      return artist.stats.values.any((stat) => stat >= minStatValue);
    }).toList();
  }

  // Exemplo 9: Gerar relatório da Pokedex
  static void generatePokedexReport(List<Artist> artists) {
    final stats = calculatePokedexStats(artists);

    print('''
=== RELATÓRIO DA POKEDEX MUSICAL ===

📊 ESTATÍSTICAS GERAIS:
- Total de Artistas: ${stats['total']}
- Popularidade Média: ${stats['avgPopularity']}
- Conclusão: ${stats['completion'].toStringAsFixed(1)}%

🎵 GÊNEROS DESCOBERTOS:
${(stats['genres'] as Map<String, int>).entries.map((e) => '- ${e.key}: ${e.value} artistas').join('\n')}

🏆 TOP 5 ARTISTAS MAIS POPULARES:
${sortArtistsByPopularity(artists).take(5).map((a) => '${a.number}. ${a.name} (${a.creativeData['popularity_score']})').join('\n')}

⚡ ARTISTAS COM ESTATÍSTICAS ALTAS (≥150):
${findHighStatsArtists(artists, 150).map((a) => '${a.number}. ${a.name}').join('\n')}
    ''');
  }
}

// Exemplo de uso:
/*
void main() async {
  // Buscar artistas brasileiros
  final artists = await ApiExamples.searchBrazilianArtists();
  
  // Demonstrar mapeamento
  ApiExamples.demonstrateDataMapping();
  
  // Gerar relatório
  ApiExamples.generatePokedexReport(artists);
  
  // Buscar por gênero
  final hipHopArtists = await ApiExamples.searchByGenre('hip hop');
  
  // Filtrar artistas
  final trapArtists = ApiExamples.filterArtistsByGenre(artists, 'trap');
}
*/
