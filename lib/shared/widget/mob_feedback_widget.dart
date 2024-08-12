import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared.dart';

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
          padding: const EdgeInsets.all(KPadding.kPaddingSize16),
          children: [
            KSizedBox.kHeightSizedBox8,
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.whatIsWrong,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
                Tooltip(
                  message: context.l10n.mobFeedbackHint,
                  waitDuration: const Duration(milliseconds: 100),
                  showDuration: const Duration(seconds: 15),
                  child: KIcon.info,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox8,
            TextFieldWidget(
              widgetKey: const Key('text_input_field'),
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
                // key: const Key('submit_feedback_button'),
                style: KButtonStyles.filterButtonStyleBorderWhite,
                child: Text(
                  context.l10n.send,
                  style: AppTextStyle.materialThemeBodyMedium.copyWith(
                    color: AppColors.materialThemeKeyColorsSecondary,
                  ),
                ),
                onPressed: () =>
                    onSubmit(''), //() => widget.onSubmit(controller.text),
              ),
            ),
          ],
        );
      },
    );
  }
}
