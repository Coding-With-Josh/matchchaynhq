// ignore_for_file: cast_nullable_to_non_nullable, avoid-future-ignore, avoid-type-casts

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchchayn/ui/premium/logic/wallet_state.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

import '../storage/wallet_secure_storage.dart';
import 'config.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(const WalletState()) {
    _initializeClient();
    _loadAndReauthorize();
    _loadAndCheckSubscriptionStatus();
  }

  final WalletSecureStorage _walletSecureStorage =
      WalletSecureStorage();

  late SolanaClient _solanaClient;
  static const subscriptionAmountInSol = 0.05;
  static const identityUrl = "https://www.matchchayn.com/";
  static const identityName = "Matchchayn";
  static const identityIcon = "favicon.ico";

  void _initializeClient() {
    final rpcUrl = testnetRpcUrl;
    final websocketUrl = testnetWsUrl;
    _solanaClient = SolanaClient(
      rpcUrl: Uri.parse(rpcUrl),
      websocketUrl: Uri.parse(websocketUrl),
    );
  }

  Future<void> _loadAndReauthorize() async {
    final storedAuthToken = await _walletSecureStorage.getAuthToken();
    if (storedAuthToken != null) {
      //print('Found stored auth token. Attempting to reauthorize...');
      final session = await LocalAssociationScenario.create();
      try {
        session.startActivityForResult(null).ignore();
        final client = await session.start();

        final result = await client.reauthorize(
          identityUri: Uri.parse(identityUrl),
          iconUri: Uri.parse(identityIcon),
          identityName: identityName,
          authToken: storedAuthToken,
        );

        if (result != null) {
          emit(state.copyWith(authorizationResult: result));
       //   print('Successfully reauthorized with stored token.');
        } else {
          // Reauthorization failed, token might be expired or invalid
          await _walletSecureStorage.deleteAuthToken();
        }
      } catch (e) {
      //  log error to server
        await _walletSecureStorage.deleteAuthToken(); // Clear invalid token
      } finally {
        await session.close();
      }
    }
  }

  _loadAndCheckSubscriptionStatus() async {
    final isUserSubscribed = await _walletSecureStorage.getIsUserSubscribed();
    if (isUserSubscribed) {
      emit(state.copyWith(isUserSubscribed: true));
    } else {
      emit(state.copyWith(isUserSubscribed: false));
    }
  }

  // void updateNetwork({required bool isMainnet}) {
  //   if (state.isMainnet == isMainnet) return;
  //   _initializeClient();
  //   emit(WalletState());
  // }

  Future<bool> isWalletAvailable() => LocalAssociationScenario.isAvailable();



  Future<void> transferSol({required String recipientAddress}) async {
    // Check if authorized
    if (!state.isAuthorized) {
      return;
    }

    final publicKey = state.publicKey;
    if (publicKey == null) {
      return;
    }

    try {
      emit(
        state.copyWith(isLoading: true),
      );
      final session = await LocalAssociationScenario.create();

      session.startActivityForResult(null).ignore();
      final client = await session.start();

      // Reauthorize with the wallet to ensure a valid session
      await _doReauthorize(client);

      // Fetch a recent blockhash
      final blockhash =
          (await _solanaClient.rpcClient.getLatestBlockhash()).value.blockhash;

      // Convert SOL to Lamports
      final amount = _solToLamports(subscriptionAmountInSol);
      // Create the transfer instruction
      final transferInstruction = SystemInstruction.transfer(
        recipientAccount: Ed25519HDPublicKey.fromBase58(recipientAddress),
        fundingAccount: publicKey,
        lamports: amount,
      );

      // Create the message from the instruction
      final message = Message(instructions: [transferInstruction]);

      // Compile the message for signing
      final compiledMessage = message.compile(
        recentBlockhash: blockhash,
        feePayer: publicKey,
      );

      // Wrap the compiled message in a SignedTx (though signatures will be added by the wallet)
      final transaction = SignedTx(
        compiledMessage: compiledMessage,
        signatures: [
          Signature(List.filled(64, 0), publicKey: publicKey),
        ], // Placeholder signature
      );
      final tx = transaction.toByteArray().toList();
      final txs = Uint8List.fromList(tx);
      // Request the wallet to sign and send the transaction
      //print('Requesting wallet to sign and send SOL transfer...');
      final result = await client.signAndSendTransactions(transactions: [txs]);
     // print('SOL transfer initiated successfully to $recipientAddress!');
      await session.close();
      emit(state.copyWith(isUserSubscribed: true));
      await _walletSecureStorage.saveIsUserSubscribed(true);
    } catch (e) {
     // print('Error during SOL transfer: $e');
      //log error to server
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Queries the balance of the authorized public key.
  Future<void> getBalance() async {
    // Check if authorized
    if (!state.isAuthorized) {
      return;
    }

    final publicKey = state.publicKey;
    if (publicKey == null) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));
      final balance = await _solanaClient.rpcClient.getBalance(
        publicKey.toBase58(),
      );

      emit(state.copyWith(accountBalance: _lamportsToSol(balance.value)));

      // print(
      //   'Balance for address ${publicKey.toBase58()}: ${balance.value} Lamports',
      // );
      return;
    } catch (e) {
      //log error to server
      return;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  // ... (rest of the ClientBloc class)
  Future<void> authorize() async {
    emit(state.copyWith(isLoading: true));
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    final bool authorized = await _doAuthorize(client);
    await session.close();

    if (authorized && state.authorizationResult?.authToken != null) {
      await _walletSecureStorage.saveAuthToken(
        state.authorizationResult!.authToken!,
      );
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> reauthorize() async {
    final authToken = state.authorizationResult?.authToken;
    if (authToken == null) return;

    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    final bool reauthorized = await _doReauthorize(client);
    await session.close();

    if (reauthorized && state.authorizationResult?.authToken != null) {
      await _walletSecureStorage.saveAuthToken(
        state.authorizationResult!.authToken,
      );
    } else {
      // If reauthorization failed, clear the token
      await _walletSecureStorage.deleteAuthToken();
    }
  }

  Future<void> deauthorize() async {
    emit(state.copyWith(isLoading: true));
    final authToken = state.authorizationResult?.authToken;
    if (authToken == null) return;

    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    await client.deauthorize(authToken: authToken);
    await session.close();

    emit(state.copyWith(authorizationResult: null, isLoading: false));
    await _walletSecureStorage.deleteAuthToken();
  }

  Future<bool> _doAuthorize(MobileWalletAdapterClient client) async {
    final result = await client.authorize(
      identityUri: Uri.parse(identityUrl),
      iconUri: Uri.parse(identityIcon),
      identityName: identityName,
      cluster: testnetCluster,
    );

    emit(state.copyWith(authorizationResult: result));
    emit(state.copyWith(isLoading: false));
    return result != null;
  }

  Future<bool> _doReauthorize(MobileWalletAdapterClient client) async {
    final authToken = state.authorizationResult?.authToken;
    if (authToken == null) return false;

    final result = await client.reauthorize(
      identityUri: Uri.parse(identityUrl),
      iconUri: Uri.parse(identityIcon),
      identityName: identityName,
      authToken: authToken,
    );

    emit(state.copyWith(authorizationResult: result));

    return result != null;
  }

  double _lamportsToSol(int lamports) {
    return lamports / 1000000000;
  }

  int _solToLamports(double sol) {
    return (sol * 1000000000).toInt();
  }
}
