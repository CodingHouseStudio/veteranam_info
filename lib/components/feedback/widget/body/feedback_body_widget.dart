import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

part '../feedback_box_widget.dart';
part '../field_widget_list.dart';

class FeedbackBodyWidget extends StatefulWidget {
  const FeedbackBodyWidget({super.key});

  @override
  State<FeedbackBodyWidget> createState() => _FeedbackBodyWidgetState();
}

class _FeedbackBodyWidgetState extends State<FeedbackBodyWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController messageController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state.formState == FeedbackEnum.clear) {
          nameController.clear();
          emailController.clear();
          messageController.clear();
        }
      },
      buildWhen: (previous, current) =>
          previous.failure != current.failure ||
          previous.formState != current.formState,
      builder: (context, state) {
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) => [
            KSizedBox.kHeightSizedBox48,
            Row(
              children: [
                Expanded(
                  child: TextPointWidget(
                    context.l10n.feedback,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.l10n.write,
                        style: AppTextStyle.materialThemeDisplayLarge,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            context.l10n.usMessage,
                            style: AppTextStyle.materialThemeDisplayLarge,
                          ),
                          KSizedBox.kWidthSizedBox24,
                          const IconWidget(icon: KIcon.arrowDownRight),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox132,
            if (context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.success ||
                context.read<FeedbackBloc>().state.formState ==
                    FeedbackEnum.sendingMessage)
              ..._feedbackBoxWidgetList(
                isDesk: isDesk,
                sendAgain: () => context
                    .read<FeedbackBloc>()
                    .add(const FeedbackEvent.sendignMessageAgain()),
                context: context,
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.l10n.feedbackSubtitle,
                          style: AppTextStyle.materialThemeBodyLarge,
                        ),
                        KSizedBox.kHeightSizedBox32,
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              context.l10n.preferEmail,
                              style: AppTextStyle.materialThemeBodyLargeHint,
                            ),
                            TextButton(
                              child: Text(
                                KAppText.email,
                                style: isDesk
                                    ? AppTextStyle.materialThemeTitleMedium
                                    : AppTextStyle.materialThemeTitleSmall,
                              ),
                              onPressed: () async {
                                final emailUri = Uri(
                                  scheme: 'mailto',
                                  path: KAppText.email,
                                );

                                if (await canLaunchUrl(emailUri)) {
                                  await launchUrl(emailUri);
                                }
                              },
                            ),
                          ],
                        ),
                        KSizedBox.kHeightSizedBox32,
                        Text(context.l10n.ourSocialNetworks),
                        KSizedBox.kHeightSizedBox8,
                        Wrap(
                          children: [
                            IconWidget(
                              key: KWidgetkeys.widget.footer.likedInIcon,
                              icon: KImage.linkedIn,
                              padding: KPadding.kPaddingSize12,
                            ),
                            KSizedBox.kWidthSizedBox24,
                            IconWidget(
                              key: KWidgetkeys.widget.footer.instagramIcon,
                              icon: KImage.instagram,
                              padding: KPadding.kPaddingSize12,
                            ),
                            KSizedBox.kWidthSizedBox24,
                            IconWidget(
                              key: KWidgetkeys.widget.footer.facebookIcon,
                              icon: KImage.facebook,
                              padding: KPadding.kPaddingSize12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _fieldWidgetList(
                        isDesk: isDesk,
                        context: context,
                        nameController: nameController,
                        emailController: emailController,
                        messageController: messageController,
                      ),
                    ),
                  ),
                ],
              ),
            KSizedBox.kHeightSizedBox100,
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
