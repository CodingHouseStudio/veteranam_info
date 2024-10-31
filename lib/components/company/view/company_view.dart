import 'package:flutter/material.dart';
import 'package:veteranam/components/company/company.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CompanyBlocprovider(
      childWidget: CompanyBodyWidget(
        key: KWidgetkeys.screen.company.screen,
      ),
    );
  }
}
