import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

extension DiscountModelExtensions on List<DiscountModel> {
  List<String> getLocationFilter(BuildContext context) {
    final filter = [context.l10n.fromLargestToSmallest, context.l10n.free];
    final cities = context
        .read<DiscountWatcherBloc>()
        .state
        .discountModelItems
        .overallItems(
          getFilter: (item) => item.location ?? [],
          context: context,
        );
    final subLocation = SubLocation.all.getList(context);
    return [...filter, ...subLocation, ...cities];
  }
  // List<String> overallCategory(BuildContext context) {
  //   final allTags = <String>[];
  //   for (final item in this) {
  //     allTags.addAll(
  //       context.read<AuthenticationBloc>().state.userSetting.locale ==
  //               Language.english
  //           ? item.category
  //           : item.categoryUA,
  //     );
  //   }
  //   return allTags.toSet().toList();
  // }
}

// extension InformationModelExtensions on List<InformationModel> {
//   List<String> overallTags(BuildContext context) {
//     final allTags = <String>[];
//     for (final item in this) {
//       allTags.addAll(
//         context.read<AuthenticationBloc>().state.userSetting.locale ==
//                 Language.english
//             ? item.category
//             : item.categoryUA,
//       );
//     }
//     return allTags.toSet().toList();
//   }
// }

extension DiscountFailureValue on DiscountFailure {
  String value(BuildContext context) {
    switch (this) {
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
