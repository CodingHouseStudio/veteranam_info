import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsBlocprovider extends StatelessWidget {
  const DiscountsBlocprovider({required this.childWidget, super.key});

  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountLinkCubit>(),
        ),
        // BlocProvider(
        //   create: (context) => GetIt.I.get<DiscountUserEmailCubit>()..
        // started(),
        // ),
        BlocProvider(
          create: (context) => GetIt.I.get<DiscountConfigCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<UserEmailFormBloc>(),
        ),
        if (!Config.isWeb)
          BlocProvider(
            create: (context) => GetIt.I.get<MobileRatingCubit>(),
          ),
        // if (Config.isWeb)
        BlocProvider(create: (context) => GetIt.I.get<ViewModeCubit>()),
      ],
      child: childWidget,
    );
  }
}
