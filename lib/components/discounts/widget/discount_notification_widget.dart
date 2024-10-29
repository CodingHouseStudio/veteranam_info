import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountNotificationWidget extends StatefulWidget {
  const DiscountNotificationWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  State<DiscountNotificationWidget> createState() =>
      _DiscountNotificationWidgetState();
}

class _DiscountNotificationWidgetState
    extends State<DiscountNotificationWidget> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<DiscountLinkFormBloc>(),
      child: BlocConsumer<DiscountLinkFormBloc, DiscountLinkFormState>(
        listener: (context, state) {
          // if (state.formState != LinkEnum.initial &&
          //     state.formState != LinkEnum.inProgress) {
          //   controller.clear();
          // }
          if (state.formState == LinkEnum.success) {
            context.read<DiscountLinkCubit>().started();
            controller.clear();
          }
        },
        builder: (context, _) => NotificationLinkWidget(
          onChanged: (text) => context.read<DiscountLinkFormBloc>().add(
                DiscountLinkFormEvent.updateLink(text),
              ),
          isDesk: widget.isDesk,
          title: context.l10n.discountLinkTitle,
          sendOnPressed: () => context.read<DiscountLinkFormBloc>().add(
                const DiscountLinkFormEvent.sendLink(),
              ),
          fieldController: controller,
          // showErrorText: context.read<DiscountLinkFormBloc>().state.formState
          // ==
          //     LinkEnum.invalidData,
          // filedErrorText: context
          //     .read<DiscountLinkFormBloc>()
          //     .state
          //     .link
          //     .error
          //     .value(context),
          enabled: context.read<DiscountLinkCubit>().state,
          showThankText: context.read<DiscountLinkFormBloc>().state.formState ==
              LinkEnum.success,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
