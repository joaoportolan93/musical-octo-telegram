import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/artist.dart';
import '../utils/constants.dart';
import 'type_badge.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;
  final VoidCallback? onTap;
  final bool isDiscovered;

  const ArtistCard({
    super.key,
    required this.artist,
    this.onTap,
    this.isDiscovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(PokedexDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: PokedexColors.pureWhite,
          borderRadius: BorderRadius.circular(
            PokedexDimensions.borderRadiusLarge,
          ),
          border: Border.all(
            color: isDiscovered
                ? PokedexColors.vibrantYellow
                : PokedexColors.lightGray,
            width: isDiscovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDiscovered
                  ? PokedexColors.vibrantYellow.withOpacity(0.2)
                  : PokedexColors.deepBlue.withOpacity(0.1),
              blurRadius: isDiscovered ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Cabeçalho moderno com número
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: PokedexDimensions.paddingMedium,
                vertical: PokedexDimensions.paddingSmall,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDiscovered
                      ? [PokedexColors.vibrantYellow, PokedexColors.fireRed]
                      : [PokedexColors.deepBlue, PokedexColors.fireRed],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(PokedexDimensions.borderRadiusLarge),
                  topRight: Radius.circular(
                    PokedexDimensions.borderRadiusLarge,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${artist.number.toString().padLeft(3, '0')}',
                    style: PokedexTextStyles.caption.copyWith(
                      color: PokedexColors.pureWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (isDiscovered)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: PokedexColors.pureWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: PokedexColors.forestGreen,
                        size: 16,
                      ),
                    ),
                ],
              ),
            ),

            // Imagem do artista moderna
            Container(
              width: PokedexDimensions.artistImageSize,
              height: PokedexDimensions.artistImageSize,
              margin: const EdgeInsets.all(PokedexDimensions.paddingMedium),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  PokedexDimensions.artistImageSize / 2,
                ),
                border: Border.all(
                  color: isDiscovered
                      ? PokedexColors.vibrantYellow
                      : PokedexColors.lightGray,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDiscovered
                        ? PokedexColors.vibrantYellow.withOpacity(0.3)
                        : PokedexColors.deepBlue.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  (PokedexDimensions.artistImageSize - 6) / 2,
                ),
                child: artist.imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: artist.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: PokedexColors.lightGray,
                          child: const Icon(
                            Icons.music_note,
                            size: 40,
                            color: PokedexColors.textLight,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: PokedexColors.lightGray,
                          child: const Icon(
                            Icons.music_note,
                            size: 40,
                            color: PokedexColors.textLight,
                          ),
                        ),
                      )
                    : Container(
                        color: PokedexColors.lightGray,
                        child: const Icon(
                          Icons.music_note,
                          size: 40,
                          color: PokedexColors.textLight,
                        ),
                      ),
              ),
            ),

            // Nome do artista
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PokedexDimensions.paddingMedium,
              ),
              child: Text(
                artist.name,
                textAlign: TextAlign.center,
                style: PokedexTextStyles.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: PokedexColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: PokedexDimensions.paddingSmall),

            // Tipos (gêneros)
            Wrap(
              spacing: PokedexDimensions.paddingSmall,
              runSpacing: PokedexDimensions.paddingSmall,
              alignment: WrapAlignment.center,
              children: artist.genres
                  .take(2)
                  .map((genre) => TypeBadge(type: genre, fontSize: 10))
                  .toList(),
            ),

            const SizedBox(height: PokedexDimensions.paddingMedium),

            // Estatísticas resumidas modernas
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: PokedexDimensions.paddingMedium,
                vertical: PokedexDimensions.paddingSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildModernStatItem(
                    'HP',
                    artist.stats['HP'] ?? 0,
                    PokedexColors.forestGreen,
                  ),
                  _buildModernStatItem(
                    'ATK',
                    artist.stats['Attack'] ?? 0,
                    PokedexColors.fireRed,
                  ),
                  _buildModernStatItem(
                    'DEF',
                    artist.stats['Defense'] ?? 0,
                    PokedexColors.deepBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernStatItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: PokedexTextStyles.small.copyWith(
            color: PokedexColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$value',
            style: PokedexTextStyles.small.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class ArtistGrid extends StatelessWidget {
  final List<Artist> artists;
  final Function(Artist)? onArtistTap;
  final List<String> discoveredIds;

  const ArtistGrid({
    super.key,
    required this.artists,
    this.onArtistTap,
    this.discoveredIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: PokedexDimensions.paddingSmall,
        mainAxisSpacing: PokedexDimensions.paddingSmall,
      ),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        final isDiscovered = discoveredIds.contains(artist.id);

        return AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 200),
          child: ArtistCard(
            artist: artist,
            onTap: () => onArtistTap?.call(artist),
            isDiscovered: isDiscovered,
          ),
        );
      },
    );
  }
}
