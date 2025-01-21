import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

Either<SomeFailure, T> eitherHelper<T>(
  Either<SomeFailure, T> Function() right, {
  required String methodName,
  required String className,
  String? data,
  ErrorLevelEnum? errorLevel,
  User? user,
  UserSetting? userSetting,
}) {
  try {
    return right();
  } catch (e, stack) {
    return Left(
      SomeFailure.value(
        error: e,
        stack: stack,
        user: user,
        userSetting: userSetting,
        tag: methodName,
        tagKey: className,
      ),
    );
  }
}

Future<Either<SomeFailure, T>> eitherFutureHelper<T>(
  Future<Either<SomeFailure, T>> Function() function, {
  required String methodName,
  required String className,
  String? data,
  ErrorLevelEnum? errorLevel,
  User? user,
  UserSetting? userSetting,
  void Function()? finallyFunction,
}) async {
  try {
    return await function();
  } catch (e, stack) {
    return Left(
      SomeFailure.value(
        error: e,
        stack: stack,
        user: user,
        userSetting: userSetting,
        tag: methodName,
        tagKey: className,
      ),
    );
  } finally {
    finallyFunction?.call();
  }
}

bool boolErrorHelper(
  bool Function() right, {
  required String methodName,
  required String className,
  String? data,
  ErrorLevelEnum? errorLevel,
  User? user,
  UserSetting? userSetting,
}) {
  try {
    return right();
  } catch (e, stack) {
    SomeFailure.value(
      error: e,
      stack: stack,
      user: user,
      userSetting: userSetting,
      tag: methodName,
      tagKey: className,
    );
    return false;
  }
}
