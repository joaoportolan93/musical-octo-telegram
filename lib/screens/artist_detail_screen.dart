import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/artist.dart';
import '../widgets/type_badge.dart';
import '../widgets/music_stats_bar.dart';
import '../utils/constants.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokedexColors.background,
      appBar: AppBar(
        backgroundColor: PokedexColors.deepBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PokedexColors.pureWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pokedex Musical',
          style: PokedexTextStyles.subtitle.copyWith(
            color: PokedexColors.pureWhite,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: PokedexColors.pureWhite),
            onPressed: () {
              // TODO: Implementar compartilhamento
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho com nome e número
            _buildHeader(),

            // Conteúdo principal
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Seção superior com imagem e informações básicas
                  _buildTopSection(),

                  const SizedBox(height: 20),

                  // Estatísticas base
                  _buildStatsSection(),

                  const SizedBox(height: 20),

                  // Top músicas (movimentos)
                  _buildTopTracksSection(),

                  const SizedBox(height: 20),

                  // Álbuns
                  _buildAlbumsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PokedexDimensions.paddingLarge),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [PokedexColors.deepBlue, PokedexColors.fireRed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.3),
            blurRadius: PokedexDimensions.headerElevation,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Número do artista
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PokedexDimensions.paddingMedium,
                  vertical: PokedexDimensions.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: PokedexColors.vibrantYellow,
                  borderRadius: BorderRadius.circular(
                    PokedexDimensions.borderRadiusMedium,
                  ),
                ),
                child: Text(
                  '#${artist.number.toString().padLeft(3, '0')}',
                  style: PokedexTextStyles.caption.copyWith(
                    color: PokedexColors.pureWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: PokedexDimensions.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist.name,
                      style: PokedexTextStyles.displayTitle.copyWith(
                        color: PokedexColors.pureWhite,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Artista Musical',
                      style: PokedexTextStyles.body.copyWith(
                        color: PokedexColors.pureWhite.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.all(PokedexDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: PokedexColors.pureWhite,
        borderRadius: BorderRadius.circular(
          PokedexDimensions.borderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: PokedexColors.lightGray, width: 1),
      ),
      child: Column(
        children: [
          // Imagem do artista com design moderno
          Container(
            width: PokedexDimensions.detailImageSize,
            height: PokedexDimensions.detailImageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                PokedexDimensions.detailImageSize / 2,
              ),
              border: Border.all(color: PokedexColors.vibrantYellow, width: 4),
              boxShadow: [
                BoxShadow(
                  color: PokedexColors.vibrantYellow.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                (PokedexDimensions.detailImageSize - 8) / 2,
              ),
              child: artist.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: artist.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: PokedexColors.lightGray,
                        child: const Icon(
                          Icons.music_note,
                          size: 60,
                          color: PokedexColors.textLight,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: PokedexColors.lightGray,
                        child: const Icon(
                          Icons.music_note,
                          size: 60,
                          color: PokedexColors.textLight,
                        ),
                      ),
                    )
                  : Container(
                      color: PokedexColors.lightGray,
                      child: const Icon(
                        Icons.music_note,
                        size: 60,
                        color: PokedexColors.textLight,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: PokedexDimensions.paddingLarge),

          // Tipos (gêneros) com design moderno
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category,
                color: PokedexColors.vibrantYellow,
                size: 20,
              ),
              const SizedBox(width: PokedexDimensions.paddingSmall),
              Text(
                'Tipos: ',
                style: PokedexTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: PokedexColors.textPrimary,
                ),
              ),
              ...artist.genres.map(
                (genre) => Padding(
                  padding: const EdgeInsets.only(
                    left: PokedexDimensions.paddingSmall,
                  ),
                  child: TypeBadge(type: genre, fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: PokedexDimensions.paddingLarge),

          // Dados criativos com design moderno
          Container(
            padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: PokedexColors.background,
              borderRadius: BorderRadius.circular(
                PokedexDimensions.borderRadiusMedium,
              ),
              border: Border.all(color: PokedexColors.lightGray, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildModernCreativeData(
                      'Anos de Carreira',
                      '${artist.creativeData['career_years']} anos',
                      Icons.calendar_today,
                      PokedexColors.forestGreen,
                    ),
                    _buildModernCreativeData(
                      'Álbuns',
                      '${artist.creativeData['albums_count']}',
                      Icons.album,
                      PokedexColors.deepBlue,
                    ),
                  ],
                ),
                const SizedBox(height: PokedexDimensions.paddingMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildModernCreativeData(
                      'Ouvintes Mensais',
                      _formatNumber(artist.creativeData['monthly_listeners'] ?? artist.creativeData['popularity_score'] * 1000),
                      Icons.headphones,
                      PokedexColors.fireRed,
                    ),
                    _buildModernCreativeData(
                      'Seguidores',
                      _formatNumber(artist.creativeData['followers']),
                      Icons.people,
                      PokedexColors.vibrantYellow,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCreativeData(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(PokedexDimensions.paddingSmall),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              PokedexDimensions.borderRadiusSmall,
            ),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: PokedexDimensions.paddingSmall),
        Text(
          label,
          style: PokedexTextStyles.small.copyWith(
            color: PokedexColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: PokedexTextStyles.body.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(PokedexDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: PokedexColors.pureWhite,
        borderRadius: BorderRadius.circular(
          PokedexDimensions.borderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: PokedexColors.lightGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🎵',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: PokedexDimensions.paddingSmall),
              Text(
                'Músicas Mais Famosas',
                style: PokedexTextStyles.subtitle,
              ),
            ],
          ),
          const SizedBox(height: PokedexDimensions.paddingLarge),
          MusicStatsChart(topTracks: artist.topTracks),
        ],
      ),
    );
  }

  Widget _buildTopTracksSection() {
    return Container(
      padding: const EdgeInsets.all(PokedexDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: PokedexColors.pureWhite,
        borderRadius: BorderRadius.circular(
          PokedexDimensions.borderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: PokedexColors.lightGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.music_note,
                color: PokedexColors.vibrantYellow,
                size: 24,
              ),
              const SizedBox(width: PokedexDimensions.paddingSmall),
              Text(
                PokedexStrings.topTracksTitle,
                style: PokedexTextStyles.subtitle,
              ),
            ],
          ),
          const SizedBox(height: PokedexDimensions.paddingLarge),
          ...artist.topTracks.asMap().entries.map((entry) {
            final index = entry.key;
            final track = entry.value;
            return Container(
              margin: const EdgeInsets.only(
                bottom: PokedexDimensions.paddingSmall,
              ),
              padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: PokedexColors.background,
                borderRadius: BorderRadius.circular(
                  PokedexDimensions.borderRadiusMedium,
                ),
                border: Border.all(color: PokedexColors.lightGray, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: PokedexColors.vibrantYellow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: PokedexTextStyles.caption.copyWith(
                          color: PokedexColors.pureWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: PokedexDimensions.paddingMedium),
                  Expanded(
                    child: Text(
                      track,
                      style: PokedexTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.play_circle_outline,
                    color: PokedexColors.textLight,
                    size: 24,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAlbumsSection() {
    if (artist.albums.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(PokedexDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: PokedexColors.pureWhite,
        borderRadius: BorderRadius.circular(
          PokedexDimensions.borderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: PokedexColors.lightGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.album, color: PokedexColors.vibrantYellow, size: 24),
              const SizedBox(width: PokedexDimensions.paddingSmall),
              Text(
                PokedexStrings.albumsTitle,
                style: PokedexTextStyles.subtitle,
              ),
            ],
          ),
          const SizedBox(height: PokedexDimensions.paddingLarge),
          ...artist.albums.map(
            (album) => Container(
              margin: const EdgeInsets.only(
                bottom: PokedexDimensions.paddingSmall,
              ),
              padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: PokedexColors.background,
                borderRadius: BorderRadius.circular(
                  PokedexDimensions.borderRadiusMedium,
                ),
                border: Border.all(color: PokedexColors.lightGray, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      PokedexDimensions.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: PokedexColors.forestGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        PokedexDimensions.borderRadiusSmall,
                      ),
                    ),
                    child: Icon(
                      Icons.album,
                      color: PokedexColors.forestGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: PokedexDimensions.paddingMedium),
                  Expanded(
                    child: Text(
                      album,
                      style: PokedexTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: PokedexColors.textLight,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(dynamic number) {
    if (number is int) {
      if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      } else if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}K';
      }
      return number.toString();
    }
    return '0';
  }
}
