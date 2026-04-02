// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getDoctorDetailsLoading,
    required TResult Function(DoctorDetailsModel doctorDetails)
    getDoctorDetailsSuccess,
    required TResult Function(String message) getDoctorDetailsError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getDoctorDetailsLoading,
    TResult? Function(DoctorDetailsModel doctorDetails)?
    getDoctorDetailsSuccess,
    TResult? Function(String message)? getDoctorDetailsError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getDoctorDetailsLoading,
    TResult Function(DoctorDetailsModel doctorDetails)? getDoctorDetailsSuccess,
    TResult Function(String message)? getDoctorDetailsError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetDoctorDetailsLoading value)
    getDoctorDetailsLoading,
    required TResult Function(_GetDoctorDetailsSuccess value)
    getDoctorDetailsSuccess,
    required TResult Function(_GetDoctorDetailsError value)
    getDoctorDetailsError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult? Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult? Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailsStateCopyWith<$Res> {
  factory $DetailsStateCopyWith(
    DetailsState value,
    $Res Function(DetailsState) then,
  ) = _$DetailsStateCopyWithImpl<$Res, DetailsState>;
}

/// @nodoc
class _$DetailsStateCopyWithImpl<$Res, $Val extends DetailsState>
    implements $DetailsStateCopyWith<$Res> {
  _$DetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetailsState
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
    extends _$DetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'DetailsState.initial()';
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
    required TResult Function() getDoctorDetailsLoading,
    required TResult Function(DoctorDetailsModel doctorDetails)
    getDoctorDetailsSuccess,
    required TResult Function(String message) getDoctorDetailsError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getDoctorDetailsLoading,
    TResult? Function(DoctorDetailsModel doctorDetails)?
    getDoctorDetailsSuccess,
    TResult? Function(String message)? getDoctorDetailsError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getDoctorDetailsLoading,
    TResult Function(DoctorDetailsModel doctorDetails)? getDoctorDetailsSuccess,
    TResult Function(String message)? getDoctorDetailsError,
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
    required TResult Function(_GetDoctorDetailsLoading value)
    getDoctorDetailsLoading,
    required TResult Function(_GetDoctorDetailsSuccess value)
    getDoctorDetailsSuccess,
    required TResult Function(_GetDoctorDetailsError value)
    getDoctorDetailsError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult? Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult? Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements DetailsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$GetDoctorDetailsLoadingImplCopyWith<$Res> {
  factory _$$GetDoctorDetailsLoadingImplCopyWith(
    _$GetDoctorDetailsLoadingImpl value,
    $Res Function(_$GetDoctorDetailsLoadingImpl) then,
  ) = __$$GetDoctorDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetDoctorDetailsLoadingImplCopyWithImpl<$Res>
    extends _$DetailsStateCopyWithImpl<$Res, _$GetDoctorDetailsLoadingImpl>
    implements _$$GetDoctorDetailsLoadingImplCopyWith<$Res> {
  __$$GetDoctorDetailsLoadingImplCopyWithImpl(
    _$GetDoctorDetailsLoadingImpl _value,
    $Res Function(_$GetDoctorDetailsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetDoctorDetailsLoadingImpl implements _GetDoctorDetailsLoading {
  const _$GetDoctorDetailsLoadingImpl();

  @override
  String toString() {
    return 'DetailsState.getDoctorDetailsLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getDoctorDetailsLoading,
    required TResult Function(DoctorDetailsModel doctorDetails)
    getDoctorDetailsSuccess,
    required TResult Function(String message) getDoctorDetailsError,
  }) {
    return getDoctorDetailsLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getDoctorDetailsLoading,
    TResult? Function(DoctorDetailsModel doctorDetails)?
    getDoctorDetailsSuccess,
    TResult? Function(String message)? getDoctorDetailsError,
  }) {
    return getDoctorDetailsLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getDoctorDetailsLoading,
    TResult Function(DoctorDetailsModel doctorDetails)? getDoctorDetailsSuccess,
    TResult Function(String message)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (getDoctorDetailsLoading != null) {
      return getDoctorDetailsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetDoctorDetailsLoading value)
    getDoctorDetailsLoading,
    required TResult Function(_GetDoctorDetailsSuccess value)
    getDoctorDetailsSuccess,
    required TResult Function(_GetDoctorDetailsError value)
    getDoctorDetailsError,
  }) {
    return getDoctorDetailsLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult? Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult? Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
  }) {
    return getDoctorDetailsLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (getDoctorDetailsLoading != null) {
      return getDoctorDetailsLoading(this);
    }
    return orElse();
  }
}

abstract class _GetDoctorDetailsLoading implements DetailsState {
  const factory _GetDoctorDetailsLoading() = _$GetDoctorDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$GetDoctorDetailsSuccessImplCopyWith<$Res> {
  factory _$$GetDoctorDetailsSuccessImplCopyWith(
    _$GetDoctorDetailsSuccessImpl value,
    $Res Function(_$GetDoctorDetailsSuccessImpl) then,
  ) = __$$GetDoctorDetailsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DoctorDetailsModel doctorDetails});
}

/// @nodoc
class __$$GetDoctorDetailsSuccessImplCopyWithImpl<$Res>
    extends _$DetailsStateCopyWithImpl<$Res, _$GetDoctorDetailsSuccessImpl>
    implements _$$GetDoctorDetailsSuccessImplCopyWith<$Res> {
  __$$GetDoctorDetailsSuccessImplCopyWithImpl(
    _$GetDoctorDetailsSuccessImpl _value,
    $Res Function(_$GetDoctorDetailsSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? doctorDetails = null}) {
    return _then(
      _$GetDoctorDetailsSuccessImpl(
        doctorDetails:
            null == doctorDetails
                ? _value.doctorDetails
                : doctorDetails // ignore: cast_nullable_to_non_nullable
                    as DoctorDetailsModel,
      ),
    );
  }
}

/// @nodoc

class _$GetDoctorDetailsSuccessImpl implements _GetDoctorDetailsSuccess {
  const _$GetDoctorDetailsSuccessImpl({required this.doctorDetails});

  @override
  final DoctorDetailsModel doctorDetails;

  @override
  String toString() {
    return 'DetailsState.getDoctorDetailsSuccess(doctorDetails: $doctorDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorDetailsSuccessImpl &&
            (identical(other.doctorDetails, doctorDetails) ||
                other.doctorDetails == doctorDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doctorDetails);

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorDetailsSuccessImplCopyWith<_$GetDoctorDetailsSuccessImpl>
  get copyWith => __$$GetDoctorDetailsSuccessImplCopyWithImpl<
    _$GetDoctorDetailsSuccessImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getDoctorDetailsLoading,
    required TResult Function(DoctorDetailsModel doctorDetails)
    getDoctorDetailsSuccess,
    required TResult Function(String message) getDoctorDetailsError,
  }) {
    return getDoctorDetailsSuccess(doctorDetails);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getDoctorDetailsLoading,
    TResult? Function(DoctorDetailsModel doctorDetails)?
    getDoctorDetailsSuccess,
    TResult? Function(String message)? getDoctorDetailsError,
  }) {
    return getDoctorDetailsSuccess?.call(doctorDetails);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getDoctorDetailsLoading,
    TResult Function(DoctorDetailsModel doctorDetails)? getDoctorDetailsSuccess,
    TResult Function(String message)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (getDoctorDetailsSuccess != null) {
      return getDoctorDetailsSuccess(doctorDetails);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetDoctorDetailsLoading value)
    getDoctorDetailsLoading,
    required TResult Function(_GetDoctorDetailsSuccess value)
    getDoctorDetailsSuccess,
    required TResult Function(_GetDoctorDetailsError value)
    getDoctorDetailsError,
  }) {
    return getDoctorDetailsSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult? Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult? Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
  }) {
    return getDoctorDetailsSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (getDoctorDetailsSuccess != null) {
      return getDoctorDetailsSuccess(this);
    }
    return orElse();
  }
}

abstract class _GetDoctorDetailsSuccess implements DetailsState {
  const factory _GetDoctorDetailsSuccess({
    required final DoctorDetailsModel doctorDetails,
  }) = _$GetDoctorDetailsSuccessImpl;

  DoctorDetailsModel get doctorDetails;

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorDetailsSuccessImplCopyWith<_$GetDoctorDetailsSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetDoctorDetailsErrorImplCopyWith<$Res> {
  factory _$$GetDoctorDetailsErrorImplCopyWith(
    _$GetDoctorDetailsErrorImpl value,
    $Res Function(_$GetDoctorDetailsErrorImpl) then,
  ) = __$$GetDoctorDetailsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GetDoctorDetailsErrorImplCopyWithImpl<$Res>
    extends _$DetailsStateCopyWithImpl<$Res, _$GetDoctorDetailsErrorImpl>
    implements _$$GetDoctorDetailsErrorImplCopyWith<$Res> {
  __$$GetDoctorDetailsErrorImplCopyWithImpl(
    _$GetDoctorDetailsErrorImpl _value,
    $Res Function(_$GetDoctorDetailsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$GetDoctorDetailsErrorImpl(
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

class _$GetDoctorDetailsErrorImpl implements _GetDoctorDetailsError {
  const _$GetDoctorDetailsErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'DetailsState.getDoctorDetailsError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorDetailsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorDetailsErrorImplCopyWith<_$GetDoctorDetailsErrorImpl>
  get copyWith =>
      __$$GetDoctorDetailsErrorImplCopyWithImpl<_$GetDoctorDetailsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() getDoctorDetailsLoading,
    required TResult Function(DoctorDetailsModel doctorDetails)
    getDoctorDetailsSuccess,
    required TResult Function(String message) getDoctorDetailsError,
  }) {
    return getDoctorDetailsError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? getDoctorDetailsLoading,
    TResult? Function(DoctorDetailsModel doctorDetails)?
    getDoctorDetailsSuccess,
    TResult? Function(String message)? getDoctorDetailsError,
  }) {
    return getDoctorDetailsError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? getDoctorDetailsLoading,
    TResult Function(DoctorDetailsModel doctorDetails)? getDoctorDetailsSuccess,
    TResult Function(String message)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (getDoctorDetailsError != null) {
      return getDoctorDetailsError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GetDoctorDetailsLoading value)
    getDoctorDetailsLoading,
    required TResult Function(_GetDoctorDetailsSuccess value)
    getDoctorDetailsSuccess,
    required TResult Function(_GetDoctorDetailsError value)
    getDoctorDetailsError,
  }) {
    return getDoctorDetailsError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult? Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult? Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
  }) {
    return getDoctorDetailsError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GetDoctorDetailsLoading value)? getDoctorDetailsLoading,
    TResult Function(_GetDoctorDetailsSuccess value)? getDoctorDetailsSuccess,
    TResult Function(_GetDoctorDetailsError value)? getDoctorDetailsError,
    required TResult orElse(),
  }) {
    if (getDoctorDetailsError != null) {
      return getDoctorDetailsError(this);
    }
    return orElse();
  }
}

abstract class _GetDoctorDetailsError implements DetailsState {
  const factory _GetDoctorDetailsError({required final String message}) =
      _$GetDoctorDetailsErrorImpl;

  String get message;

  /// Create a copy of DetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorDetailsErrorImplCopyWith<_$GetDoctorDetailsErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
