import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountBlocListener extends StatelessWidget {
  const DiscountBlocListener({
    required this.discountId,
    required this.child,
    super.key,
  });
  final String? discountId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        const BlocListener<UrlCubit, UrlEnum?>(
          listener: UrlCubitExtension.listener,
        ),
        BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<DiscountWatcherBloc>().add(
                    DiscountWatcherEvent.started(
                      discountId,
                    ),
                  );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
