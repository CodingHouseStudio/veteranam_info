import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class BuildCubit extends Cubit<PackageInfo> {
  BuildCubit({
    required BuildRepository buildRepository,
  })  : _buildRepository = buildRepository,
        super(BuildRepository.defaultValue);
  final BuildRepository _buildRepository;

  Future<void> started() async {
    final buildInfo = await _buildRepository.getBuildInfo();
    emit(buildInfo);
  }
}
