import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Icon(
        Icons.rocket_launch_rounded,
        color: AppColors.white,
        size: size * 0.55,
      ),
    );
  }
}
