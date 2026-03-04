import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double elevation;
  final Color? color;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.elevation = 3,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: margin ?? const EdgeInsets.only(bottom: 15),
      color: color ?? AppColors.darkWhitColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
