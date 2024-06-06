import 'package:flutter/widgets.dart';
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
                  child: Text(
                    context.l10n.writeUsMessage,
                    style: AppTextStyle.materialThemeDisplayLarge,
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconWidget(icon: KIcon.arrowDownRight),
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.preferEmail,
                                style: AppTextStyle.materialThemeBodyLargeHint,
                              ),
                            ),
                            Expanded(
                              child: Markdown(
                                data: KAppText.email,
                                styleSheet: MarkdownStyleSheet(
                                  a: isDesk
                                      ? AppTextStyle.materialThemeTitleMedium
                                          .copyWith(
                                          color: AppColors.materialThemeBlack,
                                        )
                                      : AppTextStyle.materialThemeTitleSmall
                                          .copyWith(
                                          color: AppColors.materialThemeBlack,
                                        ),
                                ),
                                shrinkWrap: true,
                                onTapLink: (text, href, title) async {
                                  final emailUri = Uri(
                                    scheme: 'mailto',
                                    path: KAppText.email,
                                  );

                                  if (await canLaunchUrl(emailUri)) {
                                    await launchUrl(emailUri);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        KSizedBox.kHeightSizedBox32,
                        Text(context.l10n.ourSocialNetworks),
                        Wrap(
                          children: [
                            IconWidget(
                              key: KWidgetkeys.widget.footer.likedInIcon,
                              icon: KImage.linkedIn,
                            ),
                            KSizedBox.kWidthSizedBox24,
                            IconWidget(
                              key: KWidgetkeys.widget.footer.instagramIcon,
                              icon: KImage.instagram,
                            ),
                            KSizedBox.kWidthSizedBox24,
                            IconWidget(
                              key: KWidgetkeys.widget.footer.facebookIcon,
                              icon: KImage.facebook,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
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
