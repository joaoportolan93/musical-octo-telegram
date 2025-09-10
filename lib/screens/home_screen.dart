import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/pokedex_provider.dart';
import '../widgets/artist_card.dart';
import '../widgets/type_badge.dart';
import '../widgets/responsive_widgets.dart';
import '../utils/constants.dart';
import '../utils/rate_limit_config.dart';
import '../utils/responsive_layout.dart';
import 'artist_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final provider = context.read<PokedexProvider>();
    if (_searchController.text.trim().isNotEmpty) {
      provider.searchArtists(_searchController.text);
      setState(() {
        _showSearchResults = true;
      });
    } else {
      provider.clearSearchResults();
      setState(() {
        _showSearchResults = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokedexColors.background,
      body: SafeArea(
        child: ResponsiveContainer(
          child: Column(
            children: [
              // Cabeçalho moderno da Pokedex
              _buildModernHeader(),

              // Barra de busca moderna
              _buildModernSearchBar(),

              // Conteúdo principal
              Expanded(
                child: Consumer<PokedexProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return _buildModernLoadingState();
                    }

                    if (_showSearchResults) {
                      return _buildSearchResults(provider);
                    } else {
                      return _buildPokedexContent(provider);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.getSpacing(context, PokedexDimensions.paddingLarge),
        vertical: ResponsiveLayout.getSpacing(context, PokedexDimensions.paddingMedium),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [PokedexColors.deepBlue, PokedexColors.fireRed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.3),
            blurRadius: ResponsiveLayout.getSpacing(context, PokedexDimensions.headerElevation),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Ícone da Pokébola
              Container(
                width: ResponsiveLayout.getSpacing(context, 40),
                height: ResponsiveLayout.getSpacing(context, 40),
                decoration: BoxDecoration(
                  color: PokedexColors.vibrantYellow,
                  borderRadius: BorderRadius.circular(ResponsiveLayout.getSpacing(context, 20)),
                  border: Border.all(color: PokedexColors.pureWhite, width: 2),
                ),
                child: Icon(
                  Icons.music_note,
                  color: PokedexColors.pureWhite,
                  size: ResponsiveLayout.getIconSize(context, 24),
                ),
              ),
              SizedBox(width: ResponsiveLayout.getSpacing(context, PokedexDimensions.paddingMedium)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      'POKÉDEX MUSICAL',
                      style: PokedexTextStyles.displayTitle.copyWith(
                        color: PokedexColors.pureWhite,
                        fontSize: ResponsiveLayout.getFontSize(context, 24),
                      ),
                    ),
                    Consumer<PokedexProvider>(
                      builder: (context, provider, child) {
                        final stats = provider.getPokedexStats();
                        return ResponsiveText(
                          '${stats['total']} Artistas Descobertos',
                          style: PokedexTextStyles.caption.copyWith(
                            color: PokedexColors.pureWhite.withOpacity(0.9),
                            fontSize: ResponsiveLayout.getFontSize(context, 14),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Botão de filtro
              IconButton(
                onPressed: () {
                  // TODO: Implementar filtros
                },
                icon: Icon(
                  Icons.filter_list,
                  color: PokedexColors.pureWhite,
                  size: ResponsiveLayout.getIconSize(context, 28),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernSearchBar() {
    return Container(
      margin: EdgeInsets.all(ResponsiveLayout.getSpacing(context, PokedexDimensions.paddingMedium)),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.getSpacing(context, PokedexDimensions.paddingMedium),
      ),
      decoration: BoxDecoration(
        color: PokedexColors.pureWhite,
        borderRadius: BorderRadius.circular(
          ResponsiveLayout.getSpacing(context, PokedexDimensions.borderRadiusXLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.1),
            blurRadius: ResponsiveLayout.getSpacing(context, 12),
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: PokedexColors.lightGray, width: 1),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: PokedexStrings.searchHint,
          hintStyle: PokedexTextStyles.body.copyWith(
            color: PokedexColors.textLight,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: PokedexColors.vibrantYellow,
            size: ResponsiveLayout.getIconSize(context, 24),
          ),
          suffixIcon: Icon(
            Icons.music_note,
            color: PokedexColors.textLight,
            size: ResponsiveLayout.getIconSize(context, 20),
          ),
        ),
        style: PokedexTextStyles.body,
      ),
    );
  }

  Widget _buildModernLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: PokedexColors.vibrantYellow,
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.music_note,
              size: 40,
              color: PokedexColors.pureWhite,
            ),
          ),
          const SizedBox(height: PokedexDimensions.paddingLarge),
          CircularProgressIndicator(
            color: PokedexColors.vibrantYellow,
            strokeWidth: 3,
          ),
          const SizedBox(height: PokedexDimensions.paddingMedium),
          Text(
            RateLimitConfig.searchMessage,
            style: PokedexTextStyles.body.copyWith(
              color: PokedexColors.textSecondary,
            ),
          ),
          const SizedBox(height: PokedexDimensions.paddingSmall),
          Text(
            RateLimitConfig.searchSubMessage,
            style: PokedexTextStyles.small.copyWith(
              color: PokedexColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(PokedexProvider provider) {
    if (provider.searchResults.isEmpty && provider.searchQuery.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: PokedexColors.lightGray,
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.search_off,
                size: 60,
                color: PokedexColors.textLight,
              ),
            ),
            const SizedBox(height: PokedexDimensions.paddingLarge),
            Text(
              PokedexStrings.noResultsFound,
              style: PokedexTextStyles.subtitle.copyWith(
                color: PokedexColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Botão para voltar à Pokedex
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _showSearchResults = false;
                  });
                },
                icon: const Icon(Icons.arrow_back, color: Colors.red),
              ),
              const Text(
                'Resultados da busca',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Grid de resultados
        Expanded(
          child: ArtistGrid(
            artists: provider.searchResults,
            onArtistTap: (artist) {
              provider.addArtistToPokedex(artist);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistDetailScreen(artist: artist),
                ),
              );
            },
            discoveredIds: provider.discoveredArtists.map((a) => a.id).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPokedexContent(PokedexProvider provider) {
    if (provider.discoveredArtists.isEmpty) {
      return _buildEmptyPokedex();
    }

    return Column(
      children: [
        // Estatísticas da Pokedex
        _buildPokedexStats(provider),

        // Lista de artistas descobertos
        Expanded(
          child: ArtistGrid(
            artists: provider.discoveredArtists,
            onArtistTap: (artist) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistDetailScreen(artist: artist),
                ),
              );
            },
            discoveredIds: provider.discoveredArtists.map((a) => a.id).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPokedex() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.grey[300]!, width: 3),
            ),
            child: const Icon(Icons.music_note, size: 60, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Sua Pokedex Musical está vazia!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Use a barra de busca para descobrir\nseus primeiros artistas!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPokedexStats(PokedexProvider provider) {
    final stats = provider.getPokedexStats();

    return Container(
      margin: const EdgeInsets.all(PokedexDimensions.paddingMedium),
      padding: const EdgeInsets.all(PokedexDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: PokedexColors.pureWhite,
        borderRadius: BorderRadius.circular(
          PokedexDimensions.borderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: PokedexColors.deepBlue.withOpacity(0.1),
            blurRadius: ResponsiveLayout.getSpacing(context, 12),
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
                Icons.analytics,
                color: PokedexColors.vibrantYellow,
                size: 24,
              ),
              const SizedBox(width: PokedexDimensions.paddingSmall),
              Text(
                PokedexStrings.pokedexStatsTitle,
                style: PokedexTextStyles.subtitle,
              ),
            ],
          ),
          const SizedBox(height: PokedexDimensions.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildModernStatItem(
                'Total',
                '${stats['total']}',
                PokedexColors.deepBlue,
              ),
              _buildModernStatItem(
                'Popularidade',
                '${stats['avgPopularity']}',
                PokedexColors.forestGreen,
              ),
              _buildModernStatItem(
                'Conclusão',
                '${stats['completion'].toStringAsFixed(1)}%',
                PokedexColors.fireRed,
              ),
            ],
          ),
          if (stats['genres'].isNotEmpty) ...[
            const SizedBox(height: PokedexDimensions.paddingMedium),
            Text(
              'Gêneros Descobertos:',
              style: PokedexTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: PokedexColors.textSecondary,
              ),
            ),
            const SizedBox(height: PokedexDimensions.paddingSmall),
            Wrap(
              spacing: PokedexDimensions.paddingSmall,
              runSpacing: PokedexDimensions.paddingSmall,
              children: (stats['genres'] as Map<String, int>).entries
                  .take(5)
                  .map((entry) => TypeBadge(type: entry.key, fontSize: 10))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildModernStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: PokedexTextStyles.small.copyWith(
            color: PokedexColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: PokedexDimensions.paddingSmall,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              PokedexDimensions.borderRadiusSmall,
            ),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Text(
            value,
            style: PokedexTextStyles.body.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
