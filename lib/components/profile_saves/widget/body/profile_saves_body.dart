import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/discounts/bloc/discount_watcher_bloc.dart';
import 'package:kozak/shared/shared.dart';

class ProfileSavesBody extends StatelessWidget {
  const ProfileSavesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
        switch (state.loadingStatus) {
          case LoadingStatus.listLoadedFull:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.initial:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loading:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.error:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loaded:
            return ScaffoldWidget(
              titleChildWidgetsFunction: ({required isDesk}) => [
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                ...TitleWidget.titleWidgetList(
                  title: context.l10n.saved,
                  titleKey: KWidgetkeys.screen.profileSaves.title,
                  subtitle: context.l10n.savesSubtitle,
                  subtitleKey: KWidgetkeys.screen.profileSaves.subtitle,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
              ],
              mainDeskPadding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize220,
              ),
              mainChildWidgetsFunction:
                  ({required isDesk, required isTablet}) => [
                DiscountsCardWidget(
                  key: KWidgetkeys.screen.profileSaves.discountCard,
                  isDesk: isDesk,
                  discountItem: state.filteredDiscountModelItems.elementAt(0),
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                WorkCardWidget(
                  isSaved: false,
                  key: KWidgetkeys.screen.profileSaves.workCard,
                  workModel: const WorkModel(
                    id: '',
                    title: KMockText.workTitle,
                    price: KMockText.workPrice,
                    employerContact: KMockText.workCity,
                    companyName: KMockText.workEmployer,
                    description: KMockText.workDescription,
                  ),
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
              ],
            );
        }
      },
    );
  }
}
