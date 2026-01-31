import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/Enums/enums.dart';

@immutable
final class ProfileState extends Equatable {

  const ProfileState({required this.currentTab});

  factory ProfileState.initial() {
    return const ProfileState(currentTab: ProfileTab.personal);
  }
  final ProfileTab currentTab;

  ProfileState copyWith({ProfileTab? currentTab}) {
    return ProfileState(
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object?> get props => [currentTab];
}
