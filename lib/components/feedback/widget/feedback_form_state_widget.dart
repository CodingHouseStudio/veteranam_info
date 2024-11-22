import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/components/feedback/feedback.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackFormStateWidget extends StatelessWidget {
  const FeedbackFormStateWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (previous, current) => previous.formState != current.formState,
      builder: (context, state) {
        if (context.read<FeedbackBloc>().state.formState ==
                FeedbackEnum.success ||
            context.read<FeedbackBloc>().state.formState ==
                FeedbackEnum.sendingMessage) {
          return SliverMainAxisGroup(
            slivers: [
              if (Config.isWeb)
                FeedbackTitle(
                  isDesk: isDesk,
                  title: context.l10n.thanks,
                  // secondText: context.l10n.thanks,
                )
              else
                const SliverToBoxAdapter(
                  child: KSizedBox.kHeightSizedBox24,
                ),
              SliverToBoxAdapter(
                child: FeedbackBoxWidget(
                  isDesk: isDesk,
                  sendAgain: () => context
                      .read<FeedbackBloc>()
                      .add(const FeedbackEvent.sendignMessageAgain()),
                ),
              ),
            ],
          );
        } else {
          return SliverMainAxisGroup(
            slivers: [
              if (Config.isWeb)
                FeedbackTitle(
                  isDesk: isDesk,
                  title: context.l10n.write,
                  titleSecondPart:
                      '${context.l10n.us} ${context.l10n.aMessage}',
                  // text: '${context.l10n.write} ${context.l10n.us}',
                  // secondText: context.l10n.aMessage,
                )
              else
                const SliverToBoxAdapter(
                  child: KSizedBox.kHeightSizedBox24,
                ),
              FormWidget(
                isDesk: isDesk,
              ),
            ],
          );
        }
      },
    );
  }
}
