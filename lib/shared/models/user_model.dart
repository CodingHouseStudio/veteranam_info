import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart'; // Generated file for JSON serialization

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    String? email,
    String? name,
    String? photo,
    String? phoneNumber,
  }) = _User;

  // Add this private constructor
  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is empty.
  // bool get isAnonymously =>
  //     this == User.empty || email == null || email!.isEmpty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;
}

abstract class UserModelJsonField {
  static const id = 'id';
  static const email = 'email';
  static const name = 'name';
  static const photo = 'photo';
  static const phoneNumber = 'phoneNumber';
}
