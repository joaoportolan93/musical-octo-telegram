import 'package:flutter/material.dart';

class TypeBadge extends StatelessWidget {
  final String type;
  final double fontSize;
  final bool isSelected;

  const TypeBadge({
    super.key,
    required this.type,
    this.fontSize = 12,
    this.isSelected = false,
  });

  Color _getTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'HIP-HOP':
      case 'TRAP':
      case 'RAP':
        return const Color(0xFF8B4513); // Marrom escuro
      case 'POP':
        return const Color(0xFFFF69B4); // Rosa
      case 'ROCK':
        return const Color(0xFF8B0000); // Vermelho escuro
      case 'ELECTRONIC':
      case 'EDM':
        return const Color(0xFF9370DB); // Roxo
      case 'R&B':
      case 'SOUL':
        return const Color(0xFF4169E1); // Azul real
      case 'COUNTRY':
        return const Color(0xFF8FBC8F); // Verde escuro
      case 'JAZZ':
        return const Color(0xFFDAA520); // Dourado
      case 'CLASSICAL':
        return const Color(0xFF708090); // Cinza
      case 'REGGAE':
        return const Color(0xFF32CD32); // Verde lima
      case 'METAL':
        return const Color(0xFF2F4F4F); // Cinza escuro
      case 'FOLK':
        return const Color(0xFFDEB887); // Marrom claro
      case 'BLUES':
        return const Color(0xFF191970); // Azul marinho
      case 'PUNK':
        return const Color(0xFFFF4500); // Laranja vermelho
      case 'INDIE':
        return const Color(0xFF20B2AA); // Verde azulado
      case 'ALTERNATIVE':
        return const Color(0xFF6A5ACD); // Slate azul
      case 'FUNK':
        return const Color(0xFFFFD700); // Dourado
      case 'DISCO':
        return const Color(0xFFFF1493); // Rosa profundo
      case 'GOSPEL':
        return const Color(0xFF8A2BE2); // Azul violeta
      default:
        return const Color(0xFF808080); // Cinza padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getTypeColor(type),
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: _getTypeColor(type).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
