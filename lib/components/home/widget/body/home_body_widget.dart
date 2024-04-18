import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile =
          constraints.maxWidth < KPlatformConstants.minWidthThresholdMobile;
      final isTablet = constraints.maxWidth >=
              KPlatformConstants.minWidthThresholdMobile &&
          constraints.maxWidth < KPlatformConstants.minWidthThresholdDesktop;
      final isDesk =
          KPlatformConstants.changeToDescWidget(constraints.maxWidth);
      return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
        builder: (context, state) {
          switch (state) {
            case HomeWatcherStateInitial():
              return const CircularProgressIndicator.adaptive();
            case HomeWatcherStateLoading():
              return const CircularProgressIndicator.adaptive();
            case HomeWatcherStateSuccess():
              final questionModelItems = state.questionModelItems;
              return ListView.builder(
                  key: KWidgetkeys.widget.shellRoute.scroll,
                  itemCount: 1,
                  padding: EdgeInsets.only(
                    left: KPadding.kPaddingSize75 *
                        (isMobile
                            ? KPlatformConstants.mobilePaddingKoefficient
                            : (isTablet
                                ? KPlatformConstants.tabletPaddingKoefficient
                                : KPlatformConstants
                                    .desktopPaddingKoefficient)),
                    right: KPadding.kPaddingSize75 *
                        (isMobile
                            ? KPlatformConstants.mobilePaddingKoefficient
                            : (isTablet
                                ? KPlatformConstants.tabletPaddingKoefficient
                                : KPlatformConstants
                                    .desktopPaddingKoefficient)),
                    top: KPadding.kPaddingSize10,
                  ),
                  primary: true,
                  itemBuilder: (context, index) => Column(
                        children: [
                          if (isDesk)
                            KSizedBox.kHeightSizedBox24
                          else
                            KSizedBox.kHeightSizedBox16,
                          BoxesWidget(
                            isDesk: isDesk,
                          ),
                          if (isDesk)
                            KSizedBox.kHeightSizedBox160
                          else
                            KSizedBox.kHeightSizedBox40,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    KPadding.kPaddingSize16),
                                child: Text(
                                  context.l10n.faq,
                                  key:
                                      KWidgetkeys.screen.home.questionListTitle,
                                  style: isDesk
                                      ? AppTextStyle.text96
                                      : AppTextStyle.text48,
                                ),
                              ),
                              if (questionModelItems.isNotEmpty)
                                ListQuestionWidget(
                                  questionModelItem: questionModelItems[index],
                                  isDesk: isDesk,
                                )
                              else
                                TextButton(
                                  key: KWidgetkeys.screen.home.buttonMock,
                                  onPressed: () {
                                    GetIt.I
                                        .get<IHomeRepository>()
                                        .addMockQuestions();
                                    context
                                        .read<HomeWatcherBloc>()
                                        .add(const HomeWatcherEvent.started());
                                  },
                                  child: Text(
                                    context.l10n.getMockData,
                                    style: AppTextStyle.text32,
                                  ),
                                ),
                            ],
                          ),
                          if (isDesk)
                            KSizedBox.kHeightSizedBox160
                          else
                            KSizedBox.kHeightSizedBox40,
                          FeedbackWidget(
                            isDesk: isDesk,
                          ),
                          if (isDesk)
                            KSizedBox.kHeightSizedBox160
                          else
                            KSizedBox.kHeightSizedBox10,
                          FooterWidget(isDesktop: isDesk),
                        ],
                      ));

            case HomeWatcherStateFailure():
            default:
              return const CircularProgressIndicator.adaptive();
          }
        },
      );
    });
  }
}
