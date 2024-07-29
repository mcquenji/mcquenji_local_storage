import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

/// [PathResolverService] implementation for Windows.
class DefaultPathResolverService extends PathResolverService {
  final Future<PackageInfo> _packageInfo;

  /// [PathResolverService] implementation for Windows.
  DefaultPathResolverService(this._packageInfo);

  @override
  void dispose() {}

  @override
  Future<Directory> resolveAppDataDir() async {
    final info = await _packageInfo;
    final dir = await getApplicationDocumentsDirectory();

    return Directory('${dir.path}/${info.appName}');
  }

  @override
  Future<Directory> resolveTempDir() async {
    final info = await _packageInfo;
    final dir = await getApplicationCacheDirectory();

    return Directory('${dir.path}/${info.appName}');
  }
}
