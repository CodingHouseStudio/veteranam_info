import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

class LanguagesSwitcherWidget extends StatelessWidget {
  const LanguagesSwitcherWidget({this.decoration, super.key});

  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return CustomSwitcherWidget<Language>(
          decoration: decoration,
          values: Language.values,
          getText: (value) => value.text,
          isCheck: (value) => value == state.userSetting.locale,
          onSwitch: () => context.read<AuthenticationBloc>().add(
                const AppLanguageChanged(),
              ),
        );
      },
    );
  }
}
