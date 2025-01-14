import 'dart:io';

import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

/// [PathResolverService] implementation for debug mode.
class DebugPathResolverService extends PathResolverService {
  /// Path to the debug directory.
  final String path;

  /// [PathResolverService] implementation for debug mode.
  DebugPathResolverService(this.path);

  @override
  Future<Directory> resolveAppDataDir() async {
    return Directory(path);
  }

  @override
  Future<Directory> resolveTempDir() async {
    return Directory('$path/.temp');
  }
}
