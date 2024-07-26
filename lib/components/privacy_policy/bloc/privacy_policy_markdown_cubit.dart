import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class PrivacyPolicyMarkdownCubit extends Cubit<String?> {
  PrivacyPolicyMarkdownCubit({
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        super(null);
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> init() async {
    final language = _appAuthenticationRepository
        .currentUserSetting.locale.value.languageCode;
    final data = await rootBundle.loadString(
      'assets/markdown/privacy_policy_$language.md',
      cache: KTest.cashe,
    );
    emit(data);
  }
}
