// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ContactState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitContactLoading,
    required TResult Function() submitContactSuccess,
    required TResult Function(String message) submitContactError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitContactLoading,
    TResult? Function()? submitContactSuccess,
    TResult? Function(String message)? submitContactError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitContactLoading,
    TResult Function()? submitContactSuccess,
    TResult Function(String message)? submitContactError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SubmitContactLoading value) submitContactLoading,
    required TResult Function(SubmitContactSuccess value) submitContactSuccess,
    required TResult Function(SubmitContactError value) submitContactError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SubmitContactLoading value)? submitContactLoading,
    TResult? Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult? Function(SubmitContactError value)? submitContactError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SubmitContactLoading value)? submitContactLoading,
    TResult Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult Function(SubmitContactError value)? submitContactError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactStateCopyWith<$Res> {
  factory $ContactStateCopyWith(
    ContactState value,
    $Res Function(ContactState) then,
  ) = _$ContactStateCopyWithImpl<$Res, ContactState>;
}

/// @nodoc
class _$ContactStateCopyWithImpl<$Res, $Val extends ContactState>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ContactState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitContactLoading,
    required TResult Function() submitContactSuccess,
    required TResult Function(String message) submitContactError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitContactLoading,
    TResult? Function()? submitContactSuccess,
    TResult? Function(String message)? submitContactError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitContactLoading,
    TResult Function()? submitContactSuccess,
    TResult Function(String message)? submitContactError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SubmitContactLoading value) submitContactLoading,
    required TResult Function(SubmitContactSuccess value) submitContactSuccess,
    required TResult Function(SubmitContactError value) submitContactError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SubmitContactLoading value)? submitContactLoading,
    TResult? Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult? Function(SubmitContactError value)? submitContactError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SubmitContactLoading value)? submitContactLoading,
    TResult Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult Function(SubmitContactError value)? submitContactError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ContactState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SubmitContactLoadingImplCopyWith<$Res> {
  factory _$$SubmitContactLoadingImplCopyWith(
    _$SubmitContactLoadingImpl value,
    $Res Function(_$SubmitContactLoadingImpl) then,
  ) = __$$SubmitContactLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitContactLoadingImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$SubmitContactLoadingImpl>
    implements _$$SubmitContactLoadingImplCopyWith<$Res> {
  __$$SubmitContactLoadingImplCopyWithImpl(
    _$SubmitContactLoadingImpl _value,
    $Res Function(_$SubmitContactLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitContactLoadingImpl implements SubmitContactLoading {
  const _$SubmitContactLoadingImpl();

  @override
  String toString() {
    return 'ContactState.submitContactLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitContactLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitContactLoading,
    required TResult Function() submitContactSuccess,
    required TResult Function(String message) submitContactError,
  }) {
    return submitContactLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitContactLoading,
    TResult? Function()? submitContactSuccess,
    TResult? Function(String message)? submitContactError,
  }) {
    return submitContactLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitContactLoading,
    TResult Function()? submitContactSuccess,
    TResult Function(String message)? submitContactError,
    required TResult orElse(),
  }) {
    if (submitContactLoading != null) {
      return submitContactLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SubmitContactLoading value) submitContactLoading,
    required TResult Function(SubmitContactSuccess value) submitContactSuccess,
    required TResult Function(SubmitContactError value) submitContactError,
  }) {
    return submitContactLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SubmitContactLoading value)? submitContactLoading,
    TResult? Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult? Function(SubmitContactError value)? submitContactError,
  }) {
    return submitContactLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SubmitContactLoading value)? submitContactLoading,
    TResult Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult Function(SubmitContactError value)? submitContactError,
    required TResult orElse(),
  }) {
    if (submitContactLoading != null) {
      return submitContactLoading(this);
    }
    return orElse();
  }
}

abstract class SubmitContactLoading implements ContactState {
  const factory SubmitContactLoading() = _$SubmitContactLoadingImpl;
}

/// @nodoc
abstract class _$$SubmitContactSuccessImplCopyWith<$Res> {
  factory _$$SubmitContactSuccessImplCopyWith(
    _$SubmitContactSuccessImpl value,
    $Res Function(_$SubmitContactSuccessImpl) then,
  ) = __$$SubmitContactSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitContactSuccessImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$SubmitContactSuccessImpl>
    implements _$$SubmitContactSuccessImplCopyWith<$Res> {
  __$$SubmitContactSuccessImplCopyWithImpl(
    _$SubmitContactSuccessImpl _value,
    $Res Function(_$SubmitContactSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitContactSuccessImpl implements SubmitContactSuccess {
  const _$SubmitContactSuccessImpl();

  @override
  String toString() {
    return 'ContactState.submitContactSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitContactSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitContactLoading,
    required TResult Function() submitContactSuccess,
    required TResult Function(String message) submitContactError,
  }) {
    return submitContactSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitContactLoading,
    TResult? Function()? submitContactSuccess,
    TResult? Function(String message)? submitContactError,
  }) {
    return submitContactSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitContactLoading,
    TResult Function()? submitContactSuccess,
    TResult Function(String message)? submitContactError,
    required TResult orElse(),
  }) {
    if (submitContactSuccess != null) {
      return submitContactSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SubmitContactLoading value) submitContactLoading,
    required TResult Function(SubmitContactSuccess value) submitContactSuccess,
    required TResult Function(SubmitContactError value) submitContactError,
  }) {
    return submitContactSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SubmitContactLoading value)? submitContactLoading,
    TResult? Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult? Function(SubmitContactError value)? submitContactError,
  }) {
    return submitContactSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SubmitContactLoading value)? submitContactLoading,
    TResult Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult Function(SubmitContactError value)? submitContactError,
    required TResult orElse(),
  }) {
    if (submitContactSuccess != null) {
      return submitContactSuccess(this);
    }
    return orElse();
  }
}

abstract class SubmitContactSuccess implements ContactState {
  const factory SubmitContactSuccess() = _$SubmitContactSuccessImpl;
}

/// @nodoc
abstract class _$$SubmitContactErrorImplCopyWith<$Res> {
  factory _$$SubmitContactErrorImplCopyWith(
    _$SubmitContactErrorImpl value,
    $Res Function(_$SubmitContactErrorImpl) then,
  ) = __$$SubmitContactErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SubmitContactErrorImplCopyWithImpl<$Res>
    extends _$ContactStateCopyWithImpl<$Res, _$SubmitContactErrorImpl>
    implements _$$SubmitContactErrorImplCopyWith<$Res> {
  __$$SubmitContactErrorImplCopyWithImpl(
    _$SubmitContactErrorImpl _value,
    $Res Function(_$SubmitContactErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SubmitContactErrorImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SubmitContactErrorImpl implements SubmitContactError {
  const _$SubmitContactErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ContactState.submitContactError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitContactErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitContactErrorImplCopyWith<_$SubmitContactErrorImpl> get copyWith =>
      __$$SubmitContactErrorImplCopyWithImpl<_$SubmitContactErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitContactLoading,
    required TResult Function() submitContactSuccess,
    required TResult Function(String message) submitContactError,
  }) {
    return submitContactError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitContactLoading,
    TResult? Function()? submitContactSuccess,
    TResult? Function(String message)? submitContactError,
  }) {
    return submitContactError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitContactLoading,
    TResult Function()? submitContactSuccess,
    TResult Function(String message)? submitContactError,
    required TResult orElse(),
  }) {
    if (submitContactError != null) {
      return submitContactError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SubmitContactLoading value) submitContactLoading,
    required TResult Function(SubmitContactSuccess value) submitContactSuccess,
    required TResult Function(SubmitContactError value) submitContactError,
  }) {
    return submitContactError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SubmitContactLoading value)? submitContactLoading,
    TResult? Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult? Function(SubmitContactError value)? submitContactError,
  }) {
    return submitContactError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SubmitContactLoading value)? submitContactLoading,
    TResult Function(SubmitContactSuccess value)? submitContactSuccess,
    TResult Function(SubmitContactError value)? submitContactError,
    required TResult orElse(),
  }) {
    if (submitContactError != null) {
      return submitContactError(this);
    }
    return orElse();
  }
}

abstract class SubmitContactError implements ContactState {
  const factory SubmitContactError({required final String message}) =
      _$SubmitContactErrorImpl;

  String get message;

  /// Create a copy of ContactState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitContactErrorImplCopyWith<_$SubmitContactErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
