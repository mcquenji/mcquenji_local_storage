import 'dart:convert';

import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';

/// Implementation of [LocalStorageDatasource] for all platforms except web.
class DefaultLocalStorageDatasource extends LocalStorageDatasource {
  final PathResolverService _pathResolverService;

  /// Implementation of [LocalStorageDatasource] for all platforms except web.
  DefaultLocalStorageDatasource(this._pathResolverService);

  @override
  void dispose() {
    _pathResolverService.dispose();
  }

  @override
  Future<void> delete<T>() async {
    log('Deleting $T');

    final f = await _pathResolverService.resolveFile(T.toString().sanitized);

    if (!await exists()) {
      log('$T does not exist at ${f.path}');

      return;
    }

    await f.delete();

    log('$T deleted at ${f.path}');
  }

  @override
  Future<T> read<T>() async {
    log('Reading $T');

    final f = await _pathResolverService.resolveFile(T.toString().sanitized);

    if (!await exists()) {
      final e = LocalStorageException('${f.path} does not exist or is empty. Cannot read data.');

      log('Failed to read $T', e);

      throw e;
    }

    try {
      final contents = await f.readAsString();

      final data = deserialize(jsonDecode(contents));

      log('Read $T');

      return data;
    } catch (e, s) {
      log('Failed to read $T at ${f.path}', e, s);

      throw LocalStorageException('Failed to read $T: $e');
    }
  }

  @override
  Future<void> write<T>(T data) async {
    log('Writing $T');

    final f = await _pathResolverService.resolveFile(T.toString().sanitized);

    try {
      final contents = jsonEncode(serialize(data));

      await f.writeAsString(contents);

      log('Wrote $T at ${f.path}');
    } catch (e, s) {
      log('Failed to write $T at ${f.path}', e, s);

      throw LocalStorageException('Failed to write $T: $e');
    }
  }

  @override
  Future<bool> exists<T>() async {
    final f = await _pathResolverService.resolveFile(T.toString());

    if (!f.existsSync()) return false;

    return f.readAsStringSync().trim().isNotEmpty;
  }
}
