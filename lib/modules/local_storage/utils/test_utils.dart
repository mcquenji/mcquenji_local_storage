import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';
import 'package:universal_io/io.dart';

/// Clears the local storage for testing. Do not call before [initializeLocalStorageForTesting].
///
/// Only use in unit tests.
Future<void> clearLocalStorage() async {
  if (kIsWeb) {
    await _clearWebLocalStorage();
  } else if (PlatformUtils.isDesktop || PlatformUtils.isMobile) {
    await _clearDefaultLocalStorage();
  }
}

/// Sets up the local storage for testing by overriding the [path] and [baseUrl] and clearing the storage.
///
/// Only use in unit tests.
Future<void> initializeLocalStorageForTesting([String path = './build/test', String? baseUrl]) async {
  if (kIsWeb) {
    await _setupWebLocalStorage(baseUrl);
  } else if (PlatformUtils.isDesktop || PlatformUtils.isMobile) {
    await _setupDefaultLocalStorage(path);
  }

  await clearLocalStorage();
}

Future<void> _setupWebLocalStorage(String? baseUrl) async {
  LocalStorageModule.baseUrl = baseUrl;
}

Future<void> _setupDefaultLocalStorage(String path) async {
  LocalStorageModule.overridePath = path;
}

Future<void> _clearWebLocalStorage() async => Modular.get<CookieService>().deleteAllCookies();

Future<void> _clearDefaultLocalStorage() async {
  final dir = Directory(LocalStorageModule.overridePath!);

  if (dir.existsSync()) {
    await dir.delete(recursive: true);
  }
}
