import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class ReportDialogWidget extends StatelessWidget {
  const ReportDialogWidget({required this.isDesk, super.key});

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: KMinMaxSize.maxWidth460),
      child: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) =>
            state.formState == ReportEnum.success ? context.pop() : null,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.l10n.reportPublication,
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
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
                KSizedBox.kHeightSizedBox24,
                CheckPointWidget(
                  onChanged: null,
                  isCheck: ReasonComplaint.other ==
                      context.read<ReportBloc>().state.reasonComplaint,
                  text: context.l10n.other,
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox16,
                TextFieldWidget(
                  widgetKey: const Key('value'),
                  onChanged: (text) => context
                      .read<ReportBloc>()
                      .add(ReportEvent.emailUpdated(text)),
                  isDesk: isDesk,
                  labelText: context.l10n.email,
                  enabled: !(context
                          .read<AuthenticationBloc>()
                          .state
                          .user
                          ?.isAnonymously ??
                      false),
                  errorText: _.formState == ReportEnum.nextInvalidData
                      ? _.email?.error.value(context) ??
                          (context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user
                                      ?.isAnonymously ??
                                  false
                              ? null
                              : context.l10n.fieldCannotBeEmpty)
                      : null,
                ),
                KSizedBox.kHeightSizedBox16,
                MessageFieldWidget(
                  changeMessage: (text) => context
                      .read<ReportBloc>()
                      .add(ReportEvent.messageUpdated(text)),
                  isDesk: isDesk,
                  labelText: context.l10n.writeYourMessage,
                  errorText: _.formState == ReportEnum.nextInvalidData
                      ? _.message?.error.value(context) ??
                          (_.reasonComplaint == ReasonComplaint.other
                              ? context.l10n.fieldCannotBeEmpty
                              : null)
                      : null,
                ),
              ] else ...[
                Text(
                  context.l10n.specifyReasonForComplaint,
                  style: AppTextStyle.materialThemeTitleMedium,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      ReasonComplaint.values.length,
                      (index) => Padding(
                        padding: index != 0
                            ? const EdgeInsets.only(
                                top: KPadding.kPaddingSize24,
                              )
                            : EdgeInsets.zero,
                        child: _reportCheckPoint(
                          context: context,
                          reasonComplaint:
                              ReasonComplaint.values.elementAt(index),
                          isDesk: isDesk,
                        ),
                      ),
                    )..addAll(
                        _.formState == ReportEnum.invalidData
                            ? [
                                KSizedBox.kHeightSizedBox16,
                                Text(
                                  context.l10n.checkPointError,
                                  style:
                                      AppTextStyle.materialThemeBodySmallError,
                                ),
                              ]
                            : [],
                      ),
                  ),
                ),
              ],
              if (isDesk)
                KSizedBox.kHeightSizedBox40
              else
                KSizedBox.kHeightSizedBox32,
              DoubleButtonWidget(
                widgetKey: const Key(''),
                text:
                    _.formState.isNext ? context.l10n.send : context.l10n.next,
                isDesk: isDesk,
                onPressed: () => context
                    .read<ReportBloc>()
                    .add(const ReportEvent.send(CardEnum.funds)),
                color: AppColors.materialThemeKeyColorsSecondary,
                textColor: AppColors.materialThemeWhite,
                hasAlign: isDesk,
                mobTextWidth: double.infinity,
                mobVerticalTextPadding: KPadding.kPaddingSize16,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _reportCheckPoint({
    required BuildContext context,
    required ReasonComplaint reasonComplaint,
    required bool isDesk,
  }) =>
      CheckPointWidget(
        onChanged: () => context
            .read<ReportBloc>()
            .add(ReportEvent.reasonComplaintUpdated(reasonComplaint)),
        isCheck:
            reasonComplaint == context.read<ReportBloc>().state.reasonComplaint,
        text: reasonComplaint.toText(context),
        isDesk: isDesk,
      );
}
