import 'package:flutter/material.dart';
import 'package:veteranam/components/business_dashboard/business_dashboard.dart';
import 'package:veteranam/shared/shared.dart';

class BusinessDashboardScreen extends StatelessWidget {
  const BusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessDashboardBodyWidget(
      key: KWidgetkeys.screen.businessDashboard.screen,
    );
  }
}
