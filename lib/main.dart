import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/config/env_config.dart';
import 'package:flutter_boilerplate/core/constants/app_constants.dart';
import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_boilerplate/core/storage/storage_service.dart';
import 'package:flutter_boilerplate/core/theme/app_theme.dart';
import 'package:flutter_boilerplate/firebase_options.dart';
import 'package:flutter_boilerplate/routes/app_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load();
  await GetStorage.init();

  final storage = StorageService(GetStorage());
  Get.put<StorageService>(storage, permanent: true);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ApiClient.instance.init(storage);
  Get.put<ApiClient>(ApiClient.instance, permanent: true);

  final savedTheme = storage.read<String>(AppConstants.keyThemeMode);
  final themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  final savedLang = storage.read<String>(AppConstants.keyLanguage) ?? 'en';

  runApp(
    BoilerplateApp(themeMode: themeMode, locale: Locale(savedLang)),
  );
}

class BoilerplateApp extends StatelessWidget {
  const BoilerplateApp({
    super.key,
    required this.themeMode,
    required this.locale,
  });

  final ThemeMode themeMode;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: EnvConfig.isDevelopment,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      fallbackLocale: const Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('es'),
      ],
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
