// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WalletState {
  GetCapabilitiesResult? get capabilities => throw _privateConstructorUsedError;
  AuthorizationResult? get authorizationResult =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isUserSubscribed => throw _privateConstructorUsedError;
  double? get accountBalance => throw _privateConstructorUsedError;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
    WalletState value,
    $Res Function(WalletState) then,
  ) = _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call({
    GetCapabilitiesResult? capabilities,
    AuthorizationResult? authorizationResult,
    bool isLoading,
    bool isUserSubscribed,
    double? accountBalance,
  });

  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isLoading = null,
    Object? isUserSubscribed = null,
    Object? accountBalance = freezed,
  }) {
    return _then(
      _value.copyWith(
            capabilities: freezed == capabilities
                ? _value.capabilities
                : capabilities // ignore: cast_nullable_to_non_nullable
                      as GetCapabilitiesResult?,
            authorizationResult: freezed == authorizationResult
                ? _value.authorizationResult
                : authorizationResult // ignore: cast_nullable_to_non_nullable
                      as AuthorizationResult?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isUserSubscribed: null == isUserSubscribed
                ? _value.isUserSubscribed
                : isUserSubscribed // ignore: cast_nullable_to_non_nullable
                      as bool,
            accountBalance: freezed == accountBalance
                ? _value.accountBalance
                : accountBalance // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities {
    if (_value.capabilities == null) {
      return null;
    }

    return $GetCapabilitiesResultCopyWith<$Res>(_value.capabilities!, (value) {
      return _then(_value.copyWith(capabilities: value) as $Val);
    });
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorizationResultCopyWith<$Res>? get authorizationResult {
    if (_value.authorizationResult == null) {
      return null;
    }

    return $AuthorizationResultCopyWith<$Res>(_value.authorizationResult!, (
      value,
    ) {
      return _then(_value.copyWith(authorizationResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletStateImplCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$WalletStateImplCopyWith(
    _$WalletStateImpl value,
    $Res Function(_$WalletStateImpl) then,
  ) = __$$WalletStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GetCapabilitiesResult? capabilities,
    AuthorizationResult? authorizationResult,
    bool isLoading,
    bool isUserSubscribed,
    double? accountBalance,
  });

  @override
  $GetCapabilitiesResultCopyWith<$Res>? get capabilities;
  @override
  $AuthorizationResultCopyWith<$Res>? get authorizationResult;
}

/// @nodoc
class __$$WalletStateImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletStateImpl>
    implements _$$WalletStateImplCopyWith<$Res> {
  __$$WalletStateImplCopyWithImpl(
    _$WalletStateImpl _value,
    $Res Function(_$WalletStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capabilities = freezed,
    Object? authorizationResult = freezed,
    Object? isLoading = null,
    Object? isUserSubscribed = null,
    Object? accountBalance = freezed,
  }) {
    return _then(
      _$WalletStateImpl(
        capabilities: freezed == capabilities
            ? _value.capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as GetCapabilitiesResult?,
        authorizationResult: freezed == authorizationResult
            ? _value.authorizationResult
            : authorizationResult // ignore: cast_nullable_to_non_nullable
                  as AuthorizationResult?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isUserSubscribed: null == isUserSubscribed
            ? _value.isUserSubscribed
            : isUserSubscribed // ignore: cast_nullable_to_non_nullable
                  as bool,
        accountBalance: freezed == accountBalance
            ? _value.accountBalance
            : accountBalance // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$WalletStateImpl extends _WalletState with DiagnosticableTreeMixin {
  const _$WalletStateImpl({
    this.capabilities,
    this.authorizationResult,
    this.isLoading = false,
    this.isUserSubscribed = false,
    this.accountBalance = null,
  }) : super._();

  @override
  final GetCapabilitiesResult? capabilities;
  @override
  final AuthorizationResult? authorizationResult;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUserSubscribed;
  @override
  @JsonKey()
  final double? accountBalance;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletState(capabilities: $capabilities, authorizationResult: $authorizationResult, isLoading: $isLoading, isUserSubscribed: $isUserSubscribed, accountBalance: $accountBalance)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletState'))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('authorizationResult', authorizationResult))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isUserSubscribed', isUserSubscribed))
      ..add(DiagnosticsProperty('accountBalance', accountBalance));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.authorizationResult, authorizationResult) ||
                other.authorizationResult == authorizationResult) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUserSubscribed, isUserSubscribed) ||
                other.isUserSubscribed == isUserSubscribed) &&
            (identical(other.accountBalance, accountBalance) ||
                other.accountBalance == accountBalance));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    capabilities,
    authorizationResult,
    isLoading,
    isUserSubscribed,
    accountBalance,
  );

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      __$$WalletStateImplCopyWithImpl<_$WalletStateImpl>(this, _$identity);
}

abstract class _WalletState extends WalletState {
  const factory _WalletState({
    final GetCapabilitiesResult? capabilities,
    final AuthorizationResult? authorizationResult,
    final bool isLoading,
    final bool isUserSubscribed,
    final double? accountBalance,
  }) = _$WalletStateImpl;
  const _WalletState._() : super._();

  @override
  GetCapabilitiesResult? get capabilities;
  @override
  AuthorizationResult? get authorizationResult;
  @override
  bool get isLoading;
  @override
  bool get isUserSubscribed;
  @override
  double? get accountBalance;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
