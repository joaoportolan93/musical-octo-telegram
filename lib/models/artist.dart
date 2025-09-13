class Artist {
  final String id;
  final String name;
  final int number;
  final String imageUrl;
  final List<String> genres;
  final List<String> topTracks;
  final Map<String, int> stats;
  final Map<String, dynamic> creativeData;
  final List<String> albums;
  final String country; // Novo campo adicionado

  Artist({
    required this.id,
    required this.name,
    required this.number,
    required this.imageUrl,
    required this.genres,
    required this.topTracks,
    required this.stats,
    required this.creativeData,
    required this.albums,
    required this.country, // Inicialização do novo campo
  });

  factory Artist.fromSpotifyData(Map<String, dynamic> artistData, Map<String, dynamic> tracksData, int number, String country) {
    // Extrair gêneros principais (limitado a 3 para simular tipos de Pokémon)
    List<String> genres = (artistData['genres'] as List<dynamic>? ?? [])
        .take(3)
        .map((genre) => genre.toString().toUpperCase())
        .toList();

    // Extrair top tracks
    List<String> topTracks = [];
    if (tracksData['tracks'] != null) {
      topTracks = (tracksData['tracks'] as List<dynamic>)
          .take(8)
          .map((track) => track['name'] as String)
          .toList();
    }

    // Criar estatísticas baseadas nas músicas mais populares
    Map<String, int> stats = {};
    if (topTracks.isNotEmpty) {
      stats = {
        'HP': _calculateStat(topTracks, 0),
        'Attack': _calculateStat(topTracks, 1),
        'Defense': _calculateStat(topTracks, 2),
        'Sp. Attack': _calculateStat(topTracks, 3),
        'Sp. Defense': _calculateStat(topTracks, 4),
        'Speed': _calculateStat(topTracks, 5),
      };
    }

    // Dados criativos (altura/peso equivalentes)
    Map<String, dynamic> creativeData = {
      'career_years': _calculateCareerYears(artistData),
      'albums_count': _calculateAlbumsCount(artistData),
      'popularity_score': artistData['popularity'] ?? 0,
      'monthly_listeners': _calculateMonthlyListeners(artistData),
      'followers': artistData['followers']?['total'] ?? 0,
    };

    return Artist(
      id: artistData['id'] ?? '',
      name: artistData['name'] ?? '',
      number: number,
      imageUrl: artistData['images']?.isNotEmpty == true 
          ? artistData['images'][0]['url'] 
          : '',
      genres: genres,
      topTracks: topTracks,
      stats: stats,
      creativeData: creativeData,
      albums: _extractAlbums(tracksData),
      country: country,
    );
  }

  static int _calculateStat(List<String> tracks, int index) {
    if (index >= tracks.length) return 50;
    
    // Base estatística baseada no comprimento do nome da música e posição
    String trackName = tracks[index];
    int baseStat = 50 + (trackName.length * 2) + (index * 10);
    
    // Limitar entre 30 e 200 para manter realismo
    return baseStat.clamp(30, 200);
  }

  static int _calculateCareerYears(Map<String, dynamic> artistData) {
    // Simular anos de carreira baseado na popularidade
    int popularity = artistData['popularity'] ?? 50;
    return (popularity / 10).round() + 1;
  }

  static int _calculateAlbumsCount(Map<String, dynamic> artistData) {
    // Simular número de álbuns baseado na popularidade
    int popularity = artistData['popularity'] ?? 50;
    return (popularity / 15).round() + 1;
  }

  static int _calculateMonthlyListeners(Map<String, dynamic> artistData) {
    // A API pública do Spotify não fornece ouvintes mensais diretamente
    // Vamos usar uma estimativa mais realista baseada em padrões reais
    
    int popularity = artistData['popularity'] ?? 50;
    int followers = artistData['followers']?['total'] ?? 0;
    
    // Log para debug
    print('DEBUG: Calculando ouvintes mensais para ${artistData['name']}');
    print('DEBUG: Popularidade: $popularity, Seguidores: $followers');
    
    // Estimativa baseada em padrões reais do Spotify
    double estimatedListeners;
    
    if (followers > 0) {
      // Proporções mais realistas baseadas em dados reais
      if (followers >= 50000000) { // 50M+ seguidores (Drake, Taylor Swift)
        estimatedListeners = followers * 0.4; // ~40% dos seguidores
      } else if (followers >= 20000000) { // 20M+ seguidores (Billie Eilish, Ed Sheeran)
        estimatedListeners = followers * 0.5; // ~50% dos seguidores
      } else if (followers >= 10000000) { // 10M+ seguidores (Matuê, Anitta)
        estimatedListeners = followers * 0.6; // ~60% dos seguidores
      } else if (followers >= 5000000) { // 5M+ seguidores
        estimatedListeners = followers * 0.7; // ~70% dos seguidores
      } else if (followers >= 1000000) { // 1M+ seguidores
        estimatedListeners = followers * 0.8; // ~80% dos seguidores
      } else if (followers >= 100000) { // 100K+ seguidores
        estimatedListeners = followers * 1.0; // ~100% dos seguidores
      } else {
        estimatedListeners = followers * 1.5; // ~150% dos seguidores
      }
    } else {
      // Fallback baseado na popularidade com ranges mais realistas
      if (popularity >= 90) {
        estimatedListeners = 15000000; // ~15M para artistas muito populares
      } else if (popularity >= 80) {
        estimatedListeners = 8000000; // ~8M para artistas populares
      } else if (popularity >= 70) {
        estimatedListeners = 4000000; // ~4M para artistas moderadamente populares
      } else if (popularity >= 60) {
        estimatedListeners = 2000000; // ~2M para artistas em crescimento
      } else {
        estimatedListeners = popularity * 100000; // 100K por ponto de popularidade
      }
    }
    
    // Ajuste final baseado na popularidade (mais sutil)
    double popularityAdjustment = 1.0 + ((popularity - 50) / 100.0) * 0.3;
    estimatedListeners *= popularityAdjustment;
    
    final result = estimatedListeners.round().clamp(100000, 100000000);
    print('DEBUG: Ouvintes mensais estimados: $result');
    
    return result;
  }

  static List<String> _extractAlbums(Map<String, dynamic> tracksData) {
    List<String> albums = [];
    if (tracksData['tracks'] != null) {
      for (var track in tracksData['tracks']) {
        if (track['album'] != null && track['album']['name'] != null) {
          String albumName = track['album']['name'];
          if (!albums.contains(albumName)) {
            albums.add(albumName);
          }
        }
      }
    }
    return albums.take(5).toList(); // Limitar a 5 álbuns
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'imageUrl': imageUrl,
      'genres': genres,
      'topTracks': topTracks,
      'stats': stats,
      'creativeData': creativeData,
      'albums': albums,
      'country': country, // Serialização do novo campo
    };
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      imageUrl: json['imageUrl'],
      genres: List<String>.from(json['genres']),
      topTracks: List<String>.from(json['topTracks']),
      stats: Map<String, int>.from(json['stats']),
      creativeData: Map<String, dynamic>.from(json['creativeData']),
      albums: List<String>.from(json['albums']),
      country: json['country'], // Desserialização do novo campo
    );
  }
}
