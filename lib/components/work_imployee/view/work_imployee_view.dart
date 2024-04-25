import 'package:flutter/material.dart';

class WorkImployeeScreen extends StatelessWidget {
  const WorkImployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkEmployeeBlocprovider(childWidget:WorkImployeeBody(),);
  }
}
