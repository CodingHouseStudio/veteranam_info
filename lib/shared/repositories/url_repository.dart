import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:veteranam/shared/shared.dart';

@LazySingleton(as: IUrlRepository)
class UrlRepository extends IUrlRepository {
  @override
  Future<Either<SomeFailure, bool>> share(String url) async {
    final baseUrl = kIsWeb ? Uri.base.origin : KAppText.site;
    try {
      // if (KTest.testIsWeb) {
      await Share.shareUri(
        Uri.parse(baseUrl + url),
      );
      // } else {
      //   await Share.share(
      //     url,
      //   );
      // }
      return const Right(true);
    } catch (e, stack) {
      // Error if user closes the sharing dialog in Safari
      if (e.toString() ==
          'Exception: Navigator.share() failed: Abort due to cancellation'
              ' of share.') {
        return const Right(true);
      }
      final error = ShareFailure.fromCode(error: e, stack: stack).status;
      if (error == null) {
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
    // url_launcher.LaunchMode? mode,
  }) async {
    try {
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
          // mode: mode ?? url_launcher.LaunchMode.platformDefault,
        );
        return const Right(true);
      }
      return const Right(false);
    } catch (e, stack) {
      return Left(SomeFailure.link(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> copy(String text) async {
    try {
      await Clipboard.setData(
        ClipboardData(text: text),
      );
      return const Right(true);
    } catch (e, stack) {
      return Left(SomeFailure.copy(error: e, stack: stack));
    }
  }
}
