import 'dart:io';

import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';
import 'package:mcquenji_local_storage/src/local_storage/domain/domain.dart';
import 'package:mcquenji_local_storage/src/local_storage/domain/services/path_resolver_service.dart';
import 'package:mcquenji_local_storage/src/local_storage/domain/services/services.dart';
import 'package:mcquenji_local_storage/src/local_storage/local_storage.dart';

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
