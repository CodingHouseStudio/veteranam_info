part of 'discount_link_form_bloc.dart';

enum DiscountLinkFormFailure {
  error,
  send,
  network,
}

extension DiscountLinkFormFailureExtension on SomeFailure {
  DiscountLinkFormFailure _toDiscountLinkForm() {
    switch (this) {
      case FailureSend():
        return DiscountLinkFormFailure.send;
      case FailureNetwork():
        return DiscountLinkFormFailure.network;
      default:
        return DiscountLinkFormFailure.error;
    }
  }
}

@freezed
class DiscountLinkFormState with _$DiscountLinkFormState {
  const factory DiscountLinkFormState({
    required LinkFieldModel link,
    required LinkEnum formState,
    DiscountLinkFormFailure? failure,
  }) = _Initial;
}

enum LinkEnum { initial, inProgress, success, invalidData, notShow }
