import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/pokedex_provider.dart';
import '../widgets/artist_card.dart';
import '../widgets/type_badge.dart';
import '../widgets/responsive_widgets.dart';
import '../utils/constants.dart';
// import '../utils/rate_limit_config.dart';
import '../utils/responsive_layout.dart';
import 'artist_detail_screen.dart';

class _SearchFocusIntent extends Intent {
  const _SearchFocusIntent();
}

class _DesktopSidebar extends StatelessWidget {
  final Widget searchField;
  final Widget Function() statsBuilder;
  final Widget filters;
  const _DesktopSidebar({required this.searchField, required this.statsBuilder, required this.filters});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchField,
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.brightness_6_rounded, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Modo escuro', style: PokedexTextStyles.body.copyWith(color: Colors.grey[800])),
              ),
              Switch(
                value: context.watch<PokedexProvider>().isDarkTheme,
                onChanged: (v) => context.read<PokedexProvider>().toggleTheme(v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.bookmark, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Apenas favoritos', style: PokedexTextStyles.body.copyWith(color: Colors.grey[800])),
              ),
              Switch(
                value: context.watch<PokedexProvider>().favoritesOnly,
                onChanged: (v) => context.read<PokedexProvider>().setFavoritesOnly(v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // ...existing code...
            ],
          ),
          // Estatísticas removidas da barra lateral
          const SizedBox(height: 16),
          Text('Filtros', style: PokedexTextStyles.subtitle),
          const SizedBox(height: 8),
          filters,
        ],
      ),
    );
  }
}

class _DesktopFilters extends StatelessWidget {
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onGenreChanged;
  const _DesktopFilters({required this.onSortChanged, required this.onGenreChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          items: const [
            DropdownMenuItem(value: 'popularidade', child: Text('Ouvintes Mensais')),
            DropdownMenuItem(value: 'alfabetico', child: Text('A-Z')),
          ],
          initialValue: context.watch<PokedexProvider>().sortMode,
          onChanged: (v) => onSortChanged(v ?? 'popularidade'),
          decoration: const InputDecoration(labelText: 'Ordenar por:'),
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Filtrar por gênero',
            prefixIcon: Icon(Icons.category),
          ),
          onChanged: onGenreChanged,
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _discoveredScrollController = ScrollController();
  final ScrollController _searchScrollController = ScrollController();
  bool _showSearchResults = false;
  int _visibleDiscovered = 20;
  int _visibleSearch = 20;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _discoveredScrollController.addListener(_onDiscoveredScroll);
    _searchScrollController.addListener(_onSearchScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _discoveredScrollController.dispose();
    _searchScrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final provider = context.read<PokedexProvider>();
    if (_searchController.text.trim().isNotEmpty) {
      provider.searchArtists(_searchController.text);
      setState(() {
        _showSearchResults = true;
        _visibleSearch = 20;
      });
    } else {
      provider.clearSearchResults();
      setState(() {
        _showSearchResults = false;
      });
    }
  }

  void _onDiscoveredScroll() {
    if (_discoveredScrollController.position.pixels >=
        _discoveredScrollController.position.maxScrollExtent - 200) {
      setState(() {
        _visibleDiscovered += 20;
      });
    }
  }

  void _onSearchScroll() {
    if (_searchScrollController.position.pixels >=
        _searchScrollController.position.maxScrollExtent - 200) {
      setState(() {
        _visibleSearch += 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDesktop) {
      // Layout desktop com sidebar fixa
      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF121212) : PokedexColors.background,
        body: SafeArea(
          child: Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.slash): const _SearchFocusIntent(),
              LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK): const _SearchFocusIntent(),
              LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK): const _SearchFocusIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                _SearchFocusIntent: CallbackAction<_SearchFocusIntent>(onInvoke: (intent) {
                  _searchFocusNode.requestFocus();
                  return null;
                }),
              },
              child: Focus(
                autofocus: true,
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: _DesktopSidebar(
                        searchField: _buildModernSearchBar(),
                        statsBuilder: () => Consumer<PokedexProvider>(
                          builder: (context, provider, _) => _buildPokedexStats(provider),
                        ),
                        filters: _DesktopFilters(
                          onSortChanged: (mode) => context.read<PokedexProvider>().setSortMode(mode),
                          onGenreChanged: (genre) => context.read<PokedexProvider>().setGenreFilter(genre),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: isDark ? const Color(0xFF121212) : Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: Consumer<PokedexProvider>(
                                builder: (context, provider, child) {
                                  if (provider.isLoading) {
                                    return _buildSkeletonGrid();
                                  }
                                  if (_showSearchResults) {
                                    return _buildSearchResults(provider);
                                  }
                                  return _buildPokedexContent(provider);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Layout mobile/tablet atual
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : PokedexColors.background,
      body: SafeArea(
        child: Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.slash): const _SearchFocusIntent(),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK): const _SearchFocusIntent(),
            LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK): const _SearchFocusIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              _SearchFocusIntent: CallbackAction<_SearchFocusIntent>(onInvoke: (intent) {
                _searchFocusNode.requestFocus();
                return null;
              }),
            },
            child: Focus(
              autofocus: true,
              child: ResponsiveContainer(
                child: Container(
                  color: isDark ? const Color(0xFF121212) : Colors.white,
                  child: Column(
                    children: [
                      _buildModernHeader(),
                      _buildModernSearchBar(),
                      Expanded(
                        child: Consumer<PokedexProvider>(
                          builder: (context, provider, child) {
                            if (provider.isLoading) {
                              return _buildSkeletonGrid();
                            }
                            if (_showSearchResults) {
                              return _buildSearchResults(provider);
                            }
                            return _buildPokedexContent(provider);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
        focusNode: _searchFocusNode,
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

  Widget _buildDesktopHeaderWithBreadcrumbs() {
    return Container(
      color: PokedexColors.pureWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.home, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          Text('Início', style: PokedexTextStyles.small.copyWith(color: Colors.grey[700])),
          const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
          Text(_showSearchResults ? 'Busca' : 'Pokedex', style: PokedexTextStyles.body),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, size: 20, color: Colors.grey),
            tooltip: 'Configurações',
          )
        ],
      ),
    );
  }

  Widget _buildSkeletonGrid() {
    return Builder(
      builder: (context) {
        final crossAxisCount = ResponsiveLayout.gridColumns(context);
        final isDesktop = ResponsiveLayout.isDesktop(context);
        final spacing = 20.0;
        final childAspectRatio = isDesktop
            ? ResponsiveLayout.desktopCardWidth / ResponsiveLayout.desktopCardHeight
            : 0.75;
        return GridView.builder(
          padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: 8,
          itemBuilder: (_, __) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(PokedexDimensions.borderRadiusLarge),
              border: Border.all(color: PokedexColors.lightGray, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(PokedexDimensions.borderRadiusLarge),
                      topRight: Radius.circular(PokedexDimensions.borderRadiusLarge),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 16),
                Container(height: 12, width: 140, color: Color(0xFFF0F0F0)),
                const SizedBox(height: 8),
                Container(height: 10, width: 100, color: Color(0xFFF0F0F0)),
              ],
            ),
          ),
        );
      },
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
            controller: _searchScrollController,
            artists: provider.searchFiltered.take(_visibleSearch).toList(),
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
            controller: _discoveredScrollController,
            artists: provider.discoveredFiltered.take(_visibleDiscovered).toList(),
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

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(PokedexDimensions.paddingSmall),
      padding: const EdgeInsets.all(PokedexDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(PokedexDimensions.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
            blurRadius: ResponsiveLayout.getSpacing(context, 12),
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: isDark ? Colors.grey[800]! : PokedexColors.lightGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            PokedexStrings.pokedexStatsTitle,
            style: PokedexTextStyles.subtitle.copyWith(
              color: isDark ? Colors.white : PokedexColors.deepBlue,
            ),
          ),
          const SizedBox(height: PokedexDimensions.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildModernStatItem(
                'Artistas encontrados',
                '${stats['total']}',
                isDark ? Colors.red[300]! : Theme.of(context).colorScheme.primary,
              ),
              _buildModernStatItem(
                'Países descobertos',
                '${stats['countries']}',
                isDark ? Colors.greenAccent[400]! : PokedexColors.forestGreen,
              ),
              _buildModernStatItem(
                'Conclusão',
                '${stats['completion'].toStringAsFixed(1)}%',
                isDark ? Colors.redAccent : PokedexColors.fireRed,
              ),
            ],
          ),
          if (stats['genres'].isNotEmpty) ...[
            const SizedBox(height: PokedexDimensions.paddingMedium),
            Text(
              'Gêneros Descobertos:',
              style: PokedexTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : PokedexColors.textSecondary,
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
// Fim do arquivo
