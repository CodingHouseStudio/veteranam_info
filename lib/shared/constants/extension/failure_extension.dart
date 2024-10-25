import 'package:flutter/material.dart' show BuildContext;
import 'package:veteranam/components/components.dart'
    show
        CompanyFormFailure,
        DiscountFailure,
        DiscountsAddFailure,
        FeedbackFailure,
        HomeFailure,
        InformationFailure,
        InvestorsFailure,
        LoginFailure,
        MobFAQFailure,
        MyDiscountFailure,
        MyStoryFailure,
        PasswordResetFailure,
        ProfileFailure,
        PwResetEmailFailure,
        SignUpError,
        StoryAddFailure,
        StoryFailure,
        WorkFailure;
import 'package:veteranam/shared/shared.dart';

extension DiscountFailureValue on DiscountFailure {
  String value(BuildContext context) {
    switch (this) {
      case DiscountFailure.report:
      case DiscountFailure.error:
        return context.l10n.error;
    }
  }
}

extension FeedbackFailureValue on FeedbackFailure {
  String value(BuildContext context) {
    switch (this) {
      case FeedbackFailure.error:
        return context.l10n.error;
      case FeedbackFailure.send:
        return context.l10n.sendFailure;
      case FeedbackFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension InformationFailureValue on InformationFailure {
  String value(BuildContext context) {
    switch (this) {
      case InformationFailure.error:
        return context.l10n.error;
    }
  }
}

extension InvestorsFailureValue on InvestorsFailure {
  String value(BuildContext context) {
    switch (this) {
      case InvestorsFailure.error:
        return context.l10n.error;
      case InvestorsFailure.get:
        return context.l10n.getFailure;
      case InvestorsFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension LoginFailureValue on LoginFailure {
  String value(BuildContext context) {
    switch (this) {
      case LoginFailure.error:
        return context.l10n.error;
      case LoginFailure.send:
        return context.l10n.sendFailure;
      case LoginFailure.network:
        return context.l10n.networkFailure;
      case LoginFailure.notFound:
        return context.l10n.notFoundFailure;
    }
  }
}

extension SignUpFailureValue on SignUpError {
  String value(BuildContext context) {
    switch (this) {
      case SignUpError.error:
        return context.l10n.error;
      case SignUpError.send:
        return context.l10n.sendFailure;
      case SignUpError.network:
        return context.l10n.networkFailure;
      case SignUpError.duplicate:
        return context.l10n.dublicateFailure;
    }
  }
}

extension StoryFailureValue on StoryFailure {
  String value(BuildContext context) {
    switch (this) {
      case StoryFailure.error:
        return context.l10n.error;
    }
  }
}

extension CompanyFormFailureValue on CompanyFormFailure {
  String value(BuildContext context) {
    switch (this) {
      case CompanyFormFailure.error:
        return context.l10n.error;
      case CompanyFormFailure.send:
        return context.l10n.sendFailure;
      case CompanyFormFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension ProfleFormFailureValue on ProfileFailure {
  String value(BuildContext context) {
    switch (this) {
      case ProfileFailure.error:
        return context.l10n.error;
      case ProfileFailure.send:
        return context.l10n.sendFailure;
      case ProfileFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension StoryAddFailureValue on StoryAddFailure {
  String value(BuildContext context) {
    switch (this) {
      case StoryAddFailure.error:
        return context.l10n.error;
      case StoryAddFailure.send:
        return context.l10n.sendFailure;
      case StoryAddFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension WorkFailureValue on WorkFailure {
  String value(BuildContext context) {
    switch (this) {
      case WorkFailure.error:
        return context.l10n.error;
    }
  }
}

extension MyDiscountFailureValue on MyDiscountFailure {
  String value(BuildContext context) {
    switch (this) {
      case MyDiscountFailure.error:
        return context.l10n.error;
      case MyDiscountFailure.get:
        return context.l10n.getFailure;
      case MyDiscountFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension HomeFailureValue on HomeFailure {
  String value(BuildContext context) {
    switch (this) {
      case HomeFailure.error:
        return context.l10n.error;
      case HomeFailure.get:
        return context.l10n.getFailure;
      case HomeFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension MobFAQFailureValue on MobFAQFailure {
  String value(BuildContext context) {
    switch (this) {
      case MobFAQFailure.error:
        return context.l10n.error;
      case MobFAQFailure.get:
        return context.l10n.getFailure;
      case MobFAQFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension MyStoryFailureValue on MyStoryFailure {
  String value(BuildContext context) {
    switch (this) {
      case MyStoryFailure.error:
        return context.l10n.error;
      case MyStoryFailure.get:
        return context.l10n.getFailure;
      case MyStoryFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension UrlFailureExtension on SomeFailure {
  UrlEnum toUrl() {
    switch (this) {
      case FailureShare():
        return UrlEnum.shareError;
      case FailureLink():
        return UrlEnum.linkError;
      case FailureCopy():
        return UrlEnum.copyError;
      default:
        return UrlEnum.error;
    }
  }
}

extension PwResetEmailFailureValue on PwResetEmailFailure {
  String value(BuildContext context) {
    switch (this) {
      case PwResetEmailFailure.error:
        return context.l10n.error;
      case PwResetEmailFailure.send:
        return context.l10n.sendFailure;
      case PwResetEmailFailure.network:
        return context.l10n.networkFailure;
      case PwResetEmailFailure.notFound:
        return context.l10n.notFoundFailure;
    }
  }
}

extension PasswordResetFailureValue on PasswordResetFailure {
  String? value(BuildContext context) {
    switch (this) {
      case PasswordResetFailure.error:
        return context.l10n.error;
      case PasswordResetFailure.send:
        return context.l10n.sendFailure;
      case PasswordResetFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension DiscountsAddFailureValue on DiscountsAddFailure {
  String? value(BuildContext context) {
    switch (this) {
      case DiscountsAddFailure.error:
        return context.l10n.error;
      case DiscountsAddFailure.send:
        return context.l10n.sendFailure;
      case DiscountsAddFailure.network:
        return context.l10n.networkFailure;
      case DiscountsAddFailure.linkWrong:
        return null;
    }
  }
}
