import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyPolicyMarkdownCubit, String?>(
      builder: (context, _) {
        return Container(
          constraints: const BoxConstraints(
            maxWidth: KMinMaxSize.maxWidth768,
          ),
          width: double.infinity,
          padding: const EdgeInsets.only(
            right: KPadding.kPaddingSize32,
            left: KPadding.kPaddingSize32,
            bottom: KPadding.kPaddingSize32,
          ),
          child: _ == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarkdownBody(
                      data: context.l10n.privacyPolicyStartText,
                    ),
                    KSizedBox.kHeightSizedBox32,
                    const Padding(
                      padding: EdgeInsets.all(KPadding.kPaddingSize32),
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    ),
                    KSizedBox.kHeightSizedBox32,
                  ],
                )
              : MarkdownBody(
                  key: KWidgetkeys.screen.privacyPolicy.text,
                  data: _,
                  styleSheet: MarkdownStyleSheet(
                    a: AppTextStyle.materialThemeBodyLarge,
                  ),
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
        );
      },
    );
  }
}
