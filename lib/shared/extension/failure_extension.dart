import 'package:flutter/material.dart' show BuildContext;

import 'package:veteranam/shared/shared_flutter.dart';

// import 'package:veteranam/shared/constants/failure_enum.dart';

extension SomeFailureValue on SomeFailure {
  String? value(BuildContext context) {
    switch (this) {
      case SomeFailure.setExistData:
      case SomeFailure.serverError:
      case SomeFailure.noSuchMethodError:
        return context.l10n.unkownError;
      case SomeFailure.timeout:
        return context.l10n.timeoutFailure;
      case SomeFailure.type:
        return context.l10n.typeFailure;
      case SomeFailure.assertion:
        return context.l10n.assertionFailure;
      case SomeFailure.unimplementedFeature:
        return context.l10n.unimplementedFeatureFailure;
      case SomeFailure.format:
        return context.l10n.formatFailure;
      case SomeFailure.get:
        return context.l10n.getFailure;
      case SomeFailure.send:
        return context.l10n.sendFailure;
      case SomeFailure.network:
        return context.l10n.networkFailure;
      case SomeFailure.maxRetries:
        return context.l10n.maxRetriesFailure;
      case SomeFailure.loadFileCancel:
        return context.l10n.loadFileCancelFailure;
      case SomeFailure.cancelled:
        return context.l10n.cancelledFailure;
      case SomeFailure.fcm:
        return context.l10n.fcmFailure;
      case SomeFailure.unauthorized:
        return context.l10n.unauthorizedFailure;
      case SomeFailure.userNotFound:
        return context.l10n.userNotFoundFailure;
      case SomeFailure.userDuplicate:
        return context.l10n.userDuplicateFailure;
      case SomeFailure.requiresRecentLogin:
        return context.l10n.requiresRecentLoginFailure;
      case SomeFailure.userEmailDuplicate:
        return context.l10n.userEmailDuplicateFailure;
      case SomeFailure.tooManyRequests:
        return context.l10n.tooManyRequestsFailure;
      case SomeFailure.permission:
        return context.l10n.permissionFailure;
      case SomeFailure.emailSendingFailed:
        return context.l10n.emailSendingFailedFailure;
      case SomeFailure.share:
        return context.l10n.shareFailure;
      case SomeFailure.shareUnavailable:
        return null;
      case SomeFailure.link:
        return context.l10n.linkFailure;
      case SomeFailure.copy:
        return context.l10n.copyFailure;
      case SomeFailure.wrongVerifyCode:
        return context.l10n.wrongVerifyCodeFailure;
      case SomeFailure.invalidInput:
        return context.l10n.invalidInputFailure;
      case SomeFailure.browserNotSupportPopupDialog:
        return context.l10n.browserNotSupportPopupDialogFailure;
      case SomeFailure.emailInvalidFormat:
        return context.l10n.emailInvalidFormatFailure;
      case SomeFailure.passwordWrong:
        return context.l10n.passwordWrongFailure;
      case SomeFailure.passwordWeak:
        return context.l10n.passwordWeakFailure;
      case SomeFailure.userDisable:
        return context.l10n.userDisableFailure;
      case SomeFailure.dataNotFound:
        return context.l10n.dataNotFoundFailure;
      case SomeFailure.wrongID:
        return context.l10n.wrongIDFailure;
      case SomeFailure.linkWrong:
        return context.l10n.linkWrongFailure;
      case SomeFailure.providerAlreadyLinked:
      case SomeFailure.shareInProgress:
      case SomeFailure.serviceWorkerRegistration:
        return null;
      case SomeFailure.filter:
        return context.l10n.discountFilterFailureMessage;
      case SomeFailure.unsupported:
        return context.l10n.unsupportedError;
      case SomeFailure.copyNotSupport:
        return context.l10n.copyNotSupportError;
      case SomeFailure.popupCancelled:
        return null;
    }
  }
}
// extension DiscountFailureValue on DiscountsFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case DiscountsFailure.report:
//       case DiscountsFailure.error:
//         return context.l10n.error;
//       case DiscountsFailure.filter:
//         return context.l10n.discountFilterFailureMessage;
//     }
//   }
// }

// extension FeedbackFailureValue on FeedbackFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case FeedbackFailure.error:
//         return context.l10n.error;
//       case FeedbackFailure.send:
//         return context.l10n.sendFailure;
//       case FeedbackFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension InformationFailureValue on InformationFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case InformationFailure.error:
//         return context.l10n.error;
//     }
//   }
// }

// extension InvestorsFailureValue on InvestorsFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case InvestorsFailure.error:
//         return context.l10n.error;
//       case InvestorsFailure.get:
//         return context.l10n.getFailure;
//       case InvestorsFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension LoginFailureValue on LoginFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case LoginFailure.error:
//         return context.l10n.error;
//       case LoginFailure.send:
//         return context.l10n.sendFailure;
//       case LoginFailure.network:
//         return context.l10n.networkFailure;
//       case LoginFailure.notFound:
//         return context.l10n.notFoundFailure;
//       case LoginFailure.passwordWrong:
//         return '${context.l10n.password} ${context.l10n.isWrongCode}';
//     }
//   }
// }

// extension SignUpFailureValue on SignUpError {
//   String value(BuildContext context) {
//     switch (this) {
//       case SignUpError.error:
//         return context.l10n.error;
//       case SignUpError.send:
//         return context.l10n.sendFailure;
//       case SignUpError.network:
//         return context.l10n.networkFailure;
//       case SignUpError.duplicate:
//         return context.l10n.dublicateFailure;
//       case SignUpError.emailWrongFormat:
//         return '${context.l10n.email} ${context.l10n.isWrongEmail}';
//     }
//   }
// }

// extension StoryFailureValue on StoryFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case StoryFailure.error:
//         return context.l10n.error;
//     }
//   }
// }

// extension CompanyFormFailureValue on CompanyFormFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case CompanyFormFailure.error:
//         return context.l10n.error;
//       case CompanyFormFailure.send:
//         return context.l10n.sendFailure;
//       case CompanyFormFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension ProfleFormFailureValue on ProfileFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case ProfileFailure.error:
//         return context.l10n.error;
//       case ProfileFailure.send:
//         return context.l10n.sendFailure;
//       case ProfileFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension StoryAddFailureValue on StoryAddFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case StoryAddFailure.error:
//         return context.l10n.error;
//       case StoryAddFailure.send:
//         return context.l10n.sendFailure;
//       case StoryAddFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension WorkFailureValue on WorkFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case WorkFailure.error:
//         return context.l10n.error;
//     }
//   }
// }

// extension MyDiscountFailureValue on MyDiscountFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case MyDiscountFailure.error:
//         return context.l10n.error;
//       case MyDiscountFailure.get:
//         return context.l10n.getFailure;
//       case MyDiscountFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension HomeFailureValue on HomeFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case HomeFailure.error:
//         return context.l10n.error;
//       case HomeFailure.get:
//         return context.l10n.getFailure;
//       case HomeFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension MobFAQFailureValue on MobFAQFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case MobFAQFailure.error:
//         return context.l10n.error;
//       case MobFAQFailure.get:
//         return context.l10n.getFailure;
//       case MobFAQFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension MyStoryFailureValue on MyStoryFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case MyStoryFailure.error:
//         return context.l10n.error;
//       case MyStoryFailure.get:
//         return context.l10n.getFailure;
//       case MyStoryFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension PwResetEmailFailureValue on PwResetEmailFailure {
//   String value(BuildContext context) {
//     switch (this) {
//       case PwResetEmailFailure.error:
//         return context.l10n.error;
//       case PwResetEmailFailure.send:
//         return context.l10n.sendFailure;
//       case PwResetEmailFailure.network:
//         return context.l10n.networkFailure;
//       case PwResetEmailFailure.notFound:
//         return context.l10n.notFoundFailure;
//     }
//   }
// }

// extension PasswordResetFailureValue on PasswordResetFailure {
//   String? value(BuildContext context) {
//     switch (this) {
//       case PasswordResetFailure.error:
//         return context.l10n.error;
//       case PasswordResetFailure.send:
//         return context.l10n.sendFailure;
//       case PasswordResetFailure.network:
//         return context.l10n.networkFailure;
//     }
//   }
// }

// extension DiscountsAddFailureValue on DiscountsAddFailure {
//   String? value(BuildContext context) {
//     switch (this) {
//       case DiscountsAddFailure.error:
//         return context.l10n.error;
//       case DiscountsAddFailure.send:
//         return context.l10n.sendFailure;
//       case DiscountsAddFailure.network:
//         return context.l10n.networkFailure;
//       case DiscountsAddFailure.linkWrong:
//         return null;
//     }
//   }
// }
