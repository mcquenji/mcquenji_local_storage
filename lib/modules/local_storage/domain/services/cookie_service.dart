import 'package:mcquenji_core/mcquenji_core.dart';

/// Service to handle cookies.
abstract class CookieService extends Service {
  @override
  String get name => 'Cookie';

  /// Sets a cookie.
  void setCookie(String key, String value, {int? expires, String? path, String? domain, bool? secure, bool? httpOnly});

  /// Gets a cookie.
  String? getCookie(String key);

  /// Deletes a cookie.
  void deleteCookie(String key);

  /// Checks if a cookie exists.
  bool exists(String key);

  /// Deletes all cookies.
  void deleteAllCookies();
}
