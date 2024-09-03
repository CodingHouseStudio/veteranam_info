import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

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
            if (_.formState.isNext) ...[
              Text(
                context.l10n.addComment,
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
              // KSizedBox.kHeightSizedBox16,
              // TextFieldWidget(
              //   widgetKey: KWidgetkeys.widget.reportDialog.emailField,
              //   onChanged: (text) => context
              //       .read<ReportBloc>()
              //       .add(ReportEvent.emailUpdated(text)),
              //   isDesk: isDesk,
              //   labelText: '${context.l10n.email}*',
              //   enabled: context
              //           .read<AuthenticationBloc>()
              //           .state
              //           .user
              //           ?.isAnonymously ??
              //       false,
              //   errorText: _.email?.error.value(context) ??
              //       context.l10n.fieldCannotBeEmpty,
              //   showErrorText: _.formState == ReportEnum.nextInvalidData &&
              //       (context
              //               .read<AuthenticationBloc>()
              //               .state
              //               .user
              //               ?.isAnonymously ??
              //           true),
              //   text: context.read<AuthenticationBloc>().state.user?.email,
              //   inputFormatterList: [EmailInputFormatter()],
              // ),
              KSizedBox.kHeightSizedBox16,
              MessageFieldWidget(
                key: KWidgetkeys.widget.reportDialog.messageField,
                changeMessage: (text) => context
                    .read<ReportBloc>()
                    .add(ReportEvent.messageUpdated(text)),
                isDesk: isDesk,
                labelText: context.l10n.writeYourMessage,
                errorText: _.message?.error.value(context) ??
                    context.l10n.fieldCannotBeEmpty,
                showErrorText: _.formState == ReportEnum.nextInvalidData,
              ),
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
            DoubleButtonWidget(
              widgetKey: KWidgetkeys.widget.reportDialog.sendButton,
              text: _.formState.isNext ? context.l10n.send : context.l10n.next,
              isDesk: isDesk,
              onPressed: () =>
                  context.read<ReportBloc>().add(ReportEvent.send(cardEnum)),
              color: AppColors.materialThemeKeyColorsSecondary,
              textColor: AppColors.materialThemeWhite,
              hasAlign: isDesk,
              mobTextWidth: double.infinity,
              mobVerticalTextPadding: KPadding.kPaddingSize16,
              mobIconPadding: KPadding.kPaddingSize16,
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
