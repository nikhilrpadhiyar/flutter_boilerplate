import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/constants/app_constants.dart';
import 'package:flutter_boilerplate/core/constants/app_spacing.dart';
import 'package:flutter_boilerplate/core/theme/app_colors.dart';
import 'package:flutter_boilerplate/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_boilerplate/routes/app_pages.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Dashboard', style: context.textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Welcome to the Flutter Boilerplate',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _FeatureGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  final List<_FeatureItem> _features = const <_FeatureItem>[
    _FeatureItem(
      icon: Icons.architecture_rounded,
      label: 'Clean Architecture',
      color: AppColors.primary,
    ),
    _FeatureItem(
      icon: Icons.bolt_rounded,
      label: 'GetX State',
      color: AppColors.secondary,
    ),
    _FeatureItem(
      icon: Icons.network_check_rounded,
      label: 'Dio Networking',
      color: Color(0xFFF4511E),
    ),
    _FeatureItem(
      icon: Icons.palette_rounded,
      label: 'Material 3',
      color: Color(0xFF7B1FA2),
    ),
    _FeatureItem(
      icon: Icons.translate_rounded,
      label: 'Localization',
      color: Color(0xFF00897B),
    ),
    _FeatureItem(
      icon: Icons.science_rounded,
      label: 'Unit Tests',
      color: Color(0xFFC62828),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.4,
      ),
      itemCount: _features.length,
      itemBuilder: (_, int i) => _FeatureCard(item: _features[i]),
    );
  }
}

class _FeatureItem {
  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.item});

  final _FeatureItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item.color.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: item.color, size: 20),
            ),
            Text(item.label, style: context.textTheme.labelLarge, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
