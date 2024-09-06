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
          key: KWidgetkeys.widget.mobFeedback.widget,
          padding: const EdgeInsets.all(KPadding.kPaddingSize16),
          children: [
            TooltipWidget(
              key: KWidgetkeys.widget.mobFeedback.title,
              description: context.l10n.mobFeedbackHint,
              text: context.l10n.whatIsWrong,
              duration: const Duration(seconds: 15),
              margin: KPadding.kPaddingSize12,
              padding: const EdgeInsets.all(
                KPadding.kPaddingSize12,
              ),
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
            DoubleButtonWidget(
              widgetKey: KWidgetkeys.widget.mobFeedback.button,
              text: context.l10n.send, darkMode: true,
              isDesk: false, mobVerticalTextPadding: KPadding.kPaddingSize12,
              mobIconPadding: KPadding.kPaddingSize12,
              mobHorizontalTextPadding: KPadding.kPaddingSize64,

              onPressed: () => _.message.isValid
                  ? onSubmit(
                      _.message.value,
                    )
                  : context.read<MobFeedbackBloc>().add(
                        const MobFeedbackEvent.send(null),
                      ), //() => widget.onSubmit(controller.text),
            ),
          ],
        );
      },
    );
  }
}
