import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_boilerplate/routes/app_pages.dart';

class AuthController extends GetxController {
  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required AuthRepository authRepository,
  })  : _login = loginUseCase,
        _register = registerUseCase,
        _logout = logoutUseCase,
        _repository = authRepository;

  final LoginUseCase _login;
  final RegisterUseCase _register;
  final LogoutUseCase _logout;
  final AuthRepository _repository;

  final isLoading = false.obs;
  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _checkAuthState();
  }

  void _checkAuthState() {
    if (_repository.isAuthenticated) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  Future<void> loginUser() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading.value = true;
    final result = await _login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    isLoading.value = false;
    result.fold(
      (failure) => Get.snackbar(
        'Login Failed',
        failure.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      ),
      (user) {
        currentUser.value = user;
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  Future<void> registerUser() async {
    if (!registerFormKey.currentState!.validate()) return;
    isLoading.value = true;
    final result = await _register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    isLoading.value = false;
    result.fold(
      (failure) => Get.snackbar(
        'Registration Failed',
        failure.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      ),
      (user) {
        currentUser.value = user;
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  Future<void> logoutUser() async {
    isLoading.value = true;
    final result = await _logout();
    isLoading.value = false;
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) {
        currentUser.value = null;
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
