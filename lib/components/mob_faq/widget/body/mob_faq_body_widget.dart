import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class MobFaqBodyWidget extends StatelessWidget {
  const MobFaqBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MobFaqWatcherBloc, MobFaqWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () => context
            .read<MobFaqWatcherBloc>()
            .add(const MobFaqWatcherEvent.started()),
      ),
      builder: (context, _) {
        final isLoading = _.loadingStatus != LoadingStatus.loaded;
        final questionModelItems = isLoading
            ? List.generate(
                KDimensions.shimmerQuestionItems,
                (index) => KMockText.questionModel.copyWith(
                  id: index.toString(),
                ),
              )
            : _.questionModelItems;
        return ScaffoldWidget(
          showMobBottomNavigation: false,
          showMobNawbarBackButton: true,
          pageName: context.l10n.faq,
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
            if (_.questionModelItems.isEmpty &&
                _.loadingStatus == LoadingStatus.loaded &&
                Config.isDevelopment)
              MockButtonWidget(
                key: KWidgetkeys.screen.mobFaq.buttonMock,
                onPressed: () {
                  GetIt.I.get<IFaqRepository>().addMockQuestions();
                  context.read<MobFaqWatcherBloc>().add(
                        const MobFaqWatcherEvent.started(),
                      );
                },
              )
            else
              ...List.generate(
                  _.failure == null ? questionModelItems.length : 0, (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: KPadding.kPaddingSize24,
                  ),
                  child: SkeletonizerWidget(
                    isLoading: isLoading,
                    child: QuestionWidget(
                      key: KWidgetkeys.screen.mobFaq.list,
                      questionModel: questionModelItems.elementAt(index),
                      isDesk: false,
                    ),
                  ),
                );
              }),
            KSizedBox.kHeightSizedBox32,
          ],
        );
      },
    );
  }
}
