import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/landing/presentation/bloc/profileCubit/profile_state.dart';
import '../../../../../core/Enums/enums.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  void changeTab(ProfileTab tab) {
    emit(state.copyWith(currentTab: tab));
  }

  @override
  Future<void> close() {
    debugPrint('ProfileCubit closed');
    return super.close();
  }
}
