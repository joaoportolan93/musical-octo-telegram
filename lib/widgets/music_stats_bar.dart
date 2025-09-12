import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MusicStatsBar extends StatelessWidget {
  final String trackName;
  final int views;
  final int maxViews;
  final int position;
  final Color? color;

  const MusicStatsBar({
    super.key,
    required this.trackName,
    required this.views,
    required this.maxViews,
    required this.position,
    this.color,
  });

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return const Color(0xFFFFD700); // Dourado
      case 2:
        return const Color(0xFFC0C0C0); // Prateado
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      case 4:
        return const Color(0xFF4A90E2); // Azul
      case 5:
        return const Color(0xFF50C878); // Verde
      case 6:
        return const Color(0xFF9370DB); // Roxo
      default:
        return PokedexColors.textSecondary;
    }
  }

  double _getProgressPercentage() {
    if (maxViews == 0) return 0.0;
    return views / maxViews;
  }

  String _formatViews(int views) {
    if (views >= 1000000000) {
      return '${(views / 1000000000).toStringAsFixed(1)}B';
    } else if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }

  String _truncateTrackName(String name) {
    // Remover featuring/collaborations
    String cleanName = name.split(' ft.')[0].split(' feat.')[0].split(' featuring')[0];
    
    // Truncar se muito longo
    if (cleanName.length > 25) {
      return '${cleanName.substring(0, 22)}...';
    }
    return cleanName;
  }

  @override
  Widget build(BuildContext context) {
    final trackColor = color ?? _getPositionColor(position);
    final progress = _getProgressPercentage();

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: PokedexDimensions.paddingSmall,
      ),
      child: Row(
        children: [
          // Nome da música
          SizedBox(
            width: 120,
            child: Text(
              _truncateTrackName(trackName),
              style: PokedexTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: PokedexColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Barra de progresso moderna
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: PokedexColors.lightGray,
                borderRadius: BorderRadius.circular(
                  PokedexDimensions.borderRadiusMedium,
                ),
                border: Border.all(color: PokedexColors.lightGray, width: 1),
              ),
              child: Stack(
                children: [
                  // Barra de progresso
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [trackColor, trackColor.withOpacity(0.8)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          PokedexDimensions.borderRadiusMedium,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: trackColor.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Valor numérico
                  Center(
                    child: Text(
                      _formatViews(views),
                      style: PokedexTextStyles.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: PokedexColors.pureWhite,
                        shadows: [
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Valor numérico à direita
          SizedBox(
            width: 60,
            child: Text(
              _formatViews(views),
              textAlign: TextAlign.right,
              style: PokedexTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: trackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MusicStatsChart extends StatelessWidget {
  final List<String> topTracks;

  const MusicStatsChart({super.key, required this.topTracks});

  List<Map<String, dynamic>> _generateTrackViews(List<String> tracks) {
    // Simular views baseado em padrões reais do Spotify
    List<Map<String, dynamic>> trackData = [];
    
    // Ranges realistas baseados em hits reais do Spotify
    final List<int> realisticRanges = [
      2000000000, // ~2B (Blinding Lights, Shape of You)
      1500000000, // ~1.5B (Dance Monkey, Someone You Loved)
      1200000000, // ~1.2B (Sunflower, One Dance)
      900000000,  // ~900M (Closer, Perfect)
      700000000,  // ~700M (Thinking Out Loud, All of Me)
      500000000,  // ~500M (Counting Stars, Radioactive)
    ];
    
    for (int i = 0; i < tracks.length && i < 6; i++) {
      String track = tracks[i];
      
      // Usar range realista baseado na posição
      int baseViews = i < realisticRanges.length ? realisticRanges[i] : 300000000;
      
      // Adicionar variação realista baseada no nome da música
      // Músicas com nomes mais curtos tendem a ser mais populares
      double nameFactor = 1.0;
      if (track.length <= 10) {
        nameFactor = 1.1; // +10% para nomes curtos
      } else if (track.length <= 20) {
        nameFactor = 1.0; // Normal
      } else {
        nameFactor = 0.9; // -10% para nomes longos
      }
      
      // Adicionar pequena variação aleatória (±5%)
      double randomFactor = 0.95 + (track.hashCode % 10) * 0.01;
      
      // Views finais
      int views = (baseViews * nameFactor * randomFactor).round();
      
      trackData.add({
        'name': track,
        'views': views,
        'position': i + 1,
      });
    }
    
    return trackData;
  }

  @override
  Widget build(BuildContext context) {
    final trackData = _generateTrackViews(topTracks);
    final maxViews = trackData.isNotEmpty ? trackData.first['views'] : 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🎵',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'Músicas Mais Famosas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...trackData.map(
            (track) => MusicStatsBar(
              trackName: track['name'],
              views: track['views'],
              maxViews: maxViews,
              position: track['position'],
            ),
          ),
        ],
      ),
    );
  }
}
