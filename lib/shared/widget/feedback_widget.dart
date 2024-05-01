import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FeedbackWidget extends SingleChildRenderObjectWidget {
  FeedbackWidget({
    required this.isDesk,
    super.key,
    this.title,
    this.subtitle,
    this.messageHint,
  }) : super(
          child: BlocBuilder<FeedbackBloc, FeedbackState>(
            buildWhen: (previous, current) =>
                previous.formState != current.formState ||
                previous.failure != current.failure,
            builder: (context, _) =>
                // _.formState == FeedbackEnum.success ||
                //         _.formState == FeedbackEnum.sendingMessage
                //     ? FeedbackBoxWidget(
                //         // key: feedbackBoxKey,
                //         isDesk: isDesk,
                //         sendAgain: () => context
                //             .read<FeedbackBloc>()
                //             .add(const FeedbackEvent.sendignMessageAgain()),
                //         // feedbackBoxKey: feedbackBoxKey,
                //       )
                //     :
                SliverList(
              delegate: _FeedbackWidgetImplementation(
                // key: feedbackKey,
                _.formState == FeedbackEnum.success ||
                        _.formState == FeedbackEnum.sendingMessage
                    ? _feedbackBoxWidgetList(
                        context: context,
                        sendAgain: () => context
                            .read<FeedbackBloc>()
                            .add(const FeedbackEvent.sendignMessageAgain()),
                        isDesk: isDesk,
                      )
                    : _feedbackWidgetList(
                        context: context,
                        emailFailure: _.formState == FeedbackEnum.invalidData
                            ? _.email.error.value(context)
                            : null,
                        isDesk: isDesk,
                        messageFailure: _.formState == FeedbackEnum.invalidData
                            ? _.message.error.value(context)
                            : null,
                        messageHint:
                            messageHint ?? context.l10n.writeYourMessage,
                        nameFailure: _.formState == FeedbackEnum.invalidData
                            ? _.name.error.value(context)
                            : null,
                        subtitle: subtitle ?? context.l10n.feedbackSubtitle,
                        title: title ?? context.l10n.feedback,
                        clearText: _.formState == FeedbackEnum.clear,
                      ),
                // feedbackKey: feedbackKey,
              ),
            ),
          ),
        );

  final String? title;
  final String? subtitle;
  final String? messageHint;
  final bool isDesk;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: EdgeInsets.zero,
    );
  }
}

List<Widget> _feedbackBoxWidgetList({
  required BuildContext context,
  required void Function() sendAgain,
  required bool isDesk,
}) {
  return isDesk
      ? [
          Text(
            context.l10n.thankYou,
            key: KWidgetkeys.widget.feedbackBox.title,
            style: AppTextStyle.text96,
          ),
          KSizedBox.kHeightSizedBox32,
          Text(
            context.l10n.feedbackBoxSubtitle,
            key: KWidgetkeys.widget.feedbackBox.subtitle,
            style: AppTextStyle.text40,
          ),
          KSizedBox.kHeightSizedBox48,
          ButtonWidget(
            key: KWidgetkeys.widget.feedbackBox.button,
            text: context.l10n.sendMore,
            onPressed: sendAgain,
            isDesk: true,
          ),
          BoxWidget(
            key: KWidgetkeys.widget.feedbackBox.informationBox,
            text: context.l10n.information,
            onTap: () => context.goNamedWithScroll(
              KRoute.information.name,
            ),
            isDesk: true,
          ),
          KSizedBox.kHeightSizedBox24,
          BoxWidget(
            key: KWidgetkeys.widget.feedbackBox.investorsBox,
            text: context.l10n.investors,
            onTap: () => context.goNamedWithScroll(KRoute.investors.name),
            isDesk: true,
          ),
          KSizedBox.kHeightSizedBox24,
          BoxWidget(
            key: KWidgetkeys.widget.feedbackBox.storyBox,
            text: context.l10n.stories,
            onTap: () => context.goNamedWithScroll(KRoute.story.name),
            isDesk: true,
          ),
        ]
      : [
          Text(
            context.l10n.thankYou,
            key: KWidgetkeys.widget.feedbackBox.title,
            style: AppTextStyle.text48,
          ),
          KSizedBox.kHeightSizedBox16,
          Text(
            context.l10n.feedbackBoxSubtitle,
            key: KWidgetkeys.widget.feedbackBox.subtitle,
            style: AppTextStyle.text24,
          ),
          KSizedBox.kHeightSizedBox24,
          ButtonWidget(
            key: KWidgetkeys.widget.feedbackBox.button,
            text: context.l10n.sendMore,
            onPressed: sendAgain,
            isDesk: false,
          ),
          KSizedBox.kHeightSizedBox24,
          BoxWidget(
            key: KWidgetkeys.widget.feedbackBox.informationBox,
            text: context.l10n.information,
            onTap: () => context.goNamedWithScroll(KRoute.information.name),
            isDesk: false,
          ),
          KSizedBox.kHeightSizedBox24,
          BoxWidget(
            key: KWidgetkeys.widget.feedbackBox.investorsBox,
            text: context.l10n.investors,
            onTap: () => context.goNamedWithScroll(KRoute.investors.name),
            isDesk: false,
          ),
          KSizedBox.kHeightSizedBox24,
          BoxWidget(
            key: KWidgetkeys.widget.feedbackBox.storyBox,
            text: context.l10n.stories,
            onTap: () => context.goNamedWithScroll(KRoute.story.name),
            isDesk: false,
          ),
        ];
}

List<Widget> _feedbackWidgetList({
  required BuildContext context,
  required bool isDesk,
  required String title,
  required String subtitle,
  required String messageHint,
  required String? emailFailure,
  required String? nameFailure,
  required String? messageFailure,
  required bool clearText,
}) {
  return [
    Text(
      title,
      key: KWidgetkeys.widget.feedback.title,
      style: isDesk ? AppTextStyle.text96 : AppTextStyle.text48,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Text(
      subtitle,
      key: KWidgetkeys.widget.feedback.subtitle,
      style: AppTextStyle.text24,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox56 else KSizedBox.kHeightSizedBox24,
    Padding(
      padding: EdgeInsets.only(
        left: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Text(
        context.l10n.name,
        key: KWidgetkeys.widget.feedback.name,
        style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
      ),
    ),
    if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.widget.feedback.fieldName,
      hasController: true,
      clearText: clearText,
      errorText: nameFailure,
      // controller: nameController,
      onChanged: (value) => context.read<FeedbackBloc>().add(
            FeedbackEvent.nameUpdated(value),
          ),
      hintText: context.l10n.text,
      hintStyle: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
      isDesk: isDesk,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: EdgeInsets.only(
        left: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Text(
        '${context.l10n.fullEmail}*',
        key: KWidgetkeys.widget.feedback.email,
        style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
      ),
    ),
    if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.widget.feedback.fieldEmail,
      hasController: true,
      clearText: clearText,
      errorText: emailFailure,
      // controller: emailController,
      onChanged: (value) => context.read<FeedbackBloc>().add(
            FeedbackEvent.emailUpdated(value),
          ),
      hintText: context.l10n.writeYourEmail,
      hintStyle: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
      isDesk: isDesk,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: EdgeInsets.only(
        left: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Text(
        context.l10n.message,
        key: KWidgetkeys.widget.feedback.message,
        style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
      ),
    ),
    if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
    MessageFieldWidget(
      key: KWidgetkeys.widget.feedback.fieldMessage,
      hasController: true,
      clearText: clearText,
      errorText: messageFailure,
      changeMessage: (value) => context.read<FeedbackBloc>().add(
            FeedbackEvent.messageUpdated(value),
          ),
      hintText: messageHint,
      hintStyle: isDesk ? AppTextStyle.hint24 : AppTextStyle.hint16,
      isDesk: isDesk,
    ),
    KSizedBox.kHeightSizedBox24,
    if (isDesk)
      Row(
        children: [
          ButtonWidget(
            key: KWidgetkeys.widget.feedback.buttonSave,
            text: context.l10n.send,
            onPressed: () => context.read<FeedbackBloc>().add(
                  const FeedbackEvent.save(),
                ),
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kWidthSizedBox24
          else
            KSizedBox.kHeightSizedBox24,
          ButtonWidget(
            key: KWidgetkeys.widget.feedback.buttonClear,
            text: context.l10n.clear,
            onPressed: () => context.read<FeedbackBloc>().add(
                  const FeedbackEvent.clear(),
                ),
            isDesk: isDesk,
            // backgroundColor: AppColors.transparent,
          ),
        ],
      )
    else ...[
      ButtonWidget(
        key: KWidgetkeys.widget.feedback.buttonSave,
        text: context.l10n.send,
        onPressed: () => context.read<FeedbackBloc>().add(
              const FeedbackEvent.save(),
            ),
        isDesk: isDesk,
      ),
      if (isDesk) KSizedBox.kWidthSizedBox24 else KSizedBox.kHeightSizedBox24,
      ButtonWidget(
        key: KWidgetkeys.widget.feedback.buttonClear,
        text: context.l10n.clear,
        onPressed: () => context.read<FeedbackBloc>().add(
              const FeedbackEvent.clear(),
            ),
        isDesk: isDesk,
        // backgroundColor: AppColors.transparent,
      ),
    ],
    KSizedBox.kHeightSizedBox56,
  ];
}

class _FeedbackWidgetImplementation extends SliverChildBuilderDelegate {
  _FeedbackWidgetImplementation(
    this.widgetList,
    // required this.feedbackKey,
  ) : super(
          (context, index) => widgetList.elementAt(index),
          childCount: widgetList.length,
        );

  // final GlobalKey feedbackKey;
  final List<Widget> widgetList;

  // @override
  // void initState() {
  //   super.initState();
  //   nameController = TextEditingController();
  //   emailController = TextEditingController();
  //   messageController = TextEditingController();
  //   completeWidget = null;
  //   if (context.read<FeedbackBloc>().state.formState ==
  //       FeedbackEnum.sendignMessageAgain) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       Scrollable.ensureVisible(widget.feedbackKey.currentContext!);
  //     });
  //     context.read<FeedbackBloc>().add(const FeedbackEvent.clear());
  //   }
  // }
}
