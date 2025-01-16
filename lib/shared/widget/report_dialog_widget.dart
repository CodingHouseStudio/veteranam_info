import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ReportDialogWidget extends StatelessWidget {
  const ReportDialogWidget({
    required this.isDesk,
    // required this.afterEvent,
    super.key,
  });

  final bool isDesk;
  // final void Function()? afterEvent;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: ReportDialogKeys.widget,
      constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth460),
      child: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state.formState == ReportEnum.success) {
            context.popDialog();
            // afterEvent?.call();
          }
        },
        builder: (context, _) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.reportPublication,
              key: ReportDialogKeys.title,
              style: isDesk
                  ? AppTextStyle.materialThemeHeadlineLarge
                  : AppTextStyle.materialThemeHeadlineSmall,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            if (_.formState == ReportEnum.sumbittedWithoutEmail) ...[
              Text.rich(
                TextSpan(
                  text: '${context.l10n.reportWithoutEmailDescriptionPart1} ',
                  children: [
                    TextSpan(
                      text: context.l10n.reportWithoutEmailDescriptionPart2,
                      style: isDesk
                          ? AppTextStyle.materialThemeBodyLargeBolcUnderLine
                          : AppTextStyle.materialThemeBodyMediumBoldUnderLine,
                      mouseCursor: SystemMouseCursors.click,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.goNamed(KRoute.signUp.name),
                    ),
                    TextSpan(
                      text: ', '
                          '${context.l10n.reportWithoutEmailDescriptionPart3}',
                    ),
                  ],
                ),
                key: ConfirmDialogKeys.subtitle,
                style: isDesk
                    ? AppTextStyle.materialThemeBodyLarge
                    : AppTextStyle.materialThemeBodyMedium,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox24,
              // if (widget.isDesk)
              // Wrap(
              //   spacing: KPadding.kPaddingSize24,
              //   runSpacing: KPadding.kPaddingSize16,
              //   children: [
              //     DoubleButtonWidget(
              //       widgetKey:
              //           ConfirmDialogKeys.confirmButton,
              //       text: 'test',
              //       darkMode: true,
              //       // textColor: AppColors.materialThemeWhite,
              //       isDesk: isDesk,
              //       deskPadding: const EdgeInsets.symmetric(
              //         vertical: KPadding.kPaddingSize12,
              //         horizontal: KPadding.kPaddingSize30,
              //       ),
              //       mobTextWidth: double.infinity,
              //       mobVerticalTextPadding: KPadding.kPaddingSize16,
              //       mobIconPadding: KPadding.kPaddingSize16,
              //       onPressed: () => context.pop(true),
              //       align: Alignment.center,
              //       hasAlign: !isDesk,
              //     ),
              //     SecondaryButtonWidget(
              //       widgetKey:
              //           ConfirmDialogKeys.unconfirmButton,
              //       onPressed: () {
              //         context.pop(false);
              //       },
              //       padding: const EdgeInsets.symmetric(
              //         vertical: KPadding.kPaddingSize12,
              //         horizontal: KPadding.kPaddingSize12,
              //       ),
              //       expanded: !isDesk,
              //       isDesk: isDesk,
              //       text: context.l10n.cancel,
              //       hasAlign: !isDesk,
              //       align: Alignment.center,
              //     ),
              //   ],
              // ),
              // if (!isDesk) KSizedBox.kHeightSizedBox16,
            ] else if (_.formState.isNext) ...[
              Text(
                _.reasonComplaint?.isOther ?? true
                    ? context.l10n.addComment
                    : context.l10n.addEmailAndMessage,
                key: ReportDialogKeys.subtitle,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
              KSizedBox.kHeightSizedBox24,
              CheckPointWidget(
                key: ReportDialogKeys.checkPoint,
                onChanged: null,
                isCheck: true,
                text: context
                    .read<ReportBloc>()
                    .state
                    .reasonComplaint!
                    .toText(context),
                isDesk: isDesk,
              ),
              if (!context.userHasEmail) ...[
                KSizedBox.kHeightSizedBox16,
                TextFieldWidget(
                  widgetKey: ReportDialogKeys.emailField,
                  onChanged: (text) => context
                      .read<ReportBloc>()
                      .add(ReportEvent.emailUpdated(text)),
                  isDesk: isDesk,
                  isRequired: true,
                  labelText: context.l10n.email,
                  errorText: _.email.error.value(context),
                  showErrorText: _.formState == ReportEnum.nextInvalidData,
                ),
              ],
              // if (_.reasonComplaint?.isOther ?? true) ...[
              KSizedBox.kHeightSizedBox16,
              MessageFieldWidget(
                key: ReportDialogKeys.messageField,
                changeMessage: (text) => context
                    .read<ReportBloc>()
                    .add(ReportEvent.messageUpdated(text)),
                isRequired: _.reasonComplaint?.isOther ?? true,
                isDesk: isDesk,
                labelText: context.l10n.writeYourMessage,
                errorText: _.message.error.value(context),
                showErrorText: (_.reasonComplaint?.isOther ?? true) &&
                    _.formState == ReportEnum.nextInvalidData,
                errorMaxLines: 3,
              ),
              // ],
            ] else ...[
              Text(
                context.l10n.specifyReasonForComplaint,
                key: ReportDialogKeys.subtitle,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox40
              else
                KSizedBox.kHeightSizedBox24,
              ...List.generate(
                ReasonComplaint.values.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    top: index != 0 ? KPadding.kPaddingSize24 : 0,
                    left: KPadding.kPaddingSize16,
                  ),
                  child: _reportCheckPoint(
                    context: context,
                    reasonComplaint: ReasonComplaint.values.elementAt(index),
                    isDesk: isDesk,
                  ),
                ),
              )..addAll(
                  _.formState == ReportEnum.invalidData
                      ? [
                          KSizedBox.kHeightSizedBox16,
                          Text(
                            context.l10n.checkPointError,
                            key: ReportDialogKeys.checkPointError,
                            style: AppTextStyle.materialThemeBodySmallError,
                          ),
                        ]
                      : [],
                ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox32,
            DoubleButtonWidget(
              widgetKey: ReportDialogKeys.sendButton,
              text: _.formState == ReportEnum.sumbittedWithoutEmail
                  ? context.l10n.cancel
                  : _.formState.isNext
                      ? context.l10n.send
                      : context.l10n.next,
              isDesk: isDesk,
              onPressed: _.formState == ReportEnum.success
                  ? null
                  : () => _.formState == ReportEnum.sumbittedWithoutEmail
                      ? context
                          .read<ReportBloc>()
                          .add(const ReportEvent.cancel())
                      : context
                          .read<ReportBloc>()
                          .add(const ReportEvent.send()),
              darkMode: true,
              hasAlign: !isDesk,
              mobTextWidth: double.infinity,
              mobVerticalTextPadding: KPadding.kPaddingSize16,
              mobIconPadding: KPadding.kPaddingSize16,
              align: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportCheckPoint({
    required BuildContext context,
    required ReasonComplaint reasonComplaint,
    required bool isDesk,
  }) =>
      CheckPointWidget(
        key: ReportDialogKeys.checkPoint,
        onChanged: () => context
            .read<ReportBloc>()
            .add(ReportEvent.reasonComplaintUpdated(reasonComplaint)),
        isCheck:
            reasonComplaint == context.read<ReportBloc>().state.reasonComplaint,
        text: reasonComplaint.toText(context),
        isDesk: isDesk,
      );
}
