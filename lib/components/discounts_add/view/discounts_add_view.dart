import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discounts_add/discounts_add.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsAddScreen extends StatelessWidget {
  const DiscountsAddScreen({
    required this.discount,
    required this.discountId,
    super.key,
  });
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyWatcherBloc, CompanyWatcherState>(
      listener: (context, state) {
        // Guard: Prevent access if company cannot create discounts
        if (!state.company.canCreateDiscounts) {
          // Redirect to My Discounts page where they'll see
          // appropriate messaging
          context.goNamed(KRoute.myDiscounts.name);
        }
      },
      child: BlocBuilder<CompanyWatcherBloc, CompanyWatcherState>(
        builder: (context, state) {
          // Additional check to prevent rendering if no valid subscription
          if (!state.company.canCreateDiscounts) {
            // Show loading or redirect message while navigation occurs
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return DiscountsAddBlocprovider(
            key: DiscountsAddKeys.screen,
            childWidget: DiscountsAddBodyWidget(
              discountId: discountId,
            ),
            discount: discount,
            discountId: discountId,
          );
        },
      ),
    );
  }
}
