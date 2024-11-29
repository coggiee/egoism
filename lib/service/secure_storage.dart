import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MySecureStorage extends LocalStorage {
  final storage = const FlutterSecureStorage();

  @override
  Future persistSession(String persistSessionString) async {
    return storage.write(
        key: supabasePersistSessionKey, value: persistSessionString);
  }

  @override
  Future<String?> accessToken() {
    return storage.read(key: supabasePersistSessionKey);
  }

  @override
  Future<bool> hasAccessToken() {
    return storage.containsKey(key: supabasePersistSessionKey);
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<void> removePersistedSession() {
    return storage.delete(key: supabasePersistSessionKey);
  }
}
