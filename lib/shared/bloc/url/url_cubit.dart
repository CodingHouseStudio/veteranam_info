import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class UrlCubit extends Cubit<UrlFailure?> {
  UrlCubit({
    required IUrlRepository urlRepository,
  })  : _urlRepository = urlRepository,
        super(null);
  final IUrlRepository _urlRepository;

  Future<void> share(
    String? url,
  ) async {
    if (url == null) {
      return;
    }
    final result = await _urlRepository.share(
      url,
    );
    result.fold(
      (l) => emit(l.toUrl()),
      (r) => emit(null),
    );
  }

  Future<void> launchUrl({
    required String? url,
    String? scheme,
    LaunchMode? mode,
  }) async {
    if (url == null) {
      return;
    }
    final result = await _urlRepository.launchUrl(
      url: url,
      scheme: scheme,
    );
    result.fold(
      (l) => emit(l.toUrl()),
      (r) => emit(null),
    );
  }
}
