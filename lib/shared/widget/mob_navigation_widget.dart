import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MobNavigationWidget extends StatelessWidget {
  const MobNavigationWidget({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.l10n.discounts,
      context.l10n.investors,
      context.l10n.settings,
      context.l10n.login,
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: KWidgetTheme.boxShadow,
      ),
      child: ClipRRect(
        borderRadius: KBorderRadius.kBorderRadiusTop32,
        clipBehavior: Clip.hardEdge,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: KSize.kPixel80),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return BottomNavigationBar(
                key: MobNavigationKeys.widget,
                items: List.generate(KIcon.pagesIcons.length, (index) {
                  return BottomNavigationBarItem(
                    key: MobNavigationKeys.navButtonsKey[index],
                    icon: Padding(
                      padding: const EdgeInsets.only(
                        bottom: KPadding.kPaddingSize8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: KPadding.kPaddingSize8,
                        ),
                        child: showProfile(state: state.status, index: index)
                            ? userPhoto
                            : KIcon.pagesIcons[index],
                      ),
                    ),
                    activeIcon: showProfile(state: state.status, index: index)
                        ? userPhoto
                        : IconWidget(
                            icon: KIcon.pagesIcons[index],
                            background: AppColors.materialThemeKeyColorsPrimary,
                            padding: KPadding.kPaddingSize8,
                          ),
                    label: showProfile(state: state.status, index: index)
                        ? context.l10n.myProfile
                        : labels[index],
                  );
                }),
                backgroundColor: AppColors.materialThemeKeyColorsNeutral,
                selectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
                unselectedLabelStyle: AppTextStyle.materialThemeLabelSmall,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                currentIndex: index,
                onTap: (i) => context.goNamed(
                  showProfile(state: state.status, index: i)
                      ? KRoute.profile.name
                      : KAppText.routes[i],
                ),
                type: BottomNavigationBarType.fixed,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get userPhoto =>
      BlocSelector<UserWatcherBloc, UserWatcherState, String?>(
        selector: (state) => state.user.photo,
        builder: (context, userPhoto) {
          return UserPhotoWidget(
            onPressed: null,
            imageUrl: userPhoto,
            imageSize: KSize.kbottomNavigationUserPhoto,
          );
        },
      );

  bool showProfile({
    required AuthenticationStatus state,
    required int index,
  }) =>
      state.isAuthenticated && index == 3;
}
