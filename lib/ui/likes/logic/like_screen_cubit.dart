import 'package:flutter_bloc/flutter_bloc.dart';

import '../../premium/storage/wallet_secure_storage.dart';
import 'like_screen_state.dart';

class LikesCubit extends Cubit<LikeScreenState> {
  LikesCubit() : super(LikeScreenStateInitial());

  final WalletSecureStorage _walletSecureStorage = WalletSecureStorage();

  Future<void> isUserSubscribed() async {
    try {
      final isUserSubscribed = await _walletSecureStorage.getIsUserSubscribed();
      if (isUserSubscribed) {
        emit(LikeScreenStateSuccess(isUserSubscribed: true));
      } else {
        emit(LikeScreenStateSuccess(isUserSubscribed: false));
      }
    } catch (e) {
      emit(LikeScreenStateError());
    }
  }
}
