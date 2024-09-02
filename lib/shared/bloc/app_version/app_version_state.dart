part of 'app_version_cubit.dart';

class AppVersionState extends Equatable {
  const AppVersionState({
    required this.build,
    required this.mobHasNewBuild,
  });

  final PackageInfo build;
  final bool mobHasNewBuild;

  @override
  List<Object?> get props => [
        build,
        mobHasNewBuild,
      ];
}
