import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:mcquenji_local_storage/src/local_storage/infra/infra.dart';

/// [LocalStorageDatasource] implementation for web.
///
/// Use [DefaultLocalStorageDatasource] for all other platforms.
class WebLocalStorageDatasource extends LocalStorageDatasource {
  final CookieService _cookieService;

  /// [WebLocalStorageDatasource] implementation for web.
  WebLocalStorageDatasource(this._cookieService);

  @override
  void dispose() {
    super.dispose();
    _cookieService.dispose();
  }

  @override
  Future<void> delete<T>() async {
    _cookieService.deleteCookie(T.consistentHash);

    log('Deleted $T');
  }

  @override
  Future<bool> exists<T>() async => _cookieService.exists(T.consistentHash);

  @override
  Future<T> read<T>() async {
    final data = _cookieService.getCookie(T.consistentHash);

    if (data == null) {
      final e = LocalStorageException('No data found for $T');

      log('Failed to read $T', e);

      throw e;
    }

    log('Read $T');

    return deserialize<T>(data);
  }

  @override
  Future<void> write<T>(T data) async {
    final encoded = serialize<T>(data);

    _cookieService.setCookie(T.consistentHash, encoded, expires: 30);

    log('Wrote $T');
  }
}
