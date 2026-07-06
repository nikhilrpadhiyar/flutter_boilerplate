import 'package:flutter_boilerplate/features/auth/presentation/controllers/auth_binding.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter_boilerplate/features/home/presentation/controllers/home_binding.dart';
import 'package:flutter_boilerplate/features/home/presentation/pages/home_page.dart';
import 'package:flutter_boilerplate/features/settings/presentation/controllers/settings_binding.dart';
import 'package:flutter_boilerplate/features/settings/presentation/pages/settings_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String initial = AppRoutes.splash;

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: AuthBinding(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
