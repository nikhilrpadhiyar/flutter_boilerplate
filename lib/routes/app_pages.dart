import 'package:get/get.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter_boilerplate/features/home/presentation/pages/home_page.dart';
import 'package:flutter_boilerplate/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter_boilerplate/features/auth/presentation/controllers/auth_binding.dart';
import 'package:flutter_boilerplate/features/home/presentation/controllers/home_binding.dart';
import 'package:flutter_boilerplate/features/settings/presentation/controllers/settings_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
