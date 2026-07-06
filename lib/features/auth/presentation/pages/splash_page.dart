import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/constants/app_constants.dart';
import 'package:flutter_boilerplate/core/theme/app_colors.dart';
import 'package:flutter_boilerplate/core/theme/app_text_styles.dart';
import 'package:flutter_boilerplate/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<AuthController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.rocket_launch_rounded,
              size: 72,
              color: AppColors.white,
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: AppTextStyles.displayMedium.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Production-ready Flutter',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withAlpha(200),
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
