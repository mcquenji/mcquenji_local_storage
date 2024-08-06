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

/// {@template local_storage_module}
/// Provides local storage access in a modular way.
///
/// You need to provide an [LocalStorageSerializer] instance for the type you want to store
/// by calling [InjectorUtils.addSerde].
///
/// Example:
/// ```dart
/// @override
/// void binds(Injector i) {
///    // This is required to store MyModel instances.
///    i.addSerde<MyModel>(
///      fromJson: MyModel.fromJson,
///      toJson: (m) => m.toJson(),
///    );
/// }
/// ```
/// {@endtemplate}
class LocalStorageModule extends Module {
  /// {@macro local_storage_module}
  LocalStorageModule();

  /// Base URL to get the package info (web only).
  ///
  /// See [PackageInfo.fromPlatform] for more information.
  static String? baseUrl;

  /// Overrides the path resolver service for testing or debug purposes.
  static String? overridePath = kDebugMode ? './build/debug' : null;

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<Future<PackageInfo>>(() => PackageInfo.fromPlatform(baseUrl: baseUrl));

    if (PlatformUtils.isDesktop || PlatformUtils.isMobile) {
      i.add<PathResolverService>(
        overridePath != null
            ? () => DebugPathResolverService(overridePath!)
            : Platform.isLinux
                ? LinuxPathResolverService.new
                : DefaultPathResolverService.new,
      );
    }

    i.add<LocalStorageDatasource>(kIsWeb ? WebLocalStorageDatasource.new : DefaultLocalStorageDatasource.new);

    if (kIsWeb) {
      i.add<CookieService>(WebCookieService.new);
    }

    // Add serializers for basic types
    i
      ..addSerde<int>(fromJson: (j) => j['int'], toJson: (i) => {'int': i})
      ..addSerde<double>(fromJson: (j) => j['double'], toJson: (d) => {'double': d})
      ..addSerde<String>(fromJson: (j) => j['string'], toJson: (s) => {'string': s})
      ..addSerde<bool>(fromJson: (j) => j['bool'], toJson: (b) => {'bool': b})
      ..addSerde<DateTime>(
        fromJson: (j) => DateTime.fromMillisecondsSinceEpoch(j['datetime']),
        toJson: (d) => {'datetime': d.millisecondsSinceEpoch},
      )
      ..addSerde<Duration>(
        fromJson: (j) => Duration(milliseconds: j['duration']),
        toJson: (d) => {'duration': d.inMilliseconds},
      )
      ..addSerde<Uri>(
        fromJson: (j) => Uri.parse(j['uri']),
        toJson: (u) => {'uri': u.toString()},
      );
  }
}

/// A serializer for local storage.
abstract class LocalStorageSerializer<T> extends IGenericSerializer<T, JSON> {
  /// A serializer for converting objects to and from JSON for local storage.
  const LocalStorageSerializer();
}
