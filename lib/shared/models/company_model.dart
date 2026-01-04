import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:veteranam/shared/models/convertors/image_convertor.dart';
import 'package:veteranam/shared/models/enums/subscription_enums.dart';
import 'package:veteranam/shared/models/helper_models/image_model.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
abstract class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String id,
    required List<String> userEmails,
    String? companyName,
    String? publicName,
    String? code,
    String? link,
    @ImageConverter() ImageModel? image,
    DateTime? deletedOn,
    String? stripeCustomerId,
    String? stripeSubscriptionId,
    SubscriptionStatus? subscriptionStatus,
    SubscriptionPlan? subscriptionPlan,
    DateTime? trialStartedAt,
    DateTime? trialExpiresAt,
    DateTime? subscriptionStartedAt,
    DateTime? subscriptionExpiresAt,
    bool? termsAccepted,
    DateTime? termsAcceptedAt,
    int? trialExtensionDays,
    String? canceledBy,
    DateTime? canceledAt,
  }) = _CompanyModel;

  // Add this private constructor
  const CompanyModel._();

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  static const empty = CompanyModel(id: '', userEmails: []);

  bool get isEmpty =>
      id.isEmpty ||
      companyName == null ||
      companyName!.isEmpty ||
      publicName == null ||
      publicName!.isEmpty ||
      code == null ||
      code!.isEmpty ||
      userEmails.isEmpty
      // ||
      // link == null ||
      // link!.isEmpty
      // ||
      // image == null ||
      // image!.downloadURL.isEmpty
      ;
  bool get isNotEmpty => !isEmpty;

  bool get isSubscriptionActive =>
      subscriptionStatus == SubscriptionStatus.active ||
      subscriptionStatus == SubscriptionStatus.trialing;

  bool get canCreateDiscounts =>
      (termsAccepted ?? false) && isSubscriptionActive && !isTrialExpired;

  bool get isTrialExpired =>
      trialExpiresAt != null && DateTime.now().isAfter(trialExpiresAt!);

  bool get isInTrial =>
      subscriptionStatus == SubscriptionStatus.trialing && !isTrialExpired;

  int get trialDaysRemaining {
    if (trialExpiresAt == null || isTrialExpired) return 0;
    return trialExpiresAt!.difference(DateTime.now()).inDays;
  }

  bool get needsPaymentAction =>
      subscriptionStatus == SubscriptionStatus.incomplete ||
      subscriptionStatus == SubscriptionStatus.incompleteExpired ||
      subscriptionStatus == SubscriptionStatus.pastDue ||
      subscriptionStatus == SubscriptionStatus.unpaid;
}

abstract class CompanyModelJsonField {
  static const id = 'id';
  static const companyName = 'companyName';
  static const publicName = 'publicName';
  static const userEmails = 'userEmails';
  static const link = 'link';
  static const code = 'code';
  static const image = 'image';
  static const deletedOn = 'deletedOn';
  static const stripeCustomerId = 'stripeCustomerId';
  static const stripeSubscriptionId = 'stripeSubscriptionId';
  static const subscriptionStatus = 'subscriptionStatus';
  static const subscriptionPlan = 'subscriptionPlan';
  static const trialStartedAt = 'trialStartedAt';
  static const trialExpiresAt = 'trialExpiresAt';
  static const subscriptionStartedAt = 'subscriptionStartedAt';
  static const subscriptionExpiresAt = 'subscriptionExpiresAt';
  static const termsAccepted = 'termsAccepted';
  static const termsAcceptedAt = 'termsAcceptedAt';
  static const trialExtensionDays = 'trialExtensionDays';
  static const canceledBy = 'canceledBy';
  static const canceledAt = 'canceledAt';
}
