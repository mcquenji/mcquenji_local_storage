import 'package:universal_io/io.dart';

/// Platform utilities.
extension PlatformUtils on Platform {
  /// `true` if the platform is desktop.
  static bool get isDesktop => Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  /// `true` if the platform is mobile.
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
}
