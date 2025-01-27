import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/feedback.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackBodyWidget extends StatelessWidget {
  const FeedbackBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedbackBlocListener(
      childWidget: FocusTraversalGroup(
        child: Semantics(
          child: CustomScrollView(
            key: ScaffoldKeys.scroll,
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              const NetworkBanner(),
              if (Config.isWeb) const NavigationBarWidget(),
              BlocBuilder<AppLayoutBloc, AppLayoutState>(
                buildWhen: (previous, current) =>
                    previous.appVersionEnum.isDesk !=
                    current.appVersionEnum.isDesk,
                builder: (context, state) => SliverCenter(
                  appVersionEnum: state.appVersionEnum,
                  sliver: SliverPadding(
                    padding: state.appVersionEnum.paddingWithTablet,
                    sliver: SliverConstrainedCrossAxis(
                      maxExtent: KPlatformConstants.maxWidthThresholdDesk,
                      sliver: SliverMainAxisGroup(
                        slivers: [
                          if (!Config.isWeb) ...[
                            KSizedBox.kHeightSizedBox8.toSliver,
                            SliverToBoxAdapter(
                              child: BackButtonWidget(
                                backPageName: null,
                                pathName: KRoute.settings.name,
                              ),
                            ),
                          ],
                          FeedbackFormStateWidget(
                            isDesk: state.appVersionEnum.isDesk,
                          ),
                          if (state.appVersionEnum.isDesk)
                            KSizedBox.kHeightSizedBox100.toSliver
                          else
                            KSizedBox.kHeightSizedBox32.toSliver,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
