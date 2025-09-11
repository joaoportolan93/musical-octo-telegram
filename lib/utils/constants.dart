import 'package:flutter/material.dart';

class PokedexColors {
  // Nova paleta de cores baseada no conceito de design
  static const Color deepBlue = Color(0xFF2C3E50); // Azul Profundo
  static const Color vibrantYellow = Color(0xFFF39C12); // Amarelo Vibrante
  static const Color forestGreen = Color(0xFF27AE60); // Verde Floresta
  static const Color fireRed = Color(0xFFE74C3C); // Vermelho Fogo
  static const Color lightGray = Color(0xFFECF0F1); // Cinza Claro
  static const Color pureWhite = Color(0xFFFFFFFF); // Branco Puro

  // Cores de fundo modernas
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = pureWhite;
  static const Color sidebarBackground = lightGray;

  // Cores de texto modernas
  static const Color textPrimary = deepBlue;
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);

  // Cores de tipos/gêneros
  static const Color hipHop = Color(0xFF8B4513);
  static const Color pop = Color(0xFFFF69B4);
  static const Color rock = Color(0xFF8B0000);
  static const Color electronic = Color(0xFF9370DB);
  static const Color rnb = Color(0xFF4169E1);
  static const Color country = Color(0xFF8FBC8F);
  static const Color jazz = Color(0xFFDAA520);
  static const Color classical = Color(0xFF708090);
  static const Color reggae = Color(0xFF32CD32);
  static const Color metal = Color(0xFF2F4F4F);
  static const Color folk = Color(0xFFDEB887);
  static const Color blues = Color(0xFF191970);
  static const Color punk = Color(0xFFFF4500);
  static const Color indie = Color(0xFF20B2AA);
  static const Color alternative = Color(0xFF6A5ACD);
  static const Color funk = Color(0xFFFFD700);
  static const Color disco = Color(0xFFFF1493);
  static const Color gospel = Color(0xFF8A2BE2);
  static const Color trap = Color(0x0015a3c7); 

  // Cores de estatísticas
  static const Color hp = Color(0xFF4CAF50);
  static const Color attack = Color(0xFFF44336);
  static const Color defense = Color(0xFF2196F3);
  static const Color spAttack = Color(0xFF9C27B0);
  static const Color spDefense = Color(0xFF00BCD4);
  static const Color speed = Color(0xFFFF9800);
}

class PokedexTextStyles {
  // Tipografia moderna baseada no conceito de design
  static const TextStyle displayTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
    color: PokedexColors.deepBlue,
  );

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
    color: PokedexColors.deepBlue,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: PokedexColors.deepBlue,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: PokedexColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: PokedexColors.textSecondary,
  );

  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: PokedexColors.textLight,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: PokedexColors.pureWhite,
  );
}

class PokedexDimensions {
  // Espaçamentos modernos
  static const double paddingSmall = 6.0;
  static const double paddingMedium = 12.0;
  static const double paddingLarge = 18.0;
  static const double paddingXLarge = 24.0;

  // Bordas arredondadas modernas
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;

  // Elevações modernas
  static const double cardElevation = 6.0;
  static const double buttonElevation = 3.0;
  static const double headerElevation = 8.0;

  // Tamanhos de componentes
  static const double cardHeight = 200.0;
  static const double cardWidth = 160.0;
  static const double artistImageSize = 120.0;
  static const double detailImageSize = 200.0;
}

class PokedexStrings {
  static const String appTitle = 'POKÉDEX MUSICAL';
  static const String searchHint = 'Buscar artista...';
  static const String emptyPokedexTitle = 'Sua Pokedex Musical está vazia!';
  static const String emptyPokedexMessage =
      'Use a barra de busca para descobrir\nseus primeiros artistas!';
  static const String noResultsFound = 'Nenhum artista encontrado';
  static const String loadingMessage = 'Buscando artistas...';
  static const String statsTitle = 'Base Stats';
  static const String topTracksTitle = 'Top Músicas';
  static const String albumsTitle = 'Álbuns Principais';
  static const String pokedexStatsTitle = 'Estatísticas da Pokedex';
  static const String discoveredArtists = 'Artistas Descobertos';
  static const String searchResults = 'Resultados da busca';
}
