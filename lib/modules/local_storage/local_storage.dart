import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_io/io.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'utils/utils.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Provides local storage access in a modular way.
///
/// To use this you need to provide an [IGenericSerializer] instance for the type you want to store.
///
/// Example:
/// ```dart
/// @override
/// void binds(Injector i) {
///    i.addSerde<MyModel>(
///      fromJson: MyModel.fromJson,
///      toJson: (m) => m.toJson(),
///    );
/// }
/// ```
class LocalStorageModule extends Module {
  /// Base URL to get the package info (web only).
  ///
  /// See [PackageInfo.fromPlatform] for more information.
  static String? baseUrl;

  /// Path to store data in when running in debug mode (non-web).
  static String debugPath = './build/debug';

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<Future<PackageInfo>>(() => PackageInfo.fromPlatform(baseUrl: baseUrl));

    if (PlatformUtils.isDesktop || PlatformUtils.isMobile) {
      i.add<PathResolverService>(
        kDebugMode
            ? () => DebugPathResolverService(debugPath)
            : Platform.isLinux
                ? LinuxPathResolverService.new
                : DefaultPathResolverService.new,
      );
    }

    if (kIsWeb) {
      i.add<CookieService>(WebCookieService.new);
    }

    i.add<LocalStorageDatasource>(kIsWeb ? WebLocalStorageDatasource.new : DefaultLocalStorageDatasource.new);
  }
}
