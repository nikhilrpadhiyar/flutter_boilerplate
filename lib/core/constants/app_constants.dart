class AppConstants {
  AppConstants._();

  static const String appName = 'Flutter Boilerplate';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUser = 'user';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyOnboardingDone = 'onboarding_done';

  // Pagination
  static const int defaultPageSize = 20;

  // Timeouts
  static const Duration splashDuration = Duration(seconds: 2);
}
