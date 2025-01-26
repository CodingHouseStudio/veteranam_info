import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsBlocListener extends StatelessWidget {
  const DiscountsBlocListener({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<DiscountsWatcherBloc>().add(
                    const DiscountsWatcherEvent.started(),
                  );
            }
          },
        ),
        const BlocListener<UrlCubit, UrlEnum?>(
          listener: UrlCubitExtension.listener,
        ),
        BlocListener<DiscountsWatcherBloc, DiscountsWatcherState>(
          listener: (context, state) {
            if (state.failure != null) {
              context.dialog.showGetErrorDialog(
                error: state.failure!.value(context),
                onPressed:
                    state.filterStatus == FilterStatus.error ? null : () {},
                // I think this event is not necessary for Stream, but
                // I think it's better to give
                // the user imaginary control over it

                // () => context
                //     .read<DiscountWatcherBloc>()
                //     .add(const DiscountWatcherEvent.started()),
              );
            }

            if (context.read<UserEmailFormBloc>().state.emailEnum.show) {
              if (state.filterDiscountModelList.length ==
                  (context.read<DiscountConfigCubit>().state.loadingItems *
                      (context
                              .read<DiscountConfigCubit>()
                              .state
                              .emailScrollCount +
                          1))) {
                // if (Config.isWeb) {
                if (context.read<UserWatcherBloc>().state.user.email?.isEmpty ??
                    true) {
                  context.dialog.showUserEmailDialog(
                    context.read<DiscountConfigCubit>().state.emailCloseDelay,
                  );
                }
              }
              // } else {
              //   context.read<MobileRatingCubit>().showDialog();
              // }
            }
          },
          listenWhen: (previous, current) =>
              current.failure != null ||
              previous.filterDiscountModelList.length !=
                  current.filterDiscountModelList.length,
        ),
        if (!Config.isWeb)
          const BlocListener<AppVersionCubit, AppVersionState>(
            listener: AppVersionCubitExtension.listener,
          ),
        BlocListener<DiscountLinkCubit, bool>(
          listener: (context, state) {},
        ),
      ],
      child: childWidget,
    );
  }
}
