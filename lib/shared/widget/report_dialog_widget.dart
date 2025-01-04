import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ReportDialogWidget extends StatelessWidget {
  const ReportDialogWidget({
    required this.isDesk,
    required this.cardEnum,
    // required this.afterEvent,
    super.key,
  });

  final bool isDesk;
  final CardEnum cardEnum;
  // final void Function()? afterEvent;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: KWidgetkeys.widget.reportDialog.widget,
      constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth460),
      child: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state.formState == ReportEnum.success) {
            context.pop();
            // afterEvent?.call();
          }
        },
        builder: (context, _) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.reportPublication,
              key: KWidgetkeys.widget.reportDialog.title,
              style: isDesk
                  ? AppTextStyle.materialThemeHeadlineLarge
                  : AppTextStyle.materialThemeHeadlineSmall,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            if (_.formState == ReportEnum.trySuccessWithoutEmail) ...[
              Text(
                'test',
                key: KWidgetkeys.widget.confirmDialog.subtitle,
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
              //           KWidgetkeys.widget.confirmDialog.confirmButton,
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
              //           KWidgetkeys.widget.confirmDialog.unconfirmButton,
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
                    : context.l10n.addEmail,
                key: KWidgetkeys.widget.reportDialog.subtitle,
                style: AppTextStyle.materialThemeTitleMedium,
              ),
              KSizedBox.kHeightSizedBox24,
              CheckPointWidget(
                key: KWidgetkeys.widget.reportDialog.checkPoint,
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
                  widgetKey: KWidgetkeys.widget.reportDialog.emailField,
                  onChanged: (text) => context
                      .read<ReportBloc>()
                      .add(ReportEvent.emailUpdated(text)),
                  isDesk: isDesk,
                  labelText: '${context.l10n.email}'
                      '${_.reasonComplaint?.isOther ?? true ? '*' : ''}',
                  errorText: _.email.error.value(context) ??
                      context.l10n.fieldCannotBeEmpty,
                  showErrorText: _.formState == ReportEnum.nextInvalidData,
                ),
              ],
              if (_.reasonComplaint?.isOther ?? true) ...[
                KSizedBox.kHeightSizedBox16,
                MessageFieldWidget(
                  key: KWidgetkeys.widget.reportDialog.messageField,
                  changeMessage: (text) => context
                      .read<ReportBloc>()
                      .add(ReportEvent.messageUpdated(text)),
                  isRequired: true,
                  isDesk: isDesk,
                  labelText: context.l10n.writeYourMessage,
                  errorText: _.message.error.value(context),
                  showErrorText: _.formState == ReportEnum.nextInvalidData,
                  errorMaxLines: 3,
                ),
              ],
            ] else ...[
              Text(
                context.l10n.specifyReasonForComplaint,
                key: KWidgetkeys.widget.reportDialog.subtitle,
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
                            key:
                                KWidgetkeys.widget.reportDialog.checkPointError,
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
            if (_.formState == ReportEnum.trySuccessWithoutEmail)
              Wrap(
                spacing: KPadding.kPaddingSize24,
                runSpacing: KPadding.kPaddingSize16,
                children: [
                  button(context: context, state: _),
                  SecondaryButtonWidget(
                    widgetKey: KWidgetkeys.widget.confirmDialog.unconfirmButton,
                    onPressed: () {
                      context.pop(false);
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize12,
                      horizontal: KPadding.kPaddingSize12,
                    ),
                    expanded: !isDesk,
                    isDesk: isDesk,
                    text: context.l10n.cancel,
                    hasAlign: !isDesk,
                    align: Alignment.center,
                  ),
                ],
              )
            else
              button(context: context, state: _),
          ],
        ),
      ),
    );
  }

  Widget button({
    required BuildContext context,
    required ReportState state,
  }) =>
      DoubleButtonWidget(
        widgetKey: KWidgetkeys.widget.reportDialog.sendButton,
        text: state.formState.isNext ||
                (context.userHasEmail &&
                    !(state.reasonComplaint?.isOther ?? true))
            ? context.l10n.send
            : context.l10n.next,
        isDesk: isDesk,
        onPressed: state.formState == ReportEnum.success
            ? null
            : () => context.read<ReportBloc>().add(ReportEvent.send(cardEnum)),
        darkMode: true,
        hasAlign: isDesk,
        mobTextWidth: double.infinity,
        mobVerticalTextPadding: KPadding.kPaddingSize16,
        mobIconPadding: KPadding.kPaddingSize16,
      );

  Widget _reportCheckPoint({
    required BuildContext context,
    required ReasonComplaint reasonComplaint,
    required bool isDesk,
  }) =>
      CheckPointWidget(
        key: KWidgetkeys.widget.reportDialog.checkPoint,
        onChanged: () => context
            .read<ReportBloc>()
            .add(ReportEvent.reasonComplaintUpdated(reasonComplaint)),
        isCheck:
            reasonComplaint == context.read<ReportBloc>().state.reasonComplaint,
        text: reasonComplaint.toText(context),
        isDesk: isDesk,
      );
}
