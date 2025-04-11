part of 'discounts_add_bloc.dart';

// extension DiscountsAddFailureGetter on DiscountsAddFailure? {
//   bool get linkIsWrong => this == DiscountsAddFailure.linkWrong;
// }

// extension DiscountsAddFailureExtension on SomeFailure {
//   DiscountsAddFailure _toDiscountsAdd() {
//     switch (this) {
//       case FailureSend():
//         return DiscountsAddFailure.send;
//       case FailureNetwork():
//         return DiscountsAddFailure.network;
//       default:
//         return DiscountsAddFailure.error;
//     }
//   }
// }

@freezed
sealed class DiscountsAddState with _$DiscountsAddState {
  const factory DiscountsAddState({
    required DiscountModel? discount,
    required List<String> categoryList,
    required List<CityModel> citiesList,
    required CategoriesFieldModel category,
    required CitiesFieldModel city,
    required bool isOnline,
    required DateFieldModel period,
    required MessageFieldModel title,
    required DiscountsFieldModel discounts,
    required EligibilityFieldModel eligibility,
    required LinkFieldModel link,
    required MessageFieldModel description,
    required MessageFieldModel requirements,
    required EmailFieldModel email,
    required DiscountsAddEnum formState,
    required bool isIndefinitely,
    SomeFailure? failure,
  }) = _Initial;
}

enum DiscountsAddEnum {
  initial,
  inProgress,
  // unmodified,
  sendInProgress,
  success,
  invalidData,
  detail,
  detailInProgress,
  detailInvalidData,
  description,
  descriptionInProgress,
  descriptionInvalidData,
  showDialog;

  bool get isLoading {
    switch (this) {
      case DiscountsAddEnum.showDialog:
      case DiscountsAddEnum.success:
      case DiscountsAddEnum.sendInProgress:
        return true;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

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
      case DiscountsAddEnum.sendInProgress:
      case DiscountsAddEnum.showDialog:
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
