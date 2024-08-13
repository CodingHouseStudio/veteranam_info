import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
          if (state.formState != LinkEnum.initial &&
              state.formState != LinkEnum.inProgress) {
            controller.clear();
          }
          if (state.formState == LinkEnum.success) {
            context.read<DiscountLinkCubit>().started();
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
          // filedErrorText:
          //     context.read<DiscountLinkFormBloc>().state.formState ==
          //             LinkEnum.invalidData
          //         ? context
          //             .read<DiscountLinkFormBloc>()
          //             .state
          //             .link
          //             .error
          //             .value(context)
          //         : null,
          enabled: context.read<DiscountLinkCubit>().state,
          showThankText: context.read<DiscountLinkFormBloc>().state.formState !=
                  LinkEnum.initial &&
              context.read<DiscountLinkFormBloc>().state.formState !=
                  LinkEnum.inProgress,
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
