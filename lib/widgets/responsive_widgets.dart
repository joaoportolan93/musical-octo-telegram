import 'package:flutter/material.dart';
import '../utils/responsive_layout.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final bool centerContent;
  
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    // Se não for web, retornar o child diretamente
    if (!ResponsiveLayout.isWeb) {
      return child;
    }
    
    // Para web, aplicar container responsivo
    final containerWidth = maxWidth ?? ResponsiveLayout.getMaxWidth(context);
    final containerPadding = padding ?? EdgeInsets.symmetric(
      horizontal: ResponsiveLayout.getHorizontalPadding(context),
      vertical: ResponsiveLayout.getVerticalPadding(context),
    );
    
    Widget content = Container(
      width: double.infinity,
      padding: containerPadding,
      child: child,
    );
    
    // Se especificado, centralizar o conteúdo
    if (centerContent) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: containerWidth),
          child: content,
        ),
      );
    }
    
    return content;
  }
}

// Widget específico para cards responsivos
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  
  const ResponsiveCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.color,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final cardPadding = padding ?? EdgeInsets.all(
      ResponsiveLayout.getSpacing(context, 16.0),
    );
    
    final cardMargin = margin ?? EdgeInsets.all(
      ResponsiveLayout.getSpacing(context, 8.0),
    );
    
    return Card(
      margin: cardMargin,
      color: color,
      elevation: elevation ?? 2,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(
          ResponsiveLayout.getSpacing(context, 12.0),
        ),
      ),
      child: Padding(
        padding: cardPadding,
        child: child,
      ),
    );
  }
}

// Widget para texto responsivo
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveStyle = style?.copyWith(
      fontSize: style?.fontSize != null 
          ? ResponsiveLayout.getFontSize(context, style!.fontSize!)
          : null,
    );
    
    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
