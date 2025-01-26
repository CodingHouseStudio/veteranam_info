part of 'app_layout_bloc.dart';

class _AppLayoutEvent extends Equatable {
  const _AppLayoutEvent();

  @override
  List<Object> get props => [];
}

// class AppLayoutInitialized extends AppLayoutEvent {}

class _AppVersionChanged extends _AppLayoutEvent {
  const _AppVersionChanged(this.appVersionEnum);

  final AppVersionEnum appVersionEnum;

  @override
  List<Object> get props => [appVersionEnum];
}

class _AppVersionFailureEvent extends _AppLayoutEvent {
  const _AppVersionFailureEvent({required this.stack, required this.error});

  final Object error;
  final StackTrace stack;

  @override
  List<Object> get props => [stack, error];
}
