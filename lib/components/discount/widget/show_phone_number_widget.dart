import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ShowPhoneNumberWidget extends StatefulWidget {
  const ShowPhoneNumberWidget({required this.phoneNumber, super.key});
  final String phoneNumber;

  @override
  State<ShowPhoneNumberWidget> createState() => _ShowPhoneNumberWidgetState();
}

class _ShowPhoneNumberWidgetState extends State<ShowPhoneNumberWidget> {
  late bool showPhoneNumber;
  @override
  void initState() {
    showPhoneNumber = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: TextButton.icon(
        onPressed: () => setState(() => showPhoneNumber = true),
        icon: KIcon.call,
        label: Text(
          showPhoneNumber ? widget.phoneNumber : context.l10n.showPhoneNumber,
          style: AppTextStyle.materialThemeLabelLargeUnderLine,
        ),
      ),
    );
  }
}