import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StatsBar extends StatelessWidget {
  final String statName;
  final int value;
  final int maxValue;
  final Color? color;

  const StatsBar({
    super.key,
    required this.statName,
    required this.value,
    this.maxValue = 200,
    this.color,
  });

  Color _getStatColor(String statName) {
    switch (statName) {
      case 'HP':
        return PokedexColors.forestGreen;
      case 'Attack':
        return PokedexColors.fireRed;
      case 'Defense':
        return PokedexColors.deepBlue;
      case 'Sp. Attack':
        return PokedexColors.vibrantYellow;
      case 'Sp. Defense':
        return PokedexColors.lightGray;
      case 'Speed':
        return PokedexColors.fireRed;
      default:
        return PokedexColors.textSecondary;
    }
  }

  double _getProgressPercentage() {
    return value / maxValue;
  }

  @override
  Widget build(BuildContext context) {
    final statColor = color ?? _getStatColor(statName);
    final progress = _getProgressPercentage();

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: PokedexDimensions.paddingSmall,
      ),
      child: Row(
        children: [
          // Nome da estatística
          SizedBox(
            width: 90,
            child: Text(
              statName,
              style: PokedexTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: PokedexColors.textPrimary,
              ),
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
                          colors: [statColor, statColor.withOpacity(0.8)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          PokedexDimensions.borderRadiusMedium,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: statColor.withOpacity(0.3),
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
                      '$value',
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
            width: 50,
            child: Text(
              '$value',
              textAlign: TextAlign.right,
              style: PokedexTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: statColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsChart extends StatelessWidget {
  final Map<String, int> stats;

  const StatsChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
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
          const Text(
            'Base Stats',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...stats.entries.map(
            (entry) => StatsBar(statName: entry.key, value: entry.value),
          ),
        ],
      ),
    );
  }
}
