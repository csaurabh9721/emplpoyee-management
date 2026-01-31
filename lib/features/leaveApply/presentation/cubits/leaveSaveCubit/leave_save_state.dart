part of 'leave_save_cubit.dart';

@immutable
abstract class LeaveSaveState {
  const LeaveSaveState();
}

final class InitialLeaveSaveState extends LeaveSaveState {
  const InitialLeaveSaveState();
}

final class LoadingLeaveSaveState extends LeaveSaveState {
  const LoadingLeaveSaveState();
}

class SuccessLeaveSaveState extends LeaveSaveState {

  const SuccessLeaveSaveState(this.message);
  final String message;
}

class ErrorLeaveSaveState extends LeaveSaveState {

  const ErrorLeaveSaveState(this.message);
  final String message;
}
