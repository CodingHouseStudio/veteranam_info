import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountBlocprovider extends StatelessWidget {
  const DiscountBlocprovider({required this.childWidget, super.key});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountLinkCubit>()..started(),
        ),
        // BlocProvider(
        //   create: (context) => GetIt.I.get<DiscountUserEmailCubit>()..
        // started(),
        // ),
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountConfigCubit>()..started(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<UserEmailFormBloc>()
            ..add(const UserEmailFormEvent.started()),
        ),
        if (!Config.isWeb)
          BlocProvider(
            create: (context) => GetIt.I.get<MobileRatingCubit>(),
          ),
      ],
      child: Config.isWeb ? childWidget : SafeArea(child: childWidget),
    );
  }
}
