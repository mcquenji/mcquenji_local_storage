import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

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
    final serde = Modular.tryGet<IGenericSerializer<T, JSON>>();

    if (serde == null) {
      throw LocalStorageException('No serializer found for $T. Did you forget registering it?');
    }

    return serde;
  }

  /// Serializes the given [data] to [JSON].
  @protected
  @nonVirtual
  JSON serialize<T>(T data) {
    final serde = getSerde<T>();

    return serde.serialize(data);
  }

  /// Deserializes the given [json] to [T].
  @protected
  @nonVirtual
  T deserialize<T>(JSON json) {
    final serde = getSerde<T>();

    return serde.deserialize(json);
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
