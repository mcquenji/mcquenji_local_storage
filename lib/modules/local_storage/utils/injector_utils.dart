import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'package:mcquenji_local_storage/modules/local_storage/domain/domain.dart';
import 'package:mcquenji_local_storage/modules/local_storage/infra/infra.dart';

/// Extension to add a serializer to the injector.
extension InjectorUtils on Injector {
  /// Registers an implementation of [IGenericSerializer] for type [T].
  ///
  /// This will also add collection serializers for [T] if [T] is not an [Iterable] or [Map].
  void addSerde<T>({required T Function(JSON) fromJson, required JSON Function(T) toJson, bool registerCollections = true}) {
    addLazySingleton<IGenericSerializer<T, JSON>>(
      (i) => _IGenericSerializerImpl<T>(fromJson, toJson),
    );

    if (!registerCollections) return;

    addIterableSerde<T>();
    addListSerde<T>();
    addSetSerde<T>();
  }

  /// Registers an implementation of [IGenericSerializer] for a [Map] with of [K] and [V].
  void addMapSerde<K, V>() {
    addSerde(
      fromJson: (json) {
        final keySerde = Modular.get<IGenericSerializer<K, JSON>>();
        final valueSerde = Modular.get<IGenericSerializer<V, JSON>>();

        return json.map(
          (key, value) => MapEntry(
            keySerde.deserialize(jsonDecode(key.replaceAll("'", '"'))),
            valueSerde.deserialize(value),
          ),
        );
      },
      toJson: (map) {
        final keySerde = Modular.get<IGenericSerializer<K, JSON>>();
        final valueSerde = Modular.get<IGenericSerializer<V, JSON>>();

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

  /// Registers an implementation of [IGenericSerializer] for a collection of [T].
  ///
  /// The [converter] function is used to convert the [Iterable] of [T] to the desired collection [C].
  ///
  /// See [addIterableSerde], [addListSerde], [addSetSerde].
  void addCollectionSerde<T, C extends Iterable<T>>(C Function(Iterable<T> it) converter) {
    addSerde<C>(
      fromJson: (json) {
        final serde = Modular.get<IGenericSerializer<T, JSON>>();

        final it = json[C.toString()] as Iterable;

        // Idk why, but if I make this a lambda i get
        // 'The argument type 'T Function(Map<String, dynamic>)' can't be assigned to the parameter type 'dynamic Function(dynamic)'
        // ignore: unnecessary_lambdas
        return converter(it.map((e) => serde.deserialize(e)));
      },
      toJson: (iterable) {
        final serde = Modular.get<IGenericSerializer<T, JSON>>();

        return {C.toString(): iterable.map(serde.serialize).toList()};
      },
      registerCollections: false,
    );
  }

  /// Registers an implementation of [IGenericSerializer] for an [Iterable] of [T].
  ///
  /// This is a shorthand for [addCollectionSerde] with [Iterable] as the collection type.
  void addIterableSerde<T>() => addCollectionSerde<T, Iterable<T>>((it) => it);

  /// Registers an implementation of [IGenericSerializer] for a [List] of [T].
  ///
  /// This is a shorthand for [addCollectionSerde] with [List] as the collection type.
  void addListSerde<T>() => addCollectionSerde<T, List<T>>((it) => it.toList());

  /// Registers an implementation of [IGenericSerializer] for a [Set] of [T].
  ///
  /// This is a shorthand for [addCollectionSerde] with [Set] as the collection type.
  void addSetSerde<T>() => addCollectionSerde<T, Set<T>>((it) => it.toSet());

  /// Registers an implementation of [IGenericSerializer] for an [Enum] of type [T].
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
          throw LocalStorageException('Invalid index for enum $T: $index');
        }

        return values[index];
      },
      toJson: (e) => {T.toString(): e.index},
    );
  }

  /// Sets up the local storage module by injecting an [LocalStorageDatasource] implementation.
  ///
  /// You must call this manually in your module, otherwise this module will not work.
  void setupLocalStorage() {
    add<LocalStorageDatasource>(kIsWeb ? WebLocalStorageDatasource.new : DefaultLocalStorageDatasource.new);
  }
}

class _IGenericSerializerImpl<T> implements IGenericSerializer<T, JSON> {
  final T Function(JSON) fromJson;
  final JSON Function(T) toJson;

  _IGenericSerializerImpl(this.fromJson, this.toJson);

  @override
  T deserialize(JSON data) => fromJson(data);

  @override
  JSON serialize(T data) => toJson(data);
}
