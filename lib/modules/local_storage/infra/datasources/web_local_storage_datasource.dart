import 'dart:convert';

import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';

/// [LocalStorageDatasource] implementation for web.
class WebLocalStorageDatasource extends LocalStorageDatasource {
  final CookieService _cookieService;

  /// [WebLocalStorageDatasource] implementation for web.
  WebLocalStorageDatasource(this._cookieService);

  @override
  void dispose() {
    _cookieService.dispose();
  }

  @override
  Future<void> delete<T>() async {
    _cookieService.deleteCookie(T.toString());

    log('Deleted $T');
  }

  @override
  Future<bool> exists<T>() async => _cookieService.exists(T.toString());

  @override
  Future<T> read<T>() async {
    final data = _cookieService.getCookie(T.toString());

    if (data == null) {
      final e = LocalStorageException('No data found for $T');

      log('Failed to read $T', e);

      throw e;
    }

    log('Read $T');

    return deserialize(jsonDecode(data));
  }

  @override
  Future<void> write<T>(T data) async {
    final encoded = jsonEncode(serialize(data));

    _cookieService.setCookie(T.toString(), encoded);

    log('Wrote $T');
  }
}
