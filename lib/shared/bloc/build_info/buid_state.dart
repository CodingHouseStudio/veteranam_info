part of 'build_cubit.dart';

class BuildState extends Equatable {
  const BuildState({
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
