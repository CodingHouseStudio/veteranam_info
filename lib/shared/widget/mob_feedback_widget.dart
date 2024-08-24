import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

MobFeedbackWidget feedbackBuilder(
  BuildContext context,
  Future<void> Function(String, {Map<String, dynamic>? extras}) onSubmit,
  ScrollController? scrollController,
) {
  return MobFeedbackWidget(
    onSubmit: onSubmit,
    // scrollController: scrollController,
  );
}

class MobFeedbackWidget extends StatelessWidget {
  const MobFeedbackWidget({
    required this.onSubmit,
    super.key,
  });
  final OnSubmit onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MobFeedbackBloc, MobFeedbackState>(
      builder: (context, _) {
        return ListView(
          key: KWidgetkeys.widget.mobFeedback.widget,
          padding: const EdgeInsets.all(KPadding.kPaddingSize16),
          children: [
            KSizedBox.kHeightSizedBox8,
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.whatIsWrong,
                    key: KWidgetkeys.widget.mobFeedback.text,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
                Tooltip(
                  key: KWidgetkeys.widget.mobFeedback.icon,
                  message: context.l10n.mobFeedbackHint,
                  waitDuration: const Duration(milliseconds: 100),
                  showDuration: const Duration(seconds: 15),
                  child: KIcon.info,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox8,
            TextFieldWidget(
              widgetKey: KWidgetkeys.widget.mobFeedback.field,
              // controller: controller,
              labelText: context.l10n.writeMessage,
              // textInputAction: TextInputAction.done,
              onChanged: (text) => context.read<MobFeedbackBloc>().add(
                    MobFeedbackEvent.messageUpdated(text),
                  ),
              showErrorText: _.formState == MobFeedbackEnum.invalidData,
              errorText: _.message.error.value(context),
              isDesk: false,
            ),
            KSizedBox.kHeightSizedBox16,
            // if (widget.scrollController != null)
            //   const FeedbackSheetDragHandle(),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                key: KWidgetkeys.widget.mobFeedback.button,
                style: KButtonStyles.filterButtonStyleBorderWhite,
                child: Text(
                  context.l10n.send,
                  style: AppTextStyle.materialThemeBodyMedium.copyWith(
                    color: AppColors.materialThemeKeyColorsSecondary,
                  ),
                ),
                onPressed: () => onSubmit(
                  _.message.value,
                ), //() => widget.onSubmit(controller.text),
              ),
            ),
          ],
        );
      },
    );
  }
}
