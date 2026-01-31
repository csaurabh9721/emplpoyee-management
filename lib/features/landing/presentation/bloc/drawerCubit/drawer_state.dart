import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class DrawerState extends Equatable {

  const DrawerState({required this.isEmpSelfExpanded, required this.isGeneralExpanded});
  final bool isEmpSelfExpanded;
  final bool isGeneralExpanded;

  DrawerState copyWith({bool? isEmpSelfExpanded, bool? isGeneralExpanded}) {
    return DrawerState(
      isEmpSelfExpanded: isEmpSelfExpanded ?? this.isEmpSelfExpanded,
      isGeneralExpanded: isGeneralExpanded ?? this.isGeneralExpanded,
    );
  }

  @override
  List<Object?> get props => [isEmpSelfExpanded, isGeneralExpanded];
}
