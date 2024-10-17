import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class MarkdownFileCubit extends Cubit<String?> {
  MarkdownFileCubit({
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        super(null);
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> init({
    required String ukFilePath,
    required String? enFilePath,
  }) async {
    final language = _appAuthenticationRepository.currentUserSetting.locale;
    final data = await rootBundle.loadString(
      language == Language.english && enFilePath != null
          ? enFilePath
          : ukFilePath,
      cache: KTest.cashe,
    );
    emit(data);
  }
}
