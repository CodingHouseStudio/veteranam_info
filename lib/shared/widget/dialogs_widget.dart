import 'dart:ui';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

extension DiaglogExtention on BuildContext {
  // ignore: library_private_types_in_public_api
  _DialogsWidget get dialog => _DialogsWidget.of(this);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showSnackBar({
    required Widget child,
    Color backgroundColor = AppColors.materialThemeKeyColorsSecondary,
    Key? key,
    Duration duration = const Duration(minutes: 1),
    DismissDirection? dismissDirection,
  }) {
    if (ScaffoldMessenger.of(this).mounted) {
      ScaffoldMessenger.of(this).hideCurrentSnackBar();
    }
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        key: key,
        backgroundColor: backgroundColor,
        content: child,
        duration: duration,
        dismissDirection: dismissDirection,
      ),
    );
  }
}

class _DialogsWidget {
  _DialogsWidget.of(this.context);
  final BuildContext context;

  void _doubleDialog({
    required Widget Function({
      required bool isDeskValue,
      required BuildContext context,
    }) childWidget,
    required bool isDesk,
    Widget Function({required Widget layoutBuilder})? preLayoutWidget,
    bool isScollable = true,
    Color? mobileBarierColor,
    Color? backgroundColor,
    EdgeInsets? deskInsetPadding,
    Widget Function(BuildContext context)? deskIcon,
    EdgeInsets? deskIconPadding,
    OverflowBarAlignment? deskActionsOverflowAlignment,
    EdgeInsets Function({required bool isDeskValue})? deskContentPadding,
    // EdgeInsets Function({required bool isDeskValue})? mobPadding,
    double? deskMaxWidth,
    double? mobMaxWidth,
    void Function()? onAppliedPressed,
    void Function()? onCancelPressed,
    void Function()? onClosePressed,
  }) {
    final layoutBloc = context.read<AppLayoutBloc>();
    if (isDesk) {
      showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider.value(
            value: layoutBloc,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: preLayoutWidget?.call(
                    layoutBuilder: _deskDoubleDialogWidget(
                      childWidget: childWidget,
                      isScollable: isScollable,
                      backgroundColor: backgroundColor,
                      insetPadding: deskInsetPadding,
                      icon: deskIcon,
                      iconPadding: deskIconPadding,
                      actionsOverflowAlignment: deskActionsOverflowAlignment,
                      contentPadding: deskContentPadding,
                      maxWidth: deskMaxWidth,
                    ),
                  ) ??
                  _deskDoubleDialogWidget(
                    childWidget: childWidget,
                    isScollable: isScollable,
                    backgroundColor: backgroundColor,
                    insetPadding: deskInsetPadding,
                    icon: deskIcon,
                    iconPadding: deskIconPadding,
                    actionsOverflowAlignment: deskActionsOverflowAlignment,
                    contentPadding: deskContentPadding,
                    maxWidth: deskMaxWidth,
                  ),
            ),
          );
        },
      ).then(
        (value) {
          switch (value) {
            case true:
              onAppliedPressed?.call();
            case false:
              onCancelPressed?.call();
            case null:
              onClosePressed?.call();
          }
        },
      );
    } else {
      showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: isScollable,
        useSafeArea: !Config.isWeb,
        barrierColor:
            mobileBarierColor ?? AppColors.materialThemeBlackOpacity88,
        backgroundColor:
            backgroundColor ?? AppColors.materialThemeKeyColorsNeutral,
        builder: (BuildContext context) {
          return preLayoutWidget?.call(
                layoutBuilder: _mobDoubleDialogWidget(
                  childWidget: childWidget,
                  // padding: mobPadding,
                  maxWidth: mobMaxWidth,
                  isScollable: isScollable,
                ),
              ) ??
              _mobDoubleDialogWidget(
                childWidget: childWidget,
                // padding: mobPadding,
                maxWidth: mobMaxWidth,
                isScollable: isScollable,
              );
        },
      ).then(
        (value) {
          switch (value) {
            case true:
              onAppliedPressed?.call();
            case false:
              onCancelPressed?.call();
            case null:
              onClosePressed?.call();
          }
        },
      );
    }
  }

  Widget _deskDoubleDialogWidget({
    required Widget Function({
      required bool isDeskValue,
      required BuildContext context,
    }) childWidget,
    required bool isScollable,
    required Color? backgroundColor,
    required EdgeInsets? insetPadding,
    required Widget Function(BuildContext context)? icon,
    required EdgeInsets? iconPadding,
    required OverflowBarAlignment? actionsOverflowAlignment,
    required double? maxWidth,
    required EdgeInsets Function({required bool isDeskValue})? contentPadding,
  }) =>
      BlocBuilder<AppLayoutBloc, AppLayoutState>(
        buildWhen: (previous, current) =>
            current.appVersionEnum.isDesk != previous.appVersionEnum.isDesk,
        builder: (context, state) {
          return AlertDialog(
            key: DialogsKeys.scroll,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            icon: icon?.call(context),
            insetPadding: insetPadding,
            backgroundColor:
                backgroundColor ?? AppColors.materialThemeKeyColorsNeutral,
            iconPadding: iconPadding,
            actionsOverflowAlignment: actionsOverflowAlignment,
            contentPadding:
                contentPadding?.call(isDeskValue: state.appVersionEnum.isDesk),
            scrollable: isScollable,
            clipBehavior: Clip.hardEdge,
            content: childWidget(
              isDeskValue: state.appVersionEnum.isDesk,
              context: context,
            ),
          );
        },
      );

  Widget _mobDoubleDialogWidget({
    required Widget Function({
      required bool isDeskValue,
      required BuildContext context,
    }) childWidget,
    // required EdgeInsets Function({
    //   required bool isDeskValue,
    // })? padding,
    required double? maxWidth,
    required bool isScollable,
  }) =>
      BlocBuilder<AppLayoutBloc, AppLayoutState>(
        buildWhen: (previous, current) =>
            current.appVersionEnum.isDesk != previous.appVersionEnum.isDesk,
        builder: (context, state) {
          final child =
              //  padding != null
              //     ? Padding(
              //         padding: padding(isDeskValue: isDeskValue),
              //         child: childWidget(
              //           isDeskValue: isDeskValue,
              //           context: context,
              //         ),
              //       )
              //     :
              childWidget(
            isDeskValue: state.appVersionEnum.isDesk,
            context: context,
          );
          if (isScollable) {
            return SingleChildScrollView(
              key: DialogsKeys.scroll,
              child: child,
            );
          } else {
            return child;
          }
        },
      );

  void showConfirmationDialog({
    required bool isDesk,
    required String title,
    required String subtitle,
    required String confirmText,
    required void Function()? onAppliedPressed,
    required Color confirmButtonBackground,
    bool confirmWhiteText = true,
    bool timer = false,
    String? unconfirmText,
    void Function()? onCancelPressed,
    void Function()? onClosePressed,
  }) {
    _doubleDialog(
      childWidget: ({required isDeskValue, required context}) => ConfirmDialog(
        isDesk: isDeskValue,
        title: title,
        subtitle: subtitle,
        confirmText: confirmText,
        unconfirmText: unconfirmText,
        confirmButtonBackground: confirmButtonBackground,
        timer: timer,
        confirmWhiteText: confirmWhiteText,
      ),
      isDesk: isDesk,
      onCancelPressed: onCancelPressed,
      onClosePressed: onClosePressed,
      onAppliedPressed: onAppliedPressed,
      deskContentPadding: ({required isDeskValue}) => EdgeInsets.zero,
      mobMaxWidth: KSize.kPixel500,
      deskMaxWidth: KSize.kPixel500,
    );
  }

  void showConfirmationPublishDiscountDialog({
    required bool isDesk,
    required void Function()? onPressed,
    required void Function()? onClose,
  }) =>
      _doubleDialog(
        childWidget: ({required isDeskValue, required context}) =>
            ConfirmPublishDiscountDialog(
          isDesk: isDeskValue,
          onPressed: onPressed,
        ),
        onCancelPressed: onClose,
        onClosePressed: onClose,
        isDesk: isDesk,
        deskContentPadding: ({required isDeskValue}) => EdgeInsets.zero,
        deskMaxWidth: KSize.kPixel680,
      );

  void showReportDialog({
    required bool isDesk,
    required CardEnum cardEnum,
    // required void Function()? afterEvent,
    required String cardId,
  }) {
    _doubleDialog(
      preLayoutWidget: ({required layoutBuilder}) => BlocProvider(
        create: (context) =>
            GetIt.I.get<ReportBloc>(param1: cardId, param2: cardEnum),
        child: layoutBuilder,
      ),
      childWidget: ({required isDeskValue, required context}) => isDesk
          ? ReportDialogWidget(
              isDesk: isDeskValue,
              // afterEvent: afterEvent,
            )
          : Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ), // padding if mobile keyboard open
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize16,
                  vertical: KPadding.kPaddingSize32,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ReportDialogWidget(
                    isDesk: isDeskValue,
                    // afterEvent: afterEvent,
                  ),
                ),
              ),
            ),
      isDesk: isDesk,
      deskInsetPadding: EdgeInsets.zero,
      deskIcon: (context) => CancelWidget(
        widgetKey: ReportDialogKeys.cancel,
        onPressed: context.pop,
      ),
      deskActionsOverflowAlignment: OverflowBarAlignment.center,
      deskContentPadding: ({required isDeskValue}) => isDeskValue
          ? const EdgeInsets.only(
              left: KPadding.kPaddingSize160,
              right: KPadding.kPaddingSize160,
              bottom: KPadding.kPaddingSize40,
            )
          : const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
              vertical: KPadding.kPaddingSize32,
            ),
      deskIconPadding: const EdgeInsets.only(
        left: KPadding.kPaddingSize16,
        right: KPadding.kPaddingSize16,
        top: KPadding.kPaddingSize16,
      ),
    );
    // if (isDesk) {
    //   showDialog<void>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return BlocProvider(
    //         create: (context) =>
    //             GetIt.I.get<ReportBloc>()..add(ReportEvent.started(cardId)),
    //         child: LayoutBuilder(
    //           builder: (BuildContext context, BoxConstraints constraints) {
    //             final isDeskValue = constraints.maxWidth >
    //                 KPlatformConstants.minWidthThresholdTablet;
    //             return AlertDialog(
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(KSize.kRadius32),
    //               ),
    //               scrollable: true,
    //               insetPadding: EdgeInsets.zero,
    //               icon: CancelWidget(
    //                 widgetKey: ReportDialogKeys.cancel,
    //                 onPressed: () => context.pop(),
    //               ),
    //               iconPadding: const EdgeInsets.all(KPadding.kPaddingSize16)
    //                   .copyWith(bottom: 0),
    //               backgroundColor: AppColors.materialThemeKeyColorsNeutral,
    //               actionsOverflowAlignment: OverflowBarAlignment.center,
    //               contentPadding: isDeskValue
    //                   ? const EdgeInsets.only(
    //                       left: KPadding.kPaddingSize160,
    //                       right: KPadding.kPaddingSize160,
    //                       bottom: KPadding.kPaddingSize40,
    //                     )
    //                   : const EdgeInsets.symmetric(
    //                       horizontal: KPadding.kPaddingSize16,
    //                       vertical: KPadding.kPaddingSize32,
    //                     ),
    //               content: ReportDialogWidget(
    //                 isDesk: isDeskValue,
    //                 cardEnum: cardEnum,
    //                 // afterEvent: afterEvent,
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //     },
    //   );
    // } else {
    //   showModalBottomSheet<void>(
    //     context: context,
    //     isScrollControlled: true,
    //     barrierColor:
    //         AppColors.materialThemeKeyColorsSecondary.withOpacity(0.2),
    //     shape: const RoundedRectangleBorder(
    //       borderRadius:
    //           BorderRadius.vertical(top: Radius.circular(KSize.kRadius32)),
    //     ),
    //     showDragHandle: true,
    //     backgroundColor: AppColors.materialThemeKeyColorsNeutral,
    //     useSafeArea: true,
    //     enableDrag: false,
    //     builder: (context) => BlocProvider(
    //       create: (context) =>
    //           GetIt.I.get<ReportBloc>()..add(ReportEvent.started(cardId)),
    //       child: FractionallySizedBox(
    //         heightFactor: KDimensions.bottomDialogHeightFactor,
    //         child: LayoutBuilder(
    //           builder: (BuildContext context, BoxConstraints constraints) {
    //             final isDeskValue =
    //                 constraints.maxWidth >= KMinMaxSize.maxWidth600;
    //             return Padding(
    //               padding: EdgeInsets.only(
    //                 bottom: MediaQuery.viewInsetsOf(context).bottom,
    //               ), // padding if mobile keyboard open
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                   horizontal: KPadding.kPaddingSize16,
    //                   vertical: KPadding.kPaddingSize32,
    //                 ),
    //                 child: SizedBox(
    //                   width: double.infinity,
    //                   child: SingleChildScrollView(
    //                     child: ReportDialogWidget(
    //                       isDesk: isDeskValue,
    //                       cardEnum: cardEnum,
    //                       // afterEvent: afterEvent,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }

  void showMobileMenuDialog() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.materialThemeKeyColorsSecondaryWithOpacity0_2,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(KSize.kRadius32)),
      ),
      showDragHandle: true,
      backgroundColor: AppColors.materialThemeKeyColorsNeutral,
      builder: (context) => const Padding(
        padding: EdgeInsets.only(
          left: KPadding.kPaddingSize40,
          right: KPadding.kPaddingSize32,
          bottom: KPadding.kPaddingSize32,
          top: KPadding.kPaddingSize16,
        ),
        child: MenuDialogWidget(),
      ),
    );
  }

  void showGetErrorDialog({
    required String? error,
    required void Function()? onPressed,
  }) {
    if (error != null) {
      if (onPressed == null) {
        showSnackBarTextDialog(error);
      } else {
        context._showSnackBar(
          key: DialogsKeys.failure,
          child: GetErrorDialogWidget(onPressed: onPressed, error: error),
        );
      }
    }
  }

  void showSnackBarTextDialog(
    String? text, {
    Duration duration = const Duration(minutes: 1),
  }) {
    if (text != null) {
      context._showSnackBar(
        // key: DialogsKeys.failure,
        child: Text(
          text,
          key: DialogsKeys.snackBarText,
          style: AppTextStyle.materialThemeBodyLargeNeutral,
        ),
        duration: duration,
      );
    }
  }

  void showCookiesDialog() {
    context._showSnackBar(
      // key: DialogsKeys.failure,
      child: const CookiesDialogWidget(),
      duration: const Duration(
        days: 1,
      ),
      dismissDirection: DismissDirection.none,
    );
  }

  void showMobFeedback() {
    BetterFeedback.of(context).show(context.onMobFeedback);
  }

  void showUserEmailDialog(
    int emailCloseDelay,
  ) {
    final bloc = context.read<UserEmailFormBloc>();
    final layoutBloc = context.read<AppLayoutBloc>();
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: bloc,
            ),
            BlocProvider.value(
              value: layoutBloc,
            ),
          ],
          child: BlocBuilder<AppLayoutBloc, AppLayoutState>(
            builder: (context, state) {
              return AlertDialog(
                key: DiscountCardDialogKeys.dialog,
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: KPadding.kPaddingSize20,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: KBorderRadius.kBorderRadius32,
                ),
                backgroundColor: AppColors.materialThemeKeyColorsNeutral,
                contentPadding: EdgeInsets.zero,
                scrollable: true,
                clipBehavior: Clip.hardEdge,
                content: UserEmailDialog(
                  key: UserEmailDialogKeys.dialog,
                  isDesk: state.appVersionEnum.isTablet,
                  sendOnPressed: () => context.read<UserEmailFormBloc>().add(
                        const UserEmailFormEvent.sendEmail(),
                      ),
                  // closeOnPressed: () =>
                  //     context.read<DiscountUserEmailFormBloc>().add(
                  //           DiscountUserEmailFormEvent.sendEmailAfterClose(
                  //             userEmailEnum: userEmailEnum,
                  //             count: count,
                  //           ),
                  //         ),
                  onChanged: (text) => context.read<UserEmailFormBloc>().add(
                        UserEmailFormEvent.updatedEmail(text),
                      ),
                  userEmailEnum:
                      context.read<UserEmailFormBloc>().state.emailEnum,
                  emailCloseDelay: emailCloseDelay,
                ),
              );
            },
          ),
        );
      },
    ).then(
      context.emailDialogCloseEvent,
      //   (value) {
      //   if (!context.mounted) return;
      //   if (!(value ?? false)) {
      //     context.read<DiscountUserEmailFormBloc>().add(
      //           DiscountUserEmailFormEvent.sendEmailAfterClose(
      //             userEmailEnum: userEmailEnum,
      //             count: count,
      //           ),
      //         );
      //   }
      // }
    );
  }

  void showMobUpdateAppDialog({
    required bool hasNewVersion,
  }) {
    if (hasNewVersion) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            key: DiscountCardDialogKeys.dialog,
            insetPadding: EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: KBorderRadius.kBorderRadius32,
            ),
            backgroundColor: AppColors.materialThemeKeyColorsSecondary,
            contentPadding: EdgeInsets.all(KPadding.kPaddingSize16),
            scrollable: true,
            clipBehavior: Clip.hardEdge,
            content: MobUpdateDialog(),
          );
        },
      );
    }
  }

  void showAuthenticationServiceDialog(
    AuthenticationServicesStatus status, {
    SomeFailure? failure,
  }) {
    if (!Config.isWeb) {
      switch (status) {
        case AuthenticationServicesStatus.error:
          showSnackBarTextDialog(failure?.value(context));
        case AuthenticationServicesStatus.procesing:
          context._showSnackBar(
            child: Text(
              context.l10n.loggingInWait,
              style: AppTextStyle.materialThemeBodyLargeBold,
            ),
            duration: const Duration(
              minutes: 5,
            ),
            backgroundColor: AppColors.materialThemeKeyColorsPrimary,
          );
        case AuthenticationServicesStatus.init:
        case AuthenticationServicesStatus.authentication:
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    }
  }
}
