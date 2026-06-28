import 'package:get_storage/get_storage.dart';

/// Thin wrapper around GetStorage.
/// All read/write operations use typed methods to prevent key collisions.
class StorageService {
  StorageService(this._box);

  final GetStorage _box;

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, dynamic value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);

  Future<void> erase() => _box.erase();

  bool hasData(String key) => _box.hasData(key);
}
