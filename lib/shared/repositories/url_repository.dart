import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:veteranam/shared/shared_dart.dart';

@LazySingleton(as: IUrlRepository)
class UrlRepository extends IUrlRepository {
  @override
  Future<Either<SomeFailure, bool>> share(
    String url, {
    bool? useSiteUrl,
  }) async {
    final baseUrl =
        (useSiteUrl ?? false) ? KAppText.site : UriExtension.baseUrl;
    try {
      // if (Config.isWeb) {
      final result = await SharePlus.instance.share(
        ShareParams(
          uri: Uri.parse(baseUrl + url),
        ),
      );
      // } else {
      //   await Share.share(
      //     url,
      //   );
      // }
      if (result.status == ShareResultStatus.success) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e, stack) {
      // Error if user closes the sharing dialog in Safari
      if (e.toString().contains('cancellation') ||
          e.toString().contains('canceled')) {
        return const Right(true);
      }
      final error = SomeFailure.value(
        error: e,
        stack: stack,
        tag: 'Url(share)',
        tagKey: ErrorText.repositoryKey,
        data: 'Url: $url| Used Site Url - $useSiteUrl',
      );
      if (error == SomeFailure.shareInProgress) {
        return const Right(false);
      }
      if (error == SomeFailure.shareUnavailable) {
        final resault = await copy(
          baseUrl + url,
        );
        return resault.fold(
          Left.new,
          (r) => const Right(false),
        );
      }
      return Left(error);
    }
  }

  @override
  Future<Either<SomeFailure, bool>> launchUrl({
    required String url,
    String? scheme,
    url_launcher.LaunchMode? mode,
    bool? openInCurrentWindow,
    // url_launcher.LaunchMode? mode,
  }) async {
    return eitherFutureHelper(
      () async {
        late Uri link;
        if (scheme != null) {
          link = Uri(
            scheme: scheme,
            path: url,
          );
        } else {
          link = Uri.parse(url);
        }
        final linkParse = await url_launcher.canLaunchUrl(link);
        if (linkParse) {
          await url_launcher.launchUrl(
            link,
            mode: mode ?? url_launcher.LaunchMode.platformDefault,
            webOnlyWindowName: openInCurrentWindow ?? false ? '_self' : null,

            // mode: mode ?? url_launcher.LaunchMode.platformDefault,
          );
          return const Right(true);
        }
        return const Right(false);
      },
      methodName: 'Url(launchUrl)',
      className: ErrorText.repositoryKey,
      data: 'Url: $url, Schema $scheme',
    );
  }

  // TODO(flutter): this repository use flutter import, import should be remove
  @override
  Future<Either<SomeFailure, bool>> copy(String text) async {
    return eitherFutureHelper(
      () async {
        await Clipboard.setData(
          ClipboardData(text: text),
        );
        return const Right(true);
      },
      methodName: 'Url(copy)',
      className: ErrorText.repositoryKey,
      data: 'Text $text',
    );
  }
}
