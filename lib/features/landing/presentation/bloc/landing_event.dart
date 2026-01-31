part of 'landing_bloc.dart';

@immutable
sealed class LandingEvent {
  const LandingEvent();
}

final class LoadAllDataEvent extends LandingEvent {
  const LoadAllDataEvent();
}

final class RefreshDashboard extends LandingEvent {
  const RefreshDashboard();
}

final class LandingPageChangeEvent extends LandingEvent {

  const LandingPageChangeEvent(this.index);
  final int index;
}
