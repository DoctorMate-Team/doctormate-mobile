// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SecurityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() changePasswordLoading,
    required TResult Function() changePasswordSuccess,
    required TResult Function(String message) changePasswordError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? changePasswordLoading,
    TResult? Function()? changePasswordSuccess,
    TResult? Function(String message)? changePasswordError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? changePasswordLoading,
    TResult Function()? changePasswordSuccess,
    TResult Function(String message)? changePasswordError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ChangePasswordLoading value)
    changePasswordLoading,
    required TResult Function(ChangePasswordSuccess value)
    changePasswordSuccess,
    required TResult Function(ChangePasswordError value) changePasswordError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult? Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult? Function(ChangePasswordError value)? changePasswordError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult Function(ChangePasswordError value)? changePasswordError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityStateCopyWith<$Res> {
  factory $SecurityStateCopyWith(
    SecurityState value,
    $Res Function(SecurityState) then,
  ) = _$SecurityStateCopyWithImpl<$Res, SecurityState>;
}

/// @nodoc
class _$SecurityStateCopyWithImpl<$Res, $Val extends SecurityState>
    implements $SecurityStateCopyWith<$Res> {
  _$SecurityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityState
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
    extends _$SecurityStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SecurityState.initial()';
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
    required TResult Function() changePasswordLoading,
    required TResult Function() changePasswordSuccess,
    required TResult Function(String message) changePasswordError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? changePasswordLoading,
    TResult? Function()? changePasswordSuccess,
    TResult? Function(String message)? changePasswordError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? changePasswordLoading,
    TResult Function()? changePasswordSuccess,
    TResult Function(String message)? changePasswordError,
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
    required TResult Function(ChangePasswordLoading value)
    changePasswordLoading,
    required TResult Function(ChangePasswordSuccess value)
    changePasswordSuccess,
    required TResult Function(ChangePasswordError value) changePasswordError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult? Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult? Function(ChangePasswordError value)? changePasswordError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult Function(ChangePasswordError value)? changePasswordError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SecurityState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$ChangePasswordLoadingImplCopyWith<$Res> {
  factory _$$ChangePasswordLoadingImplCopyWith(
    _$ChangePasswordLoadingImpl value,
    $Res Function(_$ChangePasswordLoadingImpl) then,
  ) = __$$ChangePasswordLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChangePasswordLoadingImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$ChangePasswordLoadingImpl>
    implements _$$ChangePasswordLoadingImplCopyWith<$Res> {
  __$$ChangePasswordLoadingImplCopyWithImpl(
    _$ChangePasswordLoadingImpl _value,
    $Res Function(_$ChangePasswordLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChangePasswordLoadingImpl implements ChangePasswordLoading {
  const _$ChangePasswordLoadingImpl();

  @override
  String toString() {
    return 'SecurityState.changePasswordLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() changePasswordLoading,
    required TResult Function() changePasswordSuccess,
    required TResult Function(String message) changePasswordError,
  }) {
    return changePasswordLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? changePasswordLoading,
    TResult? Function()? changePasswordSuccess,
    TResult? Function(String message)? changePasswordError,
  }) {
    return changePasswordLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? changePasswordLoading,
    TResult Function()? changePasswordSuccess,
    TResult Function(String message)? changePasswordError,
    required TResult orElse(),
  }) {
    if (changePasswordLoading != null) {
      return changePasswordLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ChangePasswordLoading value)
    changePasswordLoading,
    required TResult Function(ChangePasswordSuccess value)
    changePasswordSuccess,
    required TResult Function(ChangePasswordError value) changePasswordError,
  }) {
    return changePasswordLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult? Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult? Function(ChangePasswordError value)? changePasswordError,
  }) {
    return changePasswordLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult Function(ChangePasswordError value)? changePasswordError,
    required TResult orElse(),
  }) {
    if (changePasswordLoading != null) {
      return changePasswordLoading(this);
    }
    return orElse();
  }
}

abstract class ChangePasswordLoading implements SecurityState {
  const factory ChangePasswordLoading() = _$ChangePasswordLoadingImpl;
}

/// @nodoc
abstract class _$$ChangePasswordSuccessImplCopyWith<$Res> {
  factory _$$ChangePasswordSuccessImplCopyWith(
    _$ChangePasswordSuccessImpl value,
    $Res Function(_$ChangePasswordSuccessImpl) then,
  ) = __$$ChangePasswordSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChangePasswordSuccessImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$ChangePasswordSuccessImpl>
    implements _$$ChangePasswordSuccessImplCopyWith<$Res> {
  __$$ChangePasswordSuccessImplCopyWithImpl(
    _$ChangePasswordSuccessImpl _value,
    $Res Function(_$ChangePasswordSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChangePasswordSuccessImpl implements ChangePasswordSuccess {
  const _$ChangePasswordSuccessImpl();

  @override
  String toString() {
    return 'SecurityState.changePasswordSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() changePasswordLoading,
    required TResult Function() changePasswordSuccess,
    required TResult Function(String message) changePasswordError,
  }) {
    return changePasswordSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? changePasswordLoading,
    TResult? Function()? changePasswordSuccess,
    TResult? Function(String message)? changePasswordError,
  }) {
    return changePasswordSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? changePasswordLoading,
    TResult Function()? changePasswordSuccess,
    TResult Function(String message)? changePasswordError,
    required TResult orElse(),
  }) {
    if (changePasswordSuccess != null) {
      return changePasswordSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ChangePasswordLoading value)
    changePasswordLoading,
    required TResult Function(ChangePasswordSuccess value)
    changePasswordSuccess,
    required TResult Function(ChangePasswordError value) changePasswordError,
  }) {
    return changePasswordSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult? Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult? Function(ChangePasswordError value)? changePasswordError,
  }) {
    return changePasswordSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult Function(ChangePasswordError value)? changePasswordError,
    required TResult orElse(),
  }) {
    if (changePasswordSuccess != null) {
      return changePasswordSuccess(this);
    }
    return orElse();
  }
}

abstract class ChangePasswordSuccess implements SecurityState {
  const factory ChangePasswordSuccess() = _$ChangePasswordSuccessImpl;
}

/// @nodoc
abstract class _$$ChangePasswordErrorImplCopyWith<$Res> {
  factory _$$ChangePasswordErrorImplCopyWith(
    _$ChangePasswordErrorImpl value,
    $Res Function(_$ChangePasswordErrorImpl) then,
  ) = __$$ChangePasswordErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChangePasswordErrorImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$ChangePasswordErrorImpl>
    implements _$$ChangePasswordErrorImplCopyWith<$Res> {
  __$$ChangePasswordErrorImplCopyWithImpl(
    _$ChangePasswordErrorImpl _value,
    $Res Function(_$ChangePasswordErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ChangePasswordErrorImpl(
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

class _$ChangePasswordErrorImpl implements ChangePasswordError {
  const _$ChangePasswordErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SecurityState.changePasswordError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordErrorImplCopyWith<_$ChangePasswordErrorImpl> get copyWith =>
      __$$ChangePasswordErrorImplCopyWithImpl<_$ChangePasswordErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() changePasswordLoading,
    required TResult Function() changePasswordSuccess,
    required TResult Function(String message) changePasswordError,
  }) {
    return changePasswordError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? changePasswordLoading,
    TResult? Function()? changePasswordSuccess,
    TResult? Function(String message)? changePasswordError,
  }) {
    return changePasswordError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? changePasswordLoading,
    TResult Function()? changePasswordSuccess,
    TResult Function(String message)? changePasswordError,
    required TResult orElse(),
  }) {
    if (changePasswordError != null) {
      return changePasswordError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ChangePasswordLoading value)
    changePasswordLoading,
    required TResult Function(ChangePasswordSuccess value)
    changePasswordSuccess,
    required TResult Function(ChangePasswordError value) changePasswordError,
  }) {
    return changePasswordError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult? Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult? Function(ChangePasswordError value)? changePasswordError,
  }) {
    return changePasswordError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ChangePasswordLoading value)? changePasswordLoading,
    TResult Function(ChangePasswordSuccess value)? changePasswordSuccess,
    TResult Function(ChangePasswordError value)? changePasswordError,
    required TResult orElse(),
  }) {
    if (changePasswordError != null) {
      return changePasswordError(this);
    }
    return orElse();
  }
}

abstract class ChangePasswordError implements SecurityState {
  const factory ChangePasswordError({required final String message}) =
      _$ChangePasswordErrorImpl;

  String get message;

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordErrorImplCopyWith<_$ChangePasswordErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
