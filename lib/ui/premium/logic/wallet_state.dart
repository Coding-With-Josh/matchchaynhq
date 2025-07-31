
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

part 'wallet_state.freezed.dart';

@freezed
sealed class WalletState with _$WalletState {
  const factory WalletState({
    GetCapabilitiesResult? capabilities,
    AuthorizationResult? authorizationResult,
    @Default(false) bool isLoading,
    @Default(false) bool isUserSubscribed,
    @Default(null) double? accountBalance,
  }) = _WalletState;

  const WalletState._();

  bool get isAuthorized => authorizationResult != null;

  Ed25519HDPublicKey? get publicKey {
    final publicKey = authorizationResult?.publicKey;
    if (publicKey == null) return null;

    return Ed25519HDPublicKey(publicKey);
  }

  String? get address => publicKey?.toBase58();
}
