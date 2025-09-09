import 'package:flutter/foundation.dart';
import '../models/artist.dart';
import 'spotify_service.dart';

class PokedexProvider extends ChangeNotifier {
  final SpotifyService _spotifyService = SpotifyService();
  
  List<Artist> _discoveredArtists = [];
  List<Artist> _searchResults = [];
  Artist? _selectedArtist;
  bool _isLoading = false;
  String _searchQuery = '';
  int _nextArtistNumber = 1;

  // Getters
  List<Artist> get discoveredArtists => _discoveredArtists;
  List<Artist> get searchResults => _searchResults;
  Artist? get selectedArtist => _selectedArtist;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  int get totalDiscovered => _discoveredArtists.length;

  // Buscar artistas
  Future<void> searchArtists(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      _searchQuery = '';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _searchQuery = query;
    notifyListeners();

    try {
      final results = await _spotifyService.searchArtistsAsPokemon(query);
      _searchResults = results;
    } catch (e) {
      print('Erro na busca: $e');
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adicionar artista à Pokedex
  void addArtistToPokedex(Artist artist) {
    // Verificar se o artista já foi descoberto
    if (!_discoveredArtists.any((a) => a.id == artist.id)) {
      // Atribuir número sequencial
      final numberedArtist = Artist(
        id: artist.id,
        name: artist.name,
        number: _nextArtistNumber,
        imageUrl: artist.imageUrl,
        genres: artist.genres,
        topTracks: artist.topTracks,
        stats: artist.stats,
        creativeData: artist.creativeData,
        albums: artist.albums,
      );
      
      _discoveredArtists.add(numberedArtist);
      _nextArtistNumber++;
      
      // Ordenar por número
      _discoveredArtists.sort((a, b) => a.number.compareTo(b.number));
      
      notifyListeners();
    }
  }

  // Selecionar artista
  void selectArtist(Artist artist) {
    _selectedArtist = artist;
    notifyListeners();
  }

  // Limpar seleção
  void clearSelection() {
    _selectedArtist = null;
    notifyListeners();
  }

  // Buscar artista por número
  Artist? getArtistByNumber(int number) {
    try {
      return _discoveredArtists.firstWhere((artist) => artist.number == number);
    } catch (e) {
      return null;
    }
  }

  // Buscar artista por nome
  Artist? getArtistByName(String name) {
    try {
      return _discoveredArtists.firstWhere(
        (artist) => artist.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Filtrar artistas por gênero
  List<Artist> getArtistsByGenre(String genre) {
    return _discoveredArtists.where(
      (artist) => artist.genres.any((g) => g.toLowerCase().contains(genre.toLowerCase())),
    ).toList();
  }

  // Obter estatísticas da Pokedex
  Map<String, dynamic> getPokedexStats() {
    if (_discoveredArtists.isEmpty) {
      return {
        'total': 0,
        'genres': {},
        'avgPopularity': 0,
        'completion': 0.0,
      };
    }

    // Contar gêneros
    Map<String, int> genres = {};
    for (var artist in _discoveredArtists) {
      for (var genre in artist.genres) {
        genres[genre] = (genres[genre] ?? 0) + 1;
      }
    }

    // Calcular popularidade média
    double avgPopularity = _discoveredArtists
        .map((a) => a.creativeData['popularity_score'] as int)
        .reduce((a, b) => a + b) / _discoveredArtists.length;

    return {
      'total': _discoveredArtists.length,
      'genres': genres,
      'avgPopularity': avgPopularity.round(),
      'completion': (_discoveredArtists.length / 1000) * 100, // Assumindo 1000 como total
    };
  }

  // Limpar resultados de busca
  void clearSearchResults() {
    _searchResults = [];
    _searchQuery = '';
    notifyListeners();
  }

  // Verificar se artista foi descoberto
  bool isArtistDiscovered(String artistId) {
    return _discoveredArtists.any((artist) => artist.id == artistId);
  }

  // Obter próximo número disponível
  int getNextNumber() {
    return _nextArtistNumber;
  }

  // Resetar Pokedex (para testes)
  void resetPokedex() {
    _discoveredArtists = [];
    _searchResults = [];
    _selectedArtist = null;
    _nextArtistNumber = 1;
    notifyListeners();
  }
}
