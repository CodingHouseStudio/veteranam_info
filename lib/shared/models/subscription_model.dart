import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/enums/subscription_enums.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
abstract class SubscriptionModel with _$SubscriptionModel {
  const factory SubscriptionModel({
    required String id,
    required String companyId,
    required String stripeSubscriptionId,
    required String stripeCustomerId,
    required SubscriptionStatus status,
    required SubscriptionPlan plan,
    required String priceId,
    required double amount,
    required DateTime createdAt, required DateTime updatedAt, @Default('usd') String currency,
    DateTime? trialStartedAt,
    DateTime? trialExpiresAt,
    DateTime? currentPeriodStart,
    DateTime? currentPeriodEnd,
    DateTime? canceledAt,
    @Default(false) bool cancelAtPeriodEnd,
    Map<String, dynamic>? metadata,
  }) = _SubscriptionModel;

  const SubscriptionModel._();

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  static final empty = SubscriptionModel(
    id: '',
    companyId: '',
    stripeSubscriptionId: '',
    stripeCustomerId: '',
    status: SubscriptionStatus.incomplete,
    plan: SubscriptionPlan.basic,
    priceId: '',
    amount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  bool get isEmpty => id.isEmpty;

  bool get isActive => status.isActive;

  bool get isTrialing => status == SubscriptionStatus.trialing;

  bool get needsAction => status.needsAction;

  int get daysUntilNextBilling {
    final targetDate = trialExpiresAt ?? currentPeriodEnd;
    if (targetDate == null) return 0;
    if (DateTime.now().isAfter(targetDate)) return 0;
    return targetDate.difference(DateTime.now()).inDays;
  }
}

abstract class SubscriptionModelJsonField {
  static const id = 'id';
  static const companyId = 'companyId';
  static const stripeSubscriptionId = 'stripeSubscriptionId';
  static const stripeCustomerId = 'stripeCustomerId';
  static const status = 'status';
  static const plan = 'plan';
  static const priceId = 'priceId';
  static const amount = 'amount';
  static const currency = 'currency';
  static const trialStartedAt = 'trialStartedAt';
  static const trialExpiresAt = 'trialExpiresAt';
  static const currentPeriodStart = 'currentPeriodStart';
  static const currentPeriodEnd = 'currentPeriodEnd';
  static const canceledAt = 'canceledAt';
  static const cancelAtPeriodEnd = 'cancelAtPeriodEnd';
  static const metadata = 'metadata';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}
