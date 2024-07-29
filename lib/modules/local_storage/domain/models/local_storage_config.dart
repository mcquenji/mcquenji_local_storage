import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

part 'local_storage_config.freezed.dart';

/// Configuration for a type [T] for serialization and deserialization to local storage.
@freezed
class LocalStorageConfig<T> with _$LocalStorageConfig implements IGenericSerializer<T, JSON> {
  /// Configuration for a type [T] for serialization and deserialization to local storage.
  const factory LocalStorageConfig({
    /// The name of the file to store the data in.
    required String filename,

    /// The default value to return if the data is not found in the local storage.
    T? defaultValue,

    /// The function to deserialize the data from JSON.
    required T Function(JSON) fromJson,

    /// The function to serialize the data to JSON.
    required JSON Function(T) toJson,
  }) = _LocalStorageConfig;

  const LocalStorageConfig._();

  @override
  T deserialize(JSON data) => fromJson(data);

  @override
  JSON serialize(T data) => toJson(data);
}
