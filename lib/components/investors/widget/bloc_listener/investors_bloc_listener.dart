import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsBlocListener extends StatelessWidget {
  const InvestorsBlocListener({required this.childWidget, super.key});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<InvestorsWatcherBloc>().add(
                    const InvestorsWatcherEvent.started(),
                  );
            }
          },
        ),
        BlocListener<InvestorsWatcherBloc, InvestorsWatcherState>(
          listener: (context, state) => context.dialog.showGetErrorDialog(
            error: state.failure?.value(context),
            onPressed: () => context
                .read<InvestorsWatcherBloc>()
                .add(const InvestorsWatcherEvent.started()),
          ),
        ),
      ],
      child: childWidget,
    );
  }
}
