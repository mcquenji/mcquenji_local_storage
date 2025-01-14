import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_io/io.dart';

/// [PathResolverService] implementation for Linux.
class LinuxPathResolverService extends PathResolverService {
  final Future<PackageInfo> _packageInfo;

  /// [PathResolverService] implementation for Linux.
  LinuxPathResolverService(this._packageInfo);

  @override
  Future<Directory> resolveAppDataDir() async {
    final info = await _packageInfo;

    final home = Platform.environment['HOME']!;

    return Directory('$home/.cache/${info.appName}');
  }

  @override
  Future<Directory> resolveTempDir() async {
    final info = await _packageInfo;

    return Directory('/tmp/${info.appName}');
  }
}
