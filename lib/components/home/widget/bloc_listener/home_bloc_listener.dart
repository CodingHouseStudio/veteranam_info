import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeBlocListener extends StatelessWidget {
  const HomeBlocListener({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<HomeWatcherBloc>().add(
                    const HomeWatcherEvent.started(),
                  );
            }
          },
        ),
        const BlocListener<UrlCubit, UrlEnum?>(
          listener: UrlCubitExtension.listener,
        ),
        BlocListener<HomeWatcherBloc, HomeWatcherState>(
          listener: (context, state) => context.dialog.showGetErrorDialog(
            error: state.failure?.value(context),
            onPressed: () => context
                .read<HomeWatcherBloc>()
                .add(const HomeWatcherEvent.started()),
          ),
        ),
      ],
      child: childWidget,
    );
  }
}
