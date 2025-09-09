import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artist.dart';

class SpotifyService {
  static const String _clientId = 'c1a33f5d7ac24544b4b6e931dfc7cfef';
  static const String _clientSecret = 'ca9aa91d8a584f66bd29960b75a502f7';
  static const String _baseUrl = 'https://api.spotify.com/v1';

  String? _accessToken;
  DateTime? _tokenExpiry;

  // Singleton pattern
  static final SpotifyService _instance = SpotifyService._internal();
  factory SpotifyService() => _instance;
  SpotifyService._internal();

  Future<String?> _getAccessToken() async {
    // Verificar se o token ainda é válido
    if (_accessToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!)) {
      return _accessToken;
    }

    try {
      final response = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
        },
        body: {'grant_type': 'client_credentials'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _accessToken = data['access_token'];
        _tokenExpiry = DateTime.now().add(
          Duration(seconds: data['expires_in']),
        );
        return _accessToken;
      } else {
        print('Erro na autenticação Spotify: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao obter token de acesso: $e');
      return null;
    }
  }

  // Dados mockados para demonstração
  List<Map<String, dynamic>> _getMockArtists() {
    return [
      {
        'id': '1',
        'name': 'Matuê',
        'genres': ['Hip-Hop', 'Trap'],
        'popularity': 95,
        'followers': {'total': 15000000},
        'images': [
          {
            'url':
                'https://i.scdn.co/image/ab6761610000e5eb1234567890abcdef12345678',
          },
        ],
      },
      {
        'id': '2',
        'name': 'Anitta',
        'genres': ['Pop', 'Funk'],
        'popularity': 90,
        'followers': {'total': 25000000},
        'images': [
          {
            'url':
                'https://i.scdn.co/image/ab6761610000e5eb2345678901bcdef23456789',
          },
        ],
      },
      {
        'id': '3',
        'name': 'Emicida',
        'genres': ['Hip-Hop', 'Rap'],
        'popularity': 85,
        'followers': {'total': 8000000},
        'images': [
          {
            'url':
                'https://i.scdn.co/image/ab6761610000e5eb3456789012cdef34567890',
          },
        ],
      },
      {
        'id': '4',
        'name': 'Ludmilla',
        'genres': ['Funk', 'Pop'],
        'popularity': 88,
        'followers': {'total': 12000000},
        'images': [
          {
            'url':
                'https://i.scdn.co/image/ab6761610000e5eb4567890123def45678901',
          },
        ],
      },
      {
        'id': '5',
        'name': 'Djonga',
        'genres': ['Hip-Hop', 'Trap'],
        'popularity': 82,
        'followers': {'total': 5000000},
        'images': [
          {
            'url':
                'https://i.scdn.co/image/ab6761610000e5eb5678901234ef56789012',
          },
        ],
      },
    ];
  }

  Map<String, dynamic> _getMockTopTracks() {
    return {
      'tracks': [
        {'name': 'Banco'},
        {'name': 'Máquina do Tempo'},
        {'name': 'Gorilla'},
        {'name': 'Conexões de Máfia'},
        {'name': 'Vampiro'},
        {'name': 'Quer Voar'},
        {'name': 'Lembranças'},
        {'name': 'Diz Aí'},
      ],
    };
  }

  Future<List<Map<String, dynamic>>> searchArtists(String query) async {
    final token = await _getAccessToken();

    // Se não conseguir token, usar dados mockados
    if (token == null) {
      print('Usando dados mockados para demonstração');
      final mockArtists = _getMockArtists();
      return mockArtists
          .where(
            (artist) => artist['name'].toString().toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search?q=$query&type=artist&limit=20'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['artists']['items']);
      } else {
        print('Erro na busca de artistas: ${response.statusCode}');
        // Fallback para dados mockados
        final mockArtists = _getMockArtists();
        return mockArtists
            .where(
              (artist) => artist['name'].toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      }
    } catch (e) {
      print('Erro ao buscar artistas: $e');
      // Fallback para dados mockados
      final mockArtists = _getMockArtists();
      return mockArtists
          .where(
            (artist) => artist['name'].toString().toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    }
  }

  Future<Map<String, dynamic>?> getArtistDetails(String artistId) async {
    final token = await _getAccessToken();

    // Se não conseguir token, usar dados mockados
    if (token == null) {
      final mockArtists = _getMockArtists();
      return mockArtists.firstWhere(
        (artist) => artist['id'] == artistId,
        orElse: () => mockArtists.first,
      );
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/artists/$artistId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter detalhes do artista: ${response.statusCode}');
        // Fallback para dados mockados
        final mockArtists = _getMockArtists();
        return mockArtists.firstWhere(
          (artist) => artist['id'] == artistId,
          orElse: () => mockArtists.first,
        );
      }
    } catch (e) {
      print('Erro ao obter detalhes do artista: $e');
      // Fallback para dados mockados
      final mockArtists = _getMockArtists();
      return mockArtists.firstWhere(
        (artist) => artist['id'] == artistId,
        orElse: () => mockArtists.first,
      );
    }
  }

  Future<Map<String, dynamic>?> getArtistTopTracks(String artistId) async {
    final token = await _getAccessToken();

    // Se não conseguir token, usar dados mockados
    if (token == null) {
      return _getMockTopTracks();
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/artists/$artistId/top-tracks?market=BR'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro ao obter top tracks: ${response.statusCode}');
        // Fallback para dados mockados
        return _getMockTopTracks();
      }
    } catch (e) {
      print('Erro ao obter top tracks: $e');
      // Fallback para dados mockados
      return _getMockTopTracks();
    }
  }

  Future<Artist?> getArtistAsPokemon(String artistId, int number) async {
    try {
      // Buscar detalhes do artista
      final artistData = await getArtistDetails(artistId);
      if (artistData == null) return null;

      // Buscar top tracks do artista
      final tracksData = await getArtistTopTracks(artistId);
      if (tracksData == null) return null;

      // Criar objeto Artist no formato Pokedex
      return Artist.fromSpotifyData(artistData, tracksData, number);
    } catch (e) {
      print('Erro ao criar artista como Pokémon: $e');
      return null;
    }
  }

  Future<List<Artist>> searchArtistsAsPokemon(String query) async {
    try {
      final artistsData = await searchArtists(query);
      List<Artist> artists = [];

      for (int i = 0; i < artistsData.length && i < 10; i++) {
        final artistData = artistsData[i];
        final artistId = artistData['id'];

        if (artistId != null) {
          final artist = await getArtistAsPokemon(artistId, i + 1);
          if (artist != null) {
            artists.add(artist);
          }
        }
      }

      return artists;
    } catch (e) {
      print('Erro ao buscar artistas como Pokémon: $e');
      return [];
    }
  }
}
