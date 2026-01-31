import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:clientone_ess/features/accountLedger/domain/entity/gl_entity.dart';

import '../../domain/entity/account_ledger_entity.dart';

@immutable
abstract class AccountLedgerState extends Equatable {
  const AccountLedgerState();

  @override
  List<Object?> get props => [];
}

final class AccountLedgerInitial extends AccountLedgerState {
  const AccountLedgerInitial();
}

final class AccountLedgerLoading extends AccountLedgerState {
  const AccountLedgerLoading();
}

final class AccountLedgerGLLoaded extends AccountLedgerState {
  const AccountLedgerGLLoaded({required this.glEntity});
  final List<GlEntity> glEntity;
  @override
  List<Object?> get props => [glEntity];
}

final class AccountLedgerLoaded extends AccountLedgerState {
  const AccountLedgerLoaded(this.accountLedgerEntity);
  final AccountLedgerEntity accountLedgerEntity;

  @override
  List<Object?> get props => [accountLedgerEntity];
}

final class AccountLedgerExport extends AccountLedgerState {
  const AccountLedgerExport(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class AccountLedgerError extends AccountLedgerState {
  const AccountLedgerError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
