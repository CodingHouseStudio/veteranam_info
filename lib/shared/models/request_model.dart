import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

enum RequestStatus {
  isNew,
  responseRequired,
  resolved,
}

@freezed
class RequestModel with _$RequestModel {
  const factory RequestModel({
    required String id,
    required String guestId,
    required String guestName,
    required String email,
    required String phoneNumber,
    required String resume,
    required String city,
    required String position,
    required String category,
    required String message,
    required DateTime timestamp,
    @Default(RequestStatus.isNew) RequestStatus status,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
}

abstract class RequestModelJsonField {
  static const id = 'id';
  static const guestId = 'guestId';
  static const guestName = 'guestName';
  static const email = 'email';
  static const phoneNumber = 'phoneNumber';
  static const resume = 'resume';
  static const city = 'city';
  static const position = 'position';
  static const category = 'category';
  static const message = 'message';
  static const status = 'status';
  static const timestamp = 'timestamp';
}
