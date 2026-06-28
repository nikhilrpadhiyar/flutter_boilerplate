import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/core/constants/app_spacing.dart';
import 'package:flutter_boilerplate/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_boilerplate/features/settings/presentation/controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          _SectionHeader(title: 'Appearance'),
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch between light and dark theme'),
              value: controller.isDarkMode.value,
              onChanged: (_) => controller.toggleTheme(),
              secondary: const Icon(Icons.dark_mode_outlined),
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Language'),
          Obx(
            () => _LanguageTile(
              selected: controller.selectedLocale.value,
              onChanged: controller.changeLanguage,
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Account'),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Sign Out'),
            onTap: () => Get.find<AuthController>().logoutUser(),
          ),
          const Divider(),
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('Version'),
            trailing: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.code_rounded),
            title: const Text('Source Code'),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Text(
        title,
        style: context.textTheme.labelLarge?.copyWith(
          color: context.theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.selected, required this.onChanged});

  final String selected;
  final ValueChanged<String> onChanged;

  static const _locales = [
    ('English', 'en'),
    ('Hindi', 'hi'),
    ('Spanish', 'es'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _locales
          .map(
            (l) => RadioListTile<String>(
              title: Text(l.$1),
              value: l.$2,
              groupValue: selected,
              onChanged: (v) => onChanged(v!),
            ),
          )
          .toList(),
    );
  }
}
