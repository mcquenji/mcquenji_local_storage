import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';
import 'package:universal_html/html.dart' as html;

/// [CookieService] implementation for the web.
class WebCookieService extends CookieService {
  @override
  void dispose() {}

  @override
  void deleteAllCookies() {
    log('Deleting all cookies');
    try {
      final cookies = html.document.cookie?.split('; ') ?? [];
      for (final cookie in cookies) {
        final key = cookie.split('=').first;
        deleteCookie(key);
      }
    } catch (error, stackTrace) {
      log('Error deleting all cookies', error, stackTrace);
    }
  }

  @override
  void deleteCookie(String key) {
    log('Deleting cookie: $key');
    try {
      setCookie(key, '', expires: -1);
    } catch (error, stackTrace) {
      log('Error deleting cookie: $key', error, stackTrace);
    }
  }

  @override
  bool exists(String key) {
    log('Checking existence of cookie: $key');
    try {
      return getCookie(key) != null;
    } catch (error, stackTrace) {
      log('Error checking existence of cookie: $key', error, stackTrace);
      return false;
    }
  }

  @override
  String? getCookie(String key) {
    log('Getting cookie: $key');
    try {
      final cookies = html.document.cookie?.split('; ') ?? [];
      for (final cookie in cookies) {
        final parts = cookie.split('=');
        if (parts[0] == key) {
          return parts[1];
        }
      }
      return null;
    } catch (error, stackTrace) {
      log('Error getting cookie: $key', error, stackTrace);
      return null;
    }
  }

  @override
  void setCookie(String key, String value, {int? expires, String? path, String? domain, bool? secure, bool? httpOnly}) {
    log('Setting cookie: $key=$value');
    try {
      final buffer = StringBuffer()..write('$key=$value');

      if (expires != null) {
        final expiryDate = DateTime.now().add(Duration(days: expires));
        buffer.write('; expires=${expiryDate.toUtc().toIso8601String()}');
      }

      if (path != null) {
        buffer.write('; path=$path');
      } else {
        buffer.write('; path=/');
      }

      if (domain != null) {
        buffer.write('; domain=$domain');
      }

      if (secure == true) {
        buffer.write('; secure');
      }

      if (httpOnly == true) {
        buffer.write('; HttpOnly');
      }

      html.document.cookie = buffer.toString();
    } catch (error, stackTrace) {
      log('Error setting cookie: $key=$value', error, stackTrace);
    }
  }
}
