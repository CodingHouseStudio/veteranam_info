part of 'discount_config_cubit.dart';

class DiscountConfigState extends Equatable {
  const DiscountConfigState({
    required this.emailScrollCount,
    required this.loadingItems,
    required this.linkScrollCount,
    required this.emailCloseDelay,
    required this.mobFilterEnhancedMobile,
    required this.enableVerticalDiscount,
    required this.mobileShowCount,
  });

  final int emailScrollCount;
  final int loadingItems;
  final int linkScrollCount;
  final int emailCloseDelay;
  final bool mobFilterEnhancedMobile;
  final bool enableVerticalDiscount;
  final bool mobileShowCount;

  @override
  List<Object?> get props => [
        emailScrollCount,
        loadingItems,
        linkScrollCount,
        emailCloseDelay,
        mobFilterEnhancedMobile,
        enableVerticalDiscount,
        mobileShowCount,
      ];
}
