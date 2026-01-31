import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashLoaded extends SplashState {

  const SplashLoaded({this.version = '', this.onNavigate = false});
  final String version;
  final bool onNavigate;

  SplashLoaded copyWith({String? version, bool? onNavigate}) {
    return SplashLoaded(version: version ?? this.version, onNavigate: onNavigate ?? this.onNavigate);
  }

  @override
  List<Object?> get props => [version, onNavigate];
}

class SplashError extends SplashState {

  const SplashError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
