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
  });

  factory Artist.fromSpotifyData(Map<String, dynamic> artistData, Map<String, dynamic> tracksData, int number) {
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
    );
  }
}
