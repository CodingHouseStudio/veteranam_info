import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/profile/bloc/profile_bloc.dart';

class ProfileBlocprovider extends StatelessWidget {
  const ProfileBlocprovider({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I.get<ProfileBloc>()..add(const ProfileEvent.started()),
      child: childWidget,
    );
  }
}
