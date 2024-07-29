import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Extension to add a serializer to the injector.
extension InjectorUtils on Injector {
  /// Registers an implementation of [IGenericSerializer] for type [T].
  void addSerde<T>({required T Function(JSON) fromJson, required JSON Function(T) toJson}) {
    addLazySingleton<IGenericSerializer<T, JSON>>(
      (i) => _IGenericSerializerImpl<T>(fromJson, toJson),
    );
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
