import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/modules/local_storage/local_storage.dart';

/// A datasource that reads and writes data to the local storage.
abstract class LocalStorageDatasource extends Datasource {
  @override
  String get name => 'LocalStorage';

  /// Reads data of type [T] from the local storage.
  Future<T> read<T>();

  /// Writes the given [data] to the local storage.
  Future<void> write<T>(T data);

  /// Deletes the data of type [T] from the local storage.
  Future<void> delete<T>();

  /// Checks if data of type [T] exists in the local storage.
  Future<bool> exists<T>();

  /// Gets the [IGenericSerializer] for the type [T].
  @nonVirtual
  @protected
  IGenericSerializer<T, JSON> getSerde<T>() {
    try {
      return Modular.get<LocalStorageSerializer<T>>();
    } on Exception catch (e) {
      throw LocalStorageException('No serializer found for $T: $e. Did you forget registering it?');
    }
  }

  /// Serializes the given [data].
  ///
  /// The returned value is the [JSON] representation of [data] encoded to a base64 string.
  @protected
  @nonVirtual
  String serialize<T>(T data) {
    final serde = getSerde<T>();

    return base64Encode(
      jsonEncode(
        serde.serialize(
          data,
        ),
      ).codeUnits,
    );
  }

  /// Deserializes the given [data] to [T] where
  /// [data] is expected to be a base64 encoded string.
  @protected
  @nonVirtual
  T deserialize<T>(String data) {
    final serde = getSerde<T>();

    return serde.deserialize(
      jsonDecode(
        String.fromCharCodes(
          base64Decode(
            data,
          ),
        ),
      ),
    );
  }
}

/// Exception thrown when an error occurs while reading or writing to the local storage.
class LocalStorageException implements Exception {
  /// The error message.
  final String message;

  /// Exception thrown when an error occurs while reading or writing to the local storage.
  LocalStorageException(this.message);

  @override
  String toString() => 'LocalStorageException: $message';
}
