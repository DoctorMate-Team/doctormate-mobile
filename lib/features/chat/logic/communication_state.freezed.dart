// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommunicationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunicationStateCopyWith<$Res> {
  factory $CommunicationStateCopyWith(
    CommunicationState value,
    $Res Function(CommunicationState) then,
  ) = _$CommunicationStateCopyWithImpl<$Res, CommunicationState>;
}

/// @nodoc
class _$CommunicationStateCopyWithImpl<$Res, $Val extends CommunicationState>
    implements $CommunicationStateCopyWith<$Res> {
  _$CommunicationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunicationState
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
    extends _$CommunicationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CommunicationState.initial()';
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
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
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
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CommunicationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$CheckingSessionImplCopyWith<$Res> {
  factory _$$CheckingSessionImplCopyWith(
    _$CheckingSessionImpl value,
    $Res Function(_$CheckingSessionImpl) then,
  ) = __$$CheckingSessionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckingSessionImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$CheckingSessionImpl>
    implements _$$CheckingSessionImplCopyWith<$Res> {
  __$$CheckingSessionImplCopyWithImpl(
    _$CheckingSessionImpl _value,
    $Res Function(_$CheckingSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckingSessionImpl implements CheckingSession {
  const _$CheckingSessionImpl();

  @override
  String toString() {
    return 'CommunicationState.checkingSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckingSessionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return checkingSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return checkingSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (checkingSession != null) {
      return checkingSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return checkingSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return checkingSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (checkingSession != null) {
      return checkingSession(this);
    }
    return orElse();
  }
}

abstract class CheckingSession implements CommunicationState {
  const factory CheckingSession() = _$CheckingSessionImpl;
}

/// @nodoc
abstract class _$$SessionActiveImplCopyWith<$Res> {
  factory _$$SessionActiveImplCopyWith(
    _$SessionActiveImpl value,
    $Res Function(_$SessionActiveImpl) then,
  ) = __$$SessionActiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId, String channelName, String sessionType});
}

/// @nodoc
class __$$SessionActiveImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$SessionActiveImpl>
    implements _$$SessionActiveImplCopyWith<$Res> {
  __$$SessionActiveImplCopyWithImpl(
    _$SessionActiveImpl _value,
    $Res Function(_$SessionActiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? channelName = null,
    Object? sessionType = null,
  }) {
    return _then(
      _$SessionActiveImpl(
        sessionId:
            null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                    as String,
        channelName:
            null == channelName
                ? _value.channelName
                : channelName // ignore: cast_nullable_to_non_nullable
                    as String,
        sessionType:
            null == sessionType
                ? _value.sessionType
                : sessionType // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SessionActiveImpl implements SessionActive {
  const _$SessionActiveImpl({
    required this.sessionId,
    required this.channelName,
    required this.sessionType,
  });

  @override
  final String sessionId;
  @override
  final String channelName;
  @override
  final String sessionType;

  @override
  String toString() {
    return 'CommunicationState.sessionActive(sessionId: $sessionId, channelName: $channelName, sessionType: $sessionType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionActiveImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, channelName, sessionType);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionActiveImplCopyWith<_$SessionActiveImpl> get copyWith =>
      __$$SessionActiveImplCopyWithImpl<_$SessionActiveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return sessionActive(sessionId, channelName, sessionType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return sessionActive?.call(sessionId, channelName, sessionType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (sessionActive != null) {
      return sessionActive(sessionId, channelName, sessionType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return sessionActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return sessionActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (sessionActive != null) {
      return sessionActive(this);
    }
    return orElse();
  }
}

abstract class SessionActive implements CommunicationState {
  const factory SessionActive({
    required final String sessionId,
    required final String channelName,
    required final String sessionType,
  }) = _$SessionActiveImpl;

  String get sessionId;
  String get channelName;
  String get sessionType;

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionActiveImplCopyWith<_$SessionActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionNotAvailableImplCopyWith<$Res> {
  factory _$$SessionNotAvailableImplCopyWith(
    _$SessionNotAvailableImpl value,
    $Res Function(_$SessionNotAvailableImpl) then,
  ) = __$$SessionNotAvailableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SessionNotAvailableImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$SessionNotAvailableImpl>
    implements _$$SessionNotAvailableImplCopyWith<$Res> {
  __$$SessionNotAvailableImplCopyWithImpl(
    _$SessionNotAvailableImpl _value,
    $Res Function(_$SessionNotAvailableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SessionNotAvailableImpl(
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

class _$SessionNotAvailableImpl implements SessionNotAvailable {
  const _$SessionNotAvailableImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CommunicationState.sessionNotAvailable(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionNotAvailableImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionNotAvailableImplCopyWith<_$SessionNotAvailableImpl> get copyWith =>
      __$$SessionNotAvailableImplCopyWithImpl<_$SessionNotAvailableImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return sessionNotAvailable(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return sessionNotAvailable?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (sessionNotAvailable != null) {
      return sessionNotAvailable(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return sessionNotAvailable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return sessionNotAvailable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (sessionNotAvailable != null) {
      return sessionNotAvailable(this);
    }
    return orElse();
  }
}

abstract class SessionNotAvailable implements CommunicationState {
  const factory SessionNotAvailable({required final String message}) =
      _$SessionNotAvailableImpl;

  String get message;

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionNotAvailableImplCopyWith<_$SessionNotAvailableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionCheckErrorImplCopyWith<$Res> {
  factory _$$SessionCheckErrorImplCopyWith(
    _$SessionCheckErrorImpl value,
    $Res Function(_$SessionCheckErrorImpl) then,
  ) = __$$SessionCheckErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$SessionCheckErrorImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$SessionCheckErrorImpl>
    implements _$$SessionCheckErrorImplCopyWith<$Res> {
  __$$SessionCheckErrorImplCopyWithImpl(
    _$SessionCheckErrorImpl _value,
    $Res Function(_$SessionCheckErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$SessionCheckErrorImpl(
        error:
            null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SessionCheckErrorImpl implements SessionCheckError {
  const _$SessionCheckErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'CommunicationState.sessionCheckError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionCheckErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionCheckErrorImplCopyWith<_$SessionCheckErrorImpl> get copyWith =>
      __$$SessionCheckErrorImplCopyWithImpl<_$SessionCheckErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return sessionCheckError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return sessionCheckError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (sessionCheckError != null) {
      return sessionCheckError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return sessionCheckError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return sessionCheckError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (sessionCheckError != null) {
      return sessionCheckError(this);
    }
    return orElse();
  }
}

abstract class SessionCheckError implements CommunicationState {
  const factory SessionCheckError({required final String error}) =
      _$SessionCheckErrorImpl;

  String get error;

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionCheckErrorImplCopyWith<_$SessionCheckErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GettingCallTokenImplCopyWith<$Res> {
  factory _$$GettingCallTokenImplCopyWith(
    _$GettingCallTokenImpl value,
    $Res Function(_$GettingCallTokenImpl) then,
  ) = __$$GettingCallTokenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GettingCallTokenImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$GettingCallTokenImpl>
    implements _$$GettingCallTokenImplCopyWith<$Res> {
  __$$GettingCallTokenImplCopyWithImpl(
    _$GettingCallTokenImpl _value,
    $Res Function(_$GettingCallTokenImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GettingCallTokenImpl implements GettingCallToken {
  const _$GettingCallTokenImpl();

  @override
  String toString() {
    return 'CommunicationState.gettingCallToken()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GettingCallTokenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return gettingCallToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return gettingCallToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (gettingCallToken != null) {
      return gettingCallToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return gettingCallToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return gettingCallToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (gettingCallToken != null) {
      return gettingCallToken(this);
    }
    return orElse();
  }
}

abstract class GettingCallToken implements CommunicationState {
  const factory GettingCallToken() = _$GettingCallTokenImpl;
}

/// @nodoc
abstract class _$$CallTokenRetrievedImplCopyWith<$Res> {
  factory _$$CallTokenRetrievedImplCopyWith(
    _$CallTokenRetrievedImpl value,
    $Res Function(_$CallTokenRetrievedImpl) then,
  ) = __$$CallTokenRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token, String channelName, int expiry, String callType});
}

/// @nodoc
class __$$CallTokenRetrievedImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$CallTokenRetrievedImpl>
    implements _$$CallTokenRetrievedImplCopyWith<$Res> {
  __$$CallTokenRetrievedImplCopyWithImpl(
    _$CallTokenRetrievedImpl _value,
    $Res Function(_$CallTokenRetrievedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? channelName = null,
    Object? expiry = null,
    Object? callType = null,
  }) {
    return _then(
      _$CallTokenRetrievedImpl(
        token:
            null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                    as String,
        channelName:
            null == channelName
                ? _value.channelName
                : channelName // ignore: cast_nullable_to_non_nullable
                    as String,
        expiry:
            null == expiry
                ? _value.expiry
                : expiry // ignore: cast_nullable_to_non_nullable
                    as int,
        callType:
            null == callType
                ? _value.callType
                : callType // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CallTokenRetrievedImpl implements CallTokenRetrieved {
  const _$CallTokenRetrievedImpl({
    required this.token,
    required this.channelName,
    required this.expiry,
    required this.callType,
  });

  @override
  final String token;
  @override
  final String channelName;
  @override
  final int expiry;
  @override
  final String callType;

  @override
  String toString() {
    return 'CommunicationState.callTokenRetrieved(token: $token, channelName: $channelName, expiry: $expiry, callType: $callType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallTokenRetrievedImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.callType, callType) ||
                other.callType == callType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, token, channelName, expiry, callType);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallTokenRetrievedImplCopyWith<_$CallTokenRetrievedImpl> get copyWith =>
      __$$CallTokenRetrievedImplCopyWithImpl<_$CallTokenRetrievedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return callTokenRetrieved(token, channelName, expiry, callType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return callTokenRetrieved?.call(token, channelName, expiry, callType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (callTokenRetrieved != null) {
      return callTokenRetrieved(token, channelName, expiry, callType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return callTokenRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return callTokenRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (callTokenRetrieved != null) {
      return callTokenRetrieved(this);
    }
    return orElse();
  }
}

abstract class CallTokenRetrieved implements CommunicationState {
  const factory CallTokenRetrieved({
    required final String token,
    required final String channelName,
    required final int expiry,
    required final String callType,
  }) = _$CallTokenRetrievedImpl;

  String get token;
  String get channelName;
  int get expiry;
  String get callType;

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallTokenRetrievedImplCopyWith<_$CallTokenRetrievedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallTokenErrorImplCopyWith<$Res> {
  factory _$$CallTokenErrorImplCopyWith(
    _$CallTokenErrorImpl value,
    $Res Function(_$CallTokenErrorImpl) then,
  ) = __$$CallTokenErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CallTokenErrorImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$CallTokenErrorImpl>
    implements _$$CallTokenErrorImplCopyWith<$Res> {
  __$$CallTokenErrorImplCopyWithImpl(
    _$CallTokenErrorImpl _value,
    $Res Function(_$CallTokenErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$CallTokenErrorImpl(
        error:
            null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$CallTokenErrorImpl implements CallTokenError {
  const _$CallTokenErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'CommunicationState.callTokenError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallTokenErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallTokenErrorImplCopyWith<_$CallTokenErrorImpl> get copyWith =>
      __$$CallTokenErrorImplCopyWithImpl<_$CallTokenErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checkingSession,
    required TResult Function(
      String sessionId,
      String channelName,
      String sessionType,
    )
    sessionActive,
    required TResult Function(String message) sessionNotAvailable,
    required TResult Function(String error) sessionCheckError,
    required TResult Function() gettingCallToken,
    required TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )
    callTokenRetrieved,
    required TResult Function(String error) callTokenError,
  }) {
    return callTokenError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checkingSession,
    TResult? Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult? Function(String message)? sessionNotAvailable,
    TResult? Function(String error)? sessionCheckError,
    TResult? Function()? gettingCallToken,
    TResult? Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult? Function(String error)? callTokenError,
  }) {
    return callTokenError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checkingSession,
    TResult Function(String sessionId, String channelName, String sessionType)?
    sessionActive,
    TResult Function(String message)? sessionNotAvailable,
    TResult Function(String error)? sessionCheckError,
    TResult Function()? gettingCallToken,
    TResult Function(
      String token,
      String channelName,
      int expiry,
      String callType,
    )?
    callTokenRetrieved,
    TResult Function(String error)? callTokenError,
    required TResult orElse(),
  }) {
    if (callTokenError != null) {
      return callTokenError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CheckingSession value) checkingSession,
    required TResult Function(SessionActive value) sessionActive,
    required TResult Function(SessionNotAvailable value) sessionNotAvailable,
    required TResult Function(SessionCheckError value) sessionCheckError,
    required TResult Function(GettingCallToken value) gettingCallToken,
    required TResult Function(CallTokenRetrieved value) callTokenRetrieved,
    required TResult Function(CallTokenError value) callTokenError,
  }) {
    return callTokenError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CheckingSession value)? checkingSession,
    TResult? Function(SessionActive value)? sessionActive,
    TResult? Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult? Function(SessionCheckError value)? sessionCheckError,
    TResult? Function(GettingCallToken value)? gettingCallToken,
    TResult? Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult? Function(CallTokenError value)? callTokenError,
  }) {
    return callTokenError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CheckingSession value)? checkingSession,
    TResult Function(SessionActive value)? sessionActive,
    TResult Function(SessionNotAvailable value)? sessionNotAvailable,
    TResult Function(SessionCheckError value)? sessionCheckError,
    TResult Function(GettingCallToken value)? gettingCallToken,
    TResult Function(CallTokenRetrieved value)? callTokenRetrieved,
    TResult Function(CallTokenError value)? callTokenError,
    required TResult orElse(),
  }) {
    if (callTokenError != null) {
      return callTokenError(this);
    }
    return orElse();
  }
}

abstract class CallTokenError implements CommunicationState {
  const factory CallTokenError({required final String error}) =
      _$CallTokenErrorImpl;

  String get error;

  /// Create a copy of CommunicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallTokenErrorImplCopyWith<_$CallTokenErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
