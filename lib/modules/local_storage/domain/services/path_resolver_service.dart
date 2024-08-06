import 'package:flutter/foundation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:universal_io/io.dart';

/// Service responsible for resolving paths inside the application's local storage.
abstract class PathResolverService extends Service {
  @override
  String get name => 'PathResolver';

  /// Resolves a [file] inside the application's local storage directory.
  @nonVirtual
  Future<File> resolveFile(String file) async {
    final dir = await resolveAppDataDir();
    await dir.create(recursive: true);

    final path = '${dir.path}/$file';

    log('Resolved file path: $path');

    final f = File(path);
    await f.create();

    return f;
  }

  /// Resolves the application's local storage directory.
  @protected
  Future<Directory> resolveAppDataDir();

  /// Resolves the application's temporary directory.
  ///
  /// Used for downloading files, etc.
  @protected
  Future<Directory> resolveTempDir();

  /// Returns a new temporary file.
  @nonVirtual
  Future<File> newTempFile() async {
    final dir = await resolveTempDir();
    await dir.create(recursive: true);

    final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}';

    log('Resolved new temporary file: $path');

    final f = File(path);
    await f.create();

    return f;
  }
}
