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
        BlocListener<UrlCubit, UrlEnum?>(
          listener: (context, state) async {
            if (state != null) {
              context.dialog.showSnackBardTextDialog(
                state.value(context),
                duration: const Duration(milliseconds: 4000),
              );
              context.read<UrlCubit>().reset();
            }
          },
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
