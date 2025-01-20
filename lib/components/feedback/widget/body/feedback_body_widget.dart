import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/components/feedback/feedback.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackBodyWidget extends StatelessWidget {
  const FeedbackBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final padding = EdgeInsets.symmetric(
          horizontal: isDesk
              ? KPadding.kPaddingSize90 +
                  ((constraints.maxWidth >
                          KPlatformConstants.maxWidthThresholdTablet)
                      ? (constraints.maxWidth -
                              KPlatformConstants.maxWidthThresholdTablet) /
                          2
                      : 0)
              : KPadding.kPaddingSize16,
        );
        return MultiBlocListener(
          listeners: [
            BlocListener<FeedbackBloc, FeedbackState>(
              listenWhen: (previous, current) =>
                  current.failure != null ||
                  current.failure != previous.failure,
              listener: (context, state) {
                context.dialog.showSnackBardTextDialog(
                  state.failure?.value(context),
                );
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
            if (!Config.isWeb)
              BlocListener<AppVersionCubit, AppVersionState>(
                listener: (context, state) =>
                    context.dialog.showMobUpdateAppDialog(
                  hasNewVersion: state.mobHasNewBuild,
                ),
              ),
          ],
          child: FocusTraversalGroup(
            child: Semantics(
              child: CustomScrollView(
                key: ScaffoldKeys.scroll,
                cacheExtent: KDimensions.listCacheExtent,
                slivers: [
                  NetworkBanner(
                    isDesk: isDesk,
                    isTablet: isTablet,
                  ),
                  if (Config.isWeb)
                    NavigationBarWidget(
                      isDesk: isDesk,
                      isTablet: isTablet,
                    ),
                  if (!Config.isWeb) ...[
                    KSizedBox.kHeightSizedBox8.toSliver,
                    SliverPadding(
                      padding: padding,
                      sliver: SliverToBoxAdapter(
                        child: BackButtonWidget(
                          backPageName: null,
                          pathName: KRoute.settings.name,
                        ),
                      ),
                    ),
                  ],
                  SliverPadding(
                    padding: padding,
                    sliver: FeedbackFormStateWidget(
                      isDesk: isDesk,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: isDesk
                        ? KSizedBox.kHeightSizedBox100
                        : KSizedBox.kHeightSizedBox32,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class FeedbackBodyWidget extends StatefulWidget {
//   const FeedbackBodyWidget({super.key});

//   @override
//   State<FeedbackBodyWidget> createState() => _FeedbackBodyWidgetState();
// }

// class _FeedbackBodyWidgetState extends State<FeedbackBodyWidget> {
//   late TextEditingController nameController;
//   late TextEditingController emailController;
//   late TextEditingController messageController;
//   @override
//   void initState() {
//     nameController = TextEditingController();
//     emailController = TextEditingController();
//     messageController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FeedbackBloc, FeedbackState>(
//       listener: (context, state) {
//         if (state.formState == FeedbackEnum.initial) {
//           nameController.clear();
//           emailController.clear();
//           messageController.clear();
//         }
//         context.dialog.showSnackBardTextDialog(
//           state.failure?.value(context),
//         );
//       },
//       buildWhen: (previous, current) =>
//           current.failure != null || previous.formState != current.formState,
//       builder: (context, state) {
//         return ScaffoldWidget(
//           showMobBottomNavigation: false,
//           showMobNawbarBackButton: true,
//           pageName: context.l10n.feedback,
//           mainChildWidgetsFunction:
//({required isDesk, required isTablet}) => [
//             if (context.read<FeedbackBloc>().state.formState ==
//                     FeedbackEnum.success ||
//                 context.read<FeedbackBloc>().state.formState ==
//                     FeedbackEnum.sendingMessage) ...[
//               FeedbackTitle(
//                 isDesk: isDesk,
//                 title: context.l10n.thanks,
//                 // secondText: context.l10n.thanks,
//               ),
//               FeedbackBoxWidget(
//                 isDesk: isDesk,
//                 sendAgain: () => context
//                     .read<FeedbackBloc>()
//                     .add(const FeedbackEvent.sendignMessageAgain()),
//               ),
//             ] else ...[
//               FeedbackTitle(
//                 isDesk: isDesk,
//                 title: context.l10n.write,
//                 titleSecondPart:
//'${context.l10n.us} ${context.l10n.aMessage}',
//                 // text: '${context.l10n.write} ${context.l10n.us}',
//                 // secondText: context.l10n.aMessage,
//               ),
//               FormWidget(
//                 isDesk: isDesk,
//                 nameController: nameController,
//                 emailController: emailController,
//                 messageController: messageController,
//               ),
//             ],
//             if (isDesk)
//               KSizedBox.kHeightSizedBox100
//             else
//               KSizedBox.kHeightSizedBox32,
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     messageController.dispose();
//     super.dispose();
//   }
// }
