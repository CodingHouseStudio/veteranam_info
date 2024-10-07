import 'package:flutter/material.dart';
import 'package:veteranam/components/components.dart'
    show
        DiscountFailure,
        FeedbackFailure,
        HomeFailure,
        InformationFailure,
        InvestorsFailure,
        LoginError,
        MobFAQFailure,
        MyDiscountFailure,
        MyStoryFailure,
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

extension LoginFailureValue on LoginError {
  String value(BuildContext context) {
    switch (this) {
      case LoginError.error:
        return context.l10n.error;
      case LoginError.send:
        return context.l10n.sendFailure;
      case LoginError.network:
        return context.l10n.networkFailure;
      case LoginError.notFound:
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
