import 'package:flutter/material.dart';
import 'package:veteranam/components/company/company.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompanyBlocprovider(
      childWidget: CompanyBodyWidget(
        key: CompanyKeys.screen,
      ),
    );
  }
}
