import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:veteranam/shared/models/enums/subscription_enums.dart';

part 'payment_history_model.freezed.dart';
part 'payment_history_model.g.dart';

@freezed
abstract class PaymentHistoryModel with _$PaymentHistoryModel {
  const factory PaymentHistoryModel({
    required String id,
    required String companyId,
    required double amount,
    required PaymentStatus status,
    required PaymentType type,
    required DateTime createdAt,
    String? subscriptionId,
    String? stripePaymentIntentId,
    String? stripeInvoiceId,
    @Default('usd') String currency,
    String? failureReason,
    String? receiptUrl,
    Map<String, dynamic>? metadata,
    DateTime? paidAt,
  }) = _PaymentHistoryModel;

  const PaymentHistoryModel._();

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryModelFromJson(json);

  static final empty = PaymentHistoryModel(
    id: '',
    companyId: '',
    amount: 0,
    status: PaymentStatus.pending,
    type: PaymentType.subscription,
    createdAt: DateTime.now(),
  );

  bool get isEmpty => id.isEmpty;

  bool get isSuccessful => status.isSuccessful;

  bool get isFailed => status == PaymentStatus.failed;

  bool get isPending => status == PaymentStatus.pending;

  bool get isRefunded =>
      status == PaymentStatus.refunded ||
      status == PaymentStatus.partiallyRefunded;

  String get statusText {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.succeeded:
        return 'Successful';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
      case PaymentStatus.partiallyRefunded:
        return 'Partially Refunded';
    }
  }

  String get typeText {
    switch (type) {
      case PaymentType.subscription:
        return 'Subscription Payment';
      case PaymentType.setup:
        return 'Setup Payment';
      case PaymentType.refund:
        return 'Refund';
      case PaymentType.adjustment:
        return 'Adjustment';
    }
  }
}

abstract class PaymentHistoryModelJsonField {
  static const id = 'id';
  static const companyId = 'companyId';
  static const subscriptionId = 'subscriptionId';
  static const stripePaymentIntentId = 'stripePaymentIntentId';
  static const stripeInvoiceId = 'stripeInvoiceId';
  static const amount = 'amount';
  static const currency = 'currency';
  static const status = 'status';
  static const type = 'type';
  static const failureReason = 'failureReason';
  static const receiptUrl = 'receiptUrl';
  static const metadata = 'metadata';
  static const createdAt = 'createdAt';
  static const paidAt = 'paidAt';
}
