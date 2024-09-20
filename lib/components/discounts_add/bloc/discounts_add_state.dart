part of 'discounts_add_bloc.dart';

enum DiscountsAddFailure {
  error,
  network,
  send,
}

extension DiscountsAddFailureExtension on SomeFailure {
  DiscountsAddFailure _toDiscountsAdd() {
    switch (this) {
      case FailureSend():
        return DiscountsAddFailure.send;
      case FailureNetwork():
        return DiscountsAddFailure.network;
      default:
        return DiscountsAddFailure.error;
    }
  }
}

@freezed
class DiscountsAddState with _$DiscountsAddState {
  const factory DiscountsAddState({
    // required DiscountModel discountModel,
    required List<String> categoryList,
    required MessageFieldModel category,
    required CitiesFieldModel city,
    required MessageFieldModel? period,
    required MessageFieldModel title,
    required DiscountsFieldModel discounts,
    required LinkFieldModel link,
    required MessageFieldModel description,
    required MessageFieldModel exclusions,
    required DiscountsAddEnum formState,
    DiscountsAddFailure? failure,
  }) = _Initial;
}

enum DiscountsAddEnum {
  initial,
  inProgress,
  success,
  invalidData,
  detail,
  detailInProgress,
  detailInvalidData,
  description,
  descriptionInProgress,
  descriptionInvalidData;

  bool get isMain {
    switch (this) {
      case DiscountsAddEnum.inProgress:
      case DiscountsAddEnum.invalidData:
      case DiscountsAddEnum.initial:
        return true;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

  bool get isDetail {
    switch (this) {
      case DiscountsAddEnum.detail:
      case DiscountsAddEnum.detailInProgress:
      case DiscountsAddEnum.detailInvalidData:
        return true;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

  bool get isDescription {
    switch (this) {
      case DiscountsAddEnum.description:
      case DiscountsAddEnum.descriptionInProgress:
      case DiscountsAddEnum.descriptionInvalidData:
      case DiscountsAddEnum.success:
        return true;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

  bool get hasError {
    switch (this) {
      case DiscountsAddEnum.invalidData:
      case DiscountsAddEnum.detailInvalidData:
      case DiscountsAddEnum.descriptionInvalidData:
        return true;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

  int get pageNumber {
    if (isDetail) {
      return 2;
    } else if (isDescription) {
      return 3;
    } else {
      return 1;
    }
  }
}
