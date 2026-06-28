import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/core/constants/app_constants.dart';
import 'package:flutter_boilerplate/core/storage/storage_service.dart';

class SettingsController extends GetxController {
  SettingsController(this._storage);

  final StorageService _storage;

  final isDarkMode = false.obs;
  final selectedLocale = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    final saved = _storage.read<String>(AppConstants.keyThemeMode);
    isDarkMode.value = saved == 'dark';
    selectedLocale.value =
        _storage.read<String>(AppConstants.keyLanguage) ?? 'en';
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
    await _storage.write(
      AppConstants.keyThemeMode,
      isDarkMode.value ? 'dark' : 'light',
    );
  }

  Future<void> changeLanguage(String code) async {
    selectedLocale.value = code;
    await Get.updateLocale(Locale(code));
    await _storage.write(AppConstants.keyLanguage, code);
  }
}
