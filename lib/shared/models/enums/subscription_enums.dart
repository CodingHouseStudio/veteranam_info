/// Represents the current state of a company's subscription
enum SubscriptionStatus {
  incomplete,

  incompleteExpired,

  trialing,

  active,

  pastDue,

  canceled,

  unpaid,

  expired;

  bool get isActive => this == active || this == trialing;

  bool get needsAction =>
      this == incomplete ||
      this == incompleteExpired ||
      this == pastDue ||
      this == unpaid;

  bool get isEnded => this == canceled || this == expired;

  String toJson() => name;

  static SubscriptionStatus fromJson(String json) {
    return SubscriptionStatus.values.firstWhere(
      (e) => e.name == json,
      orElse: () => SubscriptionStatus.incomplete,
    );
  }
}

enum SubscriptionPlan {
  basic,

  premium,

  enterprise;

  String get displayName {
    switch (this) {
      case SubscriptionPlan.basic:
        return 'Basic Plan';
      case SubscriptionPlan.premium:
        return 'Premium Plan';
      case SubscriptionPlan.enterprise:
        return 'Enterprise Plan';
    }
  }

  double get monthlyPrice {
    switch (this) {
      case SubscriptionPlan.basic:
        return 29;
      case SubscriptionPlan.premium:
        return 79;
      case SubscriptionPlan.enterprise:
        return 199;
    }
  }

  String toJson() => name;

  static SubscriptionPlan fromJson(String json) {
    return SubscriptionPlan.values.firstWhere(
      (e) => e.name == json,
      orElse: () => SubscriptionPlan.basic,
    );
  }
}

enum PaymentStatus {
  pending,

  succeeded,

  failed,

  refunded,

  partiallyRefunded;

  bool get isSuccessful => this == succeeded;

  bool get needsAction => this == pending || this == failed;

  String toJson() => name;

  static PaymentStatus fromJson(String json) {
    return PaymentStatus.values.firstWhere(
      (e) => e.name == json,
      orElse: () => PaymentStatus.pending,
    );
  }
}

enum PaymentType {
  subscription,

  setup,

  refund,

  adjustment;

  String toJson() => name;

  static PaymentType fromJson(String json) {
    return PaymentType.values.firstWhere(
      (e) => e.name == json,
      orElse: () => PaymentType.subscription,
    );
  }
}
