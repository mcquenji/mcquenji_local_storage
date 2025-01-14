import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

/// Extension to add a serializer to the injector.
extension InjectorUtils on Injector {
  /// Registers an implementation of [LocalStorageSerializer] for type [T].
  ///
  /// This will also add collection serializers for [T] if [T] is not an [Iterable] or [Map].
  ///
  /// If [registerCollections] is `true` (default), this will also register serializers for [Iterable], [List], and [Set] of [T].
  void addSerde<T>({required T Function(JSON) fromJson, required JSON Function(T) toJson, bool registerCollections = true}) {
    addInstance<LocalStorageSerializer<T>>(
      _SerdeImpl<T>(fromJson, toJson),
    );

    if (!registerCollections) return;

    addIterableSerde<T>();
    addListSerde<T>();
    addSetSerde<T>();
  }

  /// Registers an implementation of [LocalStorageSerializer] for a [Map] with of [K] and [V].
  void addMapSerde<K, V>() {
    addSerde(
      fromJson: (json) {
        final keySerde = Modular.get<LocalStorageSerializer<K>>();
        final valueSerde = Modular.get<LocalStorageSerializer<V>>();

        return json.map(
          (key, value) => MapEntry(
            keySerde.deserialize(jsonDecode(key.replaceAll("'", '"'))),
            valueSerde.deserialize(value),
          ),
        );
      },
      toJson: (map) {
        final keySerde = Modular.get<LocalStorageSerializer<K>>();
        final valueSerde = Modular.get<LocalStorageSerializer<V>>();

        return map.map(
          (key, value) => MapEntry(
            jsonEncode(keySerde.serialize(key)).replaceAll('"', "'"),
            valueSerde.serialize(value),
          ),
        );
      },
      registerCollections: false,
    );
  }

  /// Registers an implementation of [LocalStorageSerializer] for a collection of [T].
  ///
  /// The [converter] function is used to convert the [Iterable] of [T] to the desired collection [C].
  ///
  /// See [addIterableSerde], [addListSerde], [addSetSerde].
  void addCollectionSerde<T, C extends Iterable<T>>(C Function(Iterable<T> it) converter) {
    addSerde<C>(
      fromJson: (json) {
        final serde = Modular.get<LocalStorageSerializer<T>>();

        final it = json[C.toString()] as Iterable;

        // Idk why, but if I make this a lambda i get
        // 'The argument type 'T Function(Map<String, dynamic>)' can't be assigned to the parameter type 'dynamic Function(dynamic)'
        // ignore: unnecessary_lambdas
        return converter(it.map((e) => serde.deserialize(e)));
      },
      toJson: (iterable) {
        final serde = Modular.get<LocalStorageSerializer<T>>();

        return {C.toString(): iterable.map(serde.serialize).toList()};
      },
      registerCollections: false,
    );
  }

  /// Registers an implementation of [LocalStorageSerializer] for an [Iterable] of [T].
  void addIterableSerde<T>() => addCollectionSerde<T, Iterable<T>>((it) => it);

  /// Registers an implementation of [LocalStorageSerializer] for a [List] of [T].
  void addListSerde<T>() => addCollectionSerde<T, List<T>>((it) => it.toList());

  /// Registers an implementation of [LocalStorageSerializer] for a [Set] of [T].
  void addSetSerde<T>() => addCollectionSerde<T, Set<T>>((it) => it.toSet());

  /// Registers an implementation of [LocalStorageSerializer] for an [Enum] of type [T].
  ///
  /// Example:
  /// ```dart
  /// enum MyEnum { a, b, c }
  ///
  /// i.addEnumSerde<MyEnum>(MyEnum.values);
  /// ```
  void addEnumSerde<T extends Enum>(List<T> values) {
    addSerde(
      fromJson: (json) {
        final index = json[T.toString()] as int;

        if (index < 0 || index >= values.length) {
          throw LocalStorageException('Error parsing $T: Invalid index for enum $T: $index');
        }

        return values[index];
      },
      toJson: (e) => {T.toString(): e.index},
    );
  }
}

class _SerdeImpl<T> extends LocalStorageSerializer<T> {
  final T Function(JSON) _fromJson;
  final JSON Function(T) _toJson;

  const _SerdeImpl(this._fromJson, this._toJson);

  @override
  T deserialize(JSON data) => _fromJson(data);

  @override
  JSON serialize(T data) => _toJson(data);
}
