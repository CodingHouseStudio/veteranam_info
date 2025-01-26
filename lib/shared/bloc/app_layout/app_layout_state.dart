part of 'app_layout_bloc.dart';

class AppLayoutState extends Equatable {
  const AppLayoutState._({
    required this.appVersionEnum,
    this.failure,
  });

  const AppLayoutState.desk() : this._(appVersionEnum: AppVersionEnum.desk);

  const AppLayoutState.tablet()
      : this._(
          appVersionEnum: AppVersionEnum.tablet,
        );

  // const AppLayoutState.unauthenticated()
  //     : this._(status: AppVersionEnum.unauthenticated);

  const AppLayoutState.mob()
      : this._(
          appVersionEnum: AppVersionEnum.mobile,
        );

  const AppLayoutState.failure({
    required SomeFailure failure,
    required AppVersionEnum previousAppVersion,
  }) : this._(
          appVersionEnum: previousAppVersion,
          failure: failure,
        );

  final AppVersionEnum appVersionEnum;

  final SomeFailure? failure;

  @override
  List<Object> get props => [appVersionEnum];
}
