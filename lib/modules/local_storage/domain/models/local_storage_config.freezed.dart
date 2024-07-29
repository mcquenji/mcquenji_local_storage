// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_storage_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalStorageConfig<T> {
  /// The name of the file to store the data in.
  String get filename => throw _privateConstructorUsedError;

  /// The default value to return if the data is not found in the local storage.
  T? get defaultValue => throw _privateConstructorUsedError;

  /// The function to deserialize the data from JSON.
  T Function(Map<String, dynamic>) get fromJson =>
      throw _privateConstructorUsedError;

  /// The function to serialize the data to JSON.
  Map<String, dynamic> Function(T) get toJson =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalStorageConfigCopyWith<T, LocalStorageConfig<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalStorageConfigCopyWith<T, $Res> {
  factory $LocalStorageConfigCopyWith(LocalStorageConfig<T> value,
          $Res Function(LocalStorageConfig<T>) then) =
      _$LocalStorageConfigCopyWithImpl<T, $Res, LocalStorageConfig<T>>;
  @useResult
  $Res call(
      {String filename,
      T? defaultValue,
      T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic> Function(T) toJson});
}

/// @nodoc
class _$LocalStorageConfigCopyWithImpl<T, $Res,
        $Val extends LocalStorageConfig<T>>
    implements $LocalStorageConfigCopyWith<T, $Res> {
  _$LocalStorageConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? defaultValue = freezed,
    Object? fromJson = null,
    Object? toJson = null,
  }) {
    return _then(_value.copyWith(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as T?,
      fromJson: null == fromJson
          ? _value.fromJson
          : fromJson // ignore: cast_nullable_to_non_nullable
              as T Function(Map<String, dynamic>),
      toJson: null == toJson
          ? _value.toJson
          : toJson // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic> Function(T),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalStorageConfigImplCopyWith<T, $Res>
    implements $LocalStorageConfigCopyWith<T, $Res> {
  factory _$$LocalStorageConfigImplCopyWith(_$LocalStorageConfigImpl<T> value,
          $Res Function(_$LocalStorageConfigImpl<T>) then) =
      __$$LocalStorageConfigImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String filename,
      T? defaultValue,
      T Function(Map<String, dynamic>) fromJson,
      Map<String, dynamic> Function(T) toJson});
}

/// @nodoc
class __$$LocalStorageConfigImplCopyWithImpl<T, $Res>
    extends _$LocalStorageConfigCopyWithImpl<T, $Res,
        _$LocalStorageConfigImpl<T>>
    implements _$$LocalStorageConfigImplCopyWith<T, $Res> {
  __$$LocalStorageConfigImplCopyWithImpl(_$LocalStorageConfigImpl<T> _value,
      $Res Function(_$LocalStorageConfigImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? defaultValue = freezed,
    Object? fromJson = null,
    Object? toJson = null,
  }) {
    return _then(_$LocalStorageConfigImpl<T>(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      defaultValue: freezed == defaultValue
          ? _value.defaultValue
          : defaultValue // ignore: cast_nullable_to_non_nullable
              as T?,
      fromJson: null == fromJson
          ? _value.fromJson
          : fromJson // ignore: cast_nullable_to_non_nullable
              as T Function(Map<String, dynamic>),
      toJson: null == toJson
          ? _value.toJson
          : toJson // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic> Function(T),
    ));
  }
}

/// @nodoc

class _$LocalStorageConfigImpl<T> extends _LocalStorageConfig<T> {
  const _$LocalStorageConfigImpl(
      {required this.filename,
      this.defaultValue,
      required this.fromJson,
      required this.toJson})
      : super._();

  /// The name of the file to store the data in.
  @override
  final String filename;

  /// The default value to return if the data is not found in the local storage.
  @override
  final T? defaultValue;

  /// The function to deserialize the data from JSON.
  @override
  final T Function(Map<String, dynamic>) fromJson;

  /// The function to serialize the data to JSON.
  @override
  final Map<String, dynamic> Function(T) toJson;

  @override
  String toString() {
    return 'LocalStorageConfig<$T>(filename: $filename, defaultValue: $defaultValue, fromJson: $fromJson, toJson: $toJson)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalStorageConfigImpl<T> &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality()
                .equals(other.defaultValue, defaultValue) &&
            (identical(other.fromJson, fromJson) ||
                other.fromJson == fromJson) &&
            (identical(other.toJson, toJson) || other.toJson == toJson));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filename,
      const DeepCollectionEquality().hash(defaultValue), fromJson, toJson);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalStorageConfigImplCopyWith<T, _$LocalStorageConfigImpl<T>>
      get copyWith => __$$LocalStorageConfigImplCopyWithImpl<T,
          _$LocalStorageConfigImpl<T>>(this, _$identity);
}

abstract class _LocalStorageConfig<T> extends LocalStorageConfig<T> {
  const factory _LocalStorageConfig(
          {required final String filename,
          final T? defaultValue,
          required final T Function(Map<String, dynamic>) fromJson,
          required final Map<String, dynamic> Function(T) toJson}) =
      _$LocalStorageConfigImpl<T>;
  const _LocalStorageConfig._() : super._();

  @override

  /// The name of the file to store the data in.
  String get filename;
  @override

  /// The default value to return if the data is not found in the local storage.
  T? get defaultValue;
  @override

  /// The function to deserialize the data from JSON.
  T Function(Map<String, dynamic>) get fromJson;
  @override

  /// The function to serialize the data to JSON.
  Map<String, dynamic> Function(T) get toJson;
  @override
  @JsonKey(ignore: true)
  _$$LocalStorageConfigImplCopyWith<T, _$LocalStorageConfigImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
