import 'package:get_storage/get_storage.dart';

class StorageService {
  late GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.writeIfNull("convo", []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write<T>(String key, dynamic data) async {
    await _box.write(key, data);
  }
}
