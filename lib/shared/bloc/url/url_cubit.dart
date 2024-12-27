import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:veteranam/shared/shared_dart.dart';

@injectable
class UrlCubit extends Cubit<UrlEnum?> {
  UrlCubit({
    required IUrlRepository urlRepository,
  })  : _urlRepository = urlRepository,
        super(null);
  final IUrlRepository _urlRepository;

  Future<void> share(String? url, {bool? useSiteUrl}) async {
    if (url == null) {
      return;
    }
    final result = await _urlRepository.share(
      url,
      useSiteUrl: useSiteUrl,
    );
    result.fold(
      // (l) => emit(UrlEnum.copyEmailSucceed),
      (l) => emit(null),
      (r) => r ? emit(null) : emit(UrlEnum.copyLinkSucceed),
    );
  }

  Future<void> launchUrl({
    required String? url,
    String? scheme,
    LaunchMode? mode,
    bool? openInCurrentWindow,
  }) async {
    if (url == null) {
      return;
    }
    final result = await _urlRepository.launchUrl(
      url: url,
      scheme: scheme,
      mode: mode,
      openInCurrentWindow: openInCurrentWindow,
    );
    result.fold(
      (l) => emit(l.toUrl()),
      (r) => emit(null),
    );
  }

  Future<void> copy({
    required String text,
    CopyEnum copyEnum = CopyEnum.email,
  }) async {
    final result = await _urlRepository.copy(
      text,
    );
    result.fold(
      (l) => emit(l.toUrl()),
      (r) {
        switch (copyEnum) {
          case CopyEnum.email:
            emit(UrlEnum.copyEmailSucceed);
          case CopyEnum.phoneNumber:
            emit(UrlEnum.copyPhoneNumberSucceed);
        }
      },
    );
  }

  void reset() {
    emit(null);
  }
}
