sealed class LikeScreenState {}

final class LikeScreenStateInitial extends LikeScreenState {}

final class LikeScreenStateSuccess extends LikeScreenState {
  final bool isUserSubscribed;

  LikeScreenStateSuccess({required this.isUserSubscribed});
}

final class LikeScreenStateError extends LikeScreenState {}

final class LikeScreenStateLoading extends LikeScreenState {}
