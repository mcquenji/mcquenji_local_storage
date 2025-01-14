import 'package:crypto/crypto.dart';

/// Helper class for consistent hashing of [Type]s.
extension HashUtils on Type {
  /// Returns a consistent hash code for this [Type].
  ///
  /// This takes the result of [toString] and hashes it using [sha256] and thus is consistent across platforms,
  /// however it is not guaranteed to be unique for types with the same name but different libraries.
  String get consistentHash => sha256.convert(toString().codeUnits).toString();
}
