import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
          key: MobFeedbackKeys.widget,
          padding: const EdgeInsets.all(KPadding.kPaddingSize16),
          children: [
            TooltipWidget(
              key: MobFeedbackKeys.title,
              description: context.l10n.mobFeedbackHint,
              text: context.l10n.whatIsWrong,
              duration: const Duration(seconds: 15),
              margin: KPadding.kPaddingSize12,
              padding: const EdgeInsets.all(
                KPadding.kPaddingSize12,
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (!state.status.isAuthenticated) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: KPadding.kPaddingSize16),
                    child: TextFieldWidget(
                      widgetKey: MobFeedbackKeys.emailField,
                      keyboardType: TextInputType.emailAddress,
                      // controller: controller,
                      labelText: KMockText.email,
                      isRequired: true,
                      // textInputAction: TextInputAction.done,
                      onChanged: (text) => context.read<MobFeedbackBloc>().add(
                            MobFeedbackEvent.emailUpdated(text),
                          ),
                      showErrorText: _.formState == MobFeedbackEnum.invalidData,
                      errorText: _.email.error.value(context),
                      isDesk: false,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            KSizedBox.kHeightSizedBox8,
            TextFieldWidget(
              widgetKey: MobFeedbackKeys.messageField,
              keyboardType: TextInputType.multiline,
              // controller: controller,
              labelText: context.l10n.writeMessage, isRequired: true,
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
              widgetKey: MobFeedbackKeys.button,
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
