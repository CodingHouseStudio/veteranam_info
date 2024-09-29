import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/privacy_policy/privacy_policy.dart';

class PrivacyPolicyBlocprovider extends StatelessWidget {
  const PrivacyPolicyBlocprovider({required this.widgetChild, super.key});
  final Widget widgetChild;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<PrivacyPolicyMarkdownCubit>()..init(),
      child: widgetChild,
    );
  }
}
