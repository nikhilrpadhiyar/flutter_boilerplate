import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_boilerplate/core/storage/storage_service.dart';
import 'package:flutter_boilerplate/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_boilerplate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_boilerplate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_boilerplate/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    final StorageService storage = Get.find<StorageService>();
    final ApiClient apiClient = Get.find<ApiClient>();

    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiClient),
    );
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(storage));
    Get.lazyPut<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find<AuthRemoteDataSource>(),
        localDataSource: Get.find<AuthLocalDataSource>(),
      ),
    );

    final AuthRepositoryImpl repo = Get.find<AuthRepositoryImpl>();

    Get.lazyPut(() => LoginUseCase(repo));
    Get.lazyPut(() => RegisterUseCase(repo));
    Get.lazyPut(() => LogoutUseCase(repo));

    Get.lazyPut(
      () => AuthController(
        loginUseCase: Get.find<LoginUseCase>(),
        registerUseCase: Get.find<RegisterUseCase>(),
        logoutUseCase: Get.find<LogoutUseCase>(),
        authRepository: repo,
      ),
    );
  }
}
