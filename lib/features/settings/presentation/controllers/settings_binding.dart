import 'package:get/get.dart';
import 'package:flutter_boilerplate/core/storage/storage_service.dart';
import 'package:flutter_boilerplate/features/settings/presentation/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingsController(Get.find<StorageService>()),
    );
  }
}
