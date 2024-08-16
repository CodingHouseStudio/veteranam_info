import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:veteranam/shared/shared.dart';

@LazySingleton(as: IUrlRepository)
class UrlRepository extends IUrlRepository {
  @override
  Future<Either<SomeFailure, bool>> share(String url) async {
    try {
      // final resault =
      await Share.share(
        url,
      );
      // if (resault.status != ShareResultStatus.success) {
      //   await Clipboard.setData(
      //     ClipboardData(text: url),
      //   );
      // }
      return const Right(true);
    } catch (e) {
      return const Left(SomeFailure.share());
    }
  }

  @override
  Future<Either<SomeFailure, bool>> launchUrl({
    required String url,
    String? scheme,
    url_launcher.LaunchMode mode = url_launcher.LaunchMode.platformDefault,
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
          mode: mode,
        );
        return const Right(true);
      }
      return const Left(SomeFailure.link());
    } catch (e) {
      return const Left(SomeFailure.link());
    }
  }

  @override
  Future<Either<SomeFailure, bool>> copy(String text) async {
    try {
      await Clipboard.setData(
        const ClipboardData(text: KAppText.email),
      );
      return const Right(true);
    } catch (e) {
      return const Left(SomeFailure.copy());
    }
  }
}
