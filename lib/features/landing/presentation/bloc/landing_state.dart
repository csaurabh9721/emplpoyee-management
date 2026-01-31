part of 'landing_bloc.dart';

@immutable
sealed class LandingState extends Equatable {

  const LandingState(this.currentIndex);
  final int currentIndex;

  String get appBarTitle => currentIndex == 0 ? "Dashboard" : "Profile";

  @override
  List<Object?> get props => [currentIndex];
}

final class LandingInitial extends LandingState {
  const LandingInitial(super.currentIndex);
}

final class LandingLoading extends LandingState {
  const LandingLoading(super.currentIndex);
}

final class LandingSuccess extends LandingState {

  const LandingSuccess(
    super.currentIndex,
    this.dahBoardData,
    this.profileData,
  );
  final DashboardResponseEntity dahBoardData;
  final ProfileResponseEntity profileData;

  LandingSuccess copyWith({
    int? currentIndex,
    DashboardResponseEntity? dahBoardData,
    ProfileResponseEntity? profileData,
  }) {
    return LandingSuccess(
      currentIndex ?? this.currentIndex,
      dahBoardData ?? this.dahBoardData,
      profileData ?? this.profileData,
    );
  }

  @override
  List<Object?> get props => [currentIndex, dahBoardData, profileData];
}

final class LandingError extends LandingState {

  const LandingError(super.currentIndex, this.message);
  final String message;

  LandingError copyWith({
    int? currentIndex,
    String? message,
  }) {
    return LandingError(
      currentIndex ?? this.currentIndex,
      message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [currentIndex, message];
}
