import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class MobFeedbackWidget extends StatefulWidget {
  /// Create a [MobFeedbackWidget].
  /// This is the default feedback bottom sheet, which is presented to the user.
  const MobFeedbackWidget({
    super.key,
    // required this.onSubmit,
    required this.scrollController,
  });

  /// Should be called when the user taps the submit button.
  // final OnSubmit onSubmit;

  /// A scroll controller that expands the sheet when it's attached to a
  /// scrollable widget and that widget is scrolled.
  ///
  /// Non null if the sheet is draggable.
  /// See: [FeedbackThemeData.sheetIsDraggable].
  final ScrollController? scrollController;

  @override
  State<MobFeedbackWidget> createState() => _MobFeedbackWidgetState();
}

class _MobFeedbackWidgetState extends State<MobFeedbackWidget> {
  late TextEditingController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(KPadding.kPaddingSize16),
      child: Column(
        children: [
          Text(
            context.l10n.whatIsWrong,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
          TextFieldWidget(
            widgetKey: const Key('text_input_field'),
            controller: controller,
            labelText: context.l10n.writeMessage,
            // textInputAction: TextInputAction.done,
            onChanged: (_) {
              //print(_);
            },
            isDesk: false,
          ),
          KSizedBox.kHeightSizedBox16,
          // if (widget.scrollController != null)
          //   const FeedbackSheetDragHandle(),
          TextButton(
            key: const Key('submit_feedback_button'),
            style: KButtonStyles.filterButtonStyleBorderWhite,
            child: Text(
              context.l10n.send,
              style: AppTextStyle.materialThemeTitleMedium.copyWith(
                color: AppColors.materialThemeKeyColorsSecondary,
              ),
            ),
            onPressed: () {}, //() => widget.onSubmit(controller.text),
          ),
        ],
      ),
    );
  }
}
