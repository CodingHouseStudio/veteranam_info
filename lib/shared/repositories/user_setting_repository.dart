import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton()
class UserSettingRepository {
  UserSettingRepository(
    this.iAppAuthenticationRepository,
  );
  final IAppAuthenticationRepository iAppAuthenticationRepository;
  late final StreamController<AuthenticationStatus> _controller;

  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  // final CacheClient _cache;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userSettingCacheKey = '__user_setting_cache_key__';

  @override
  UserSetting get currentUserSetting =>
      // _cache.read<UserSetting>(key: userSettingCacheKey) ??
      UserSetting.empty;

  @override
  Future<Either<SomeFailure, bool>> updateUserSetting(
    UserSetting userSetting,
  ) async {
    if (userSetting.id == UserSetting.empty.id) return const Right(false);
    try {
      await _firestoreService.updateUserSetting(
        userSetting,
      );
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, UserSetting>> getUserSetting(String userId) async {
    if (userId == UserSetting.empty.id) return const Right(UserSetting.empty);
    try {
      final result = await _firestoreService.getUserSetting(
        userId,
      );
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  // void _updateAuthStatusBasedOnCache() {
  //   debugPrint('Updating auth status based on cache');
  //   final user = currentUserSetting != UserSetting.empty;
  //   debugPrint('Current user inside '
  //       '_updateAuthStatusBasedOnCache : $currentUserSetting');
  //   debugPrint('user is $user');
  // }
}
