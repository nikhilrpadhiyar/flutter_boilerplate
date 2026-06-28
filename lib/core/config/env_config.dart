import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralises all environment-variable access.
/// Values are read from the `.env` file loaded at startup.
class EnvConfig {
  EnvConfig._();

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';

  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  static String get appEnv => dotenv.env['APP_ENV'] ?? 'production';

  static bool get isDevelopment => appEnv == 'development';
}
