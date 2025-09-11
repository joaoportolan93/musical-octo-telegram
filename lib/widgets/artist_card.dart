import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/artist.dart';
import '../utils/constants.dart';
import '../utils/responsive_layout.dart';
import 'type_badge.dart';

class ArtistCard extends StatefulWidget {
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
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDiscovered = widget.isDiscovered;
    final Widget content = GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
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
              color: (isDiscovered ? PokedexColors.vibrantYellow : PokedexColors.deepBlue)
                  .withOpacity(_hover ? 0.25 : 0.1),
              blurRadius: _hover ? 14 : (isDiscovered ? 12 : 8),
              offset: const Offset(0, 6),
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
                    '#${widget.artist.number.toString().padLeft(3, '0')}',
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
                    color: (isDiscovered ? PokedexColors.vibrantYellow : PokedexColors.deepBlue)
                        .withOpacity(_hover ? 0.35 : 0.1),
                    blurRadius: _hover ? 12 : 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  (PokedexDimensions.artistImageSize - 6) / 2,
                ),
                child: widget.artist.imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.artist.imageUrl,
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
                widget.artist.name,
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
              children: widget.artist.genres
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
                    widget.artist.stats['HP'] ?? 0,
                    PokedexColors.forestGreen,
                  ),
                  _buildModernStatItem(
                    'ATK',
                    widget.artist.stats['Attack'] ?? 0,
                    PokedexColors.fireRed,
                  ),
                  _buildModernStatItem(
                    'DEF',
                    widget.artist.stats['Defense'] ?? 0,
                    PokedexColors.deepBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return _wrapWithHover(content);
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

  Widget _wrapWithHover(Widget child) {
    final scaled = AnimatedScale(
      scale: _hover && ResponsiveLayout.isDesktop(context) ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: child,
    );
    if (ResponsiveLayout.isDesktop(context)) {
      return SizedBox(
        width: ResponsiveLayout.desktopCardWidth,
        height: ResponsiveLayout.desktopCardHeight,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          cursor: SystemMouseCursors.click,
          child: scaled,
        ),
      );
    }
    return scaled;
  }
}

class ArtistGrid extends StatelessWidget {
  final List<Artist> artists;
  final Function(Artist)? onArtistTap;
  final List<String> discoveredIds;
  final ScrollController? controller;

  const ArtistGrid({
    super.key,
    required this.artists,
    this.onArtistTap,
    this.discoveredIds = const [],
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveLayout.gridColumns(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final spacing = 20.0;
    final childAspectRatio = isDesktop
        ? ResponsiveLayout.desktopCardWidth / ResponsiveLayout.desktopCardHeight
        : 0.75;

    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
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
