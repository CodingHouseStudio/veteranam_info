import 'package:flutter/material.dart';
import 'package:kozak/components/components.dart';

class StoryAddScreen extends StatelessWidget {
  const StoryAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoryAddBlocprovider(childWidget: StoryAddBody());
  }
}
