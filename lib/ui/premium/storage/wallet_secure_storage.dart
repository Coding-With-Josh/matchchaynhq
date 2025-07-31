// lib/wallet_secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A dedicated class for securely storing and retrieving wallet-related data.
class WalletSecureStorage {
  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Define a key for storing the authorization token
  static const String _authTokenKey = 'solana_auth_token';
  static const String _isUserSubscribedKey = 'is_user_subscribed';

  Future<void> saveIsUserSubscribed(bool isSubscribed) async {
    try {
      await _storage.write(
        key: _isUserSubscribedKey,
        value: isSubscribed.toString(),
      );
    } catch (e) {
      //log error to server
    }
  }

  Future<bool> getIsUserSubscribed() async {
    try {
      final String? isSubscribed = await _storage.read(
        key: _isUserSubscribedKey,
      );
      if (isSubscribed != null) {
        return isSubscribed == 'true';
      }
      return false;
    } catch (e) {
      //log error to server
      return false;
    }
  }

  Future<void> deleteIsUserSubscribed() async {
    try {
      await _storage.delete(key: _isUserSubscribedKey);
    } catch (e) {
      //log error to server
    }
  }

  /// Saves the given authorization token securely.
  /// This token is used for re-authorization with the mobile wallet.
  Future<void> saveAuthToken(String token) async {
    try {
      await _storage.write(key: _authTokenKey, value: token);
    } catch (e) {
      //log error to server
    }
  }

  /// Retrieves the stored authorization token securely.
  /// Returns null if no token is found.
  Future<String?> getAuthToken() async {
    try {
      final String? token = await _storage.read(key: _authTokenKey);
      return token;
    } catch (e) {
      //log error to server
      return null;
    }
  }

  /// Deletes the stored authorization token securely.
  Future<void> deleteAuthToken() async {
    try {
      await _storage.delete(key: _authTokenKey);

    } catch (e) {
      //log error to server
    }
  }
}
