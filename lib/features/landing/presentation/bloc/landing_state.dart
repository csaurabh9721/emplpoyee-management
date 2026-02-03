part of 'landing_bloc.dart';

@immutable
sealed class LandingState extends Equatable {

  const LandingState();


  @override
  List<Object?> get props => [];
}

final class LandingInitial extends LandingState {
  const LandingInitial();
}

final class LandingLoading extends LandingState {
  const LandingLoading();
}

final class LandingSuccess extends LandingState {

  const LandingSuccess(
    this.dahBoardData,
   // this.profileData,
  );
  final DashboardResponseEntity dahBoardData;
  //final ProfileResponseEntity profileData;

  LandingSuccess copyWith({
    int? currentIndex,
    DashboardResponseEntity? dahBoardData,
    ProfileResponseEntity? profileData,
  }) {
    return LandingSuccess(
      dahBoardData ?? this.dahBoardData,
    //  profileData ?? this.profileData,
    );
  }

  @override
  List<Object?> get props => [ dahBoardData];
}

final class LandingError extends LandingState {

  const LandingError( this.message);
  final String message;

  LandingError copyWith({
    int? currentIndex,
    String? message,
  }) {
    return LandingError(
      message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [ message];
}
