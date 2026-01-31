import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class GlEvent extends Equatable {
  const GlEvent();

  @override
  List<Object> get props => [];
}

final class GlLoadEvent extends GlEvent {}

