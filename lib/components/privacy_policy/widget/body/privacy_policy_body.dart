import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PrivacyPolicyMarkdownCubit, String?>(
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth >
                    KPlatformConstants.minWidthThresholdTablet;
                return Padding(
                  padding: (isTablet
                          ? const EdgeInsets.all(
                              KPadding.kPaddingSize32,
                            )
                          : const EdgeInsets.all(
                              KPadding.kPaddingSize16,
                            ))
                      .copyWith(
                    top: KPadding.kPaddingSize60,
                  ),
                  child: _ == null
                      ? ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MarkdownBody(
                              data: context.l10n.privacyPolicyStartText,
                            ),
                            KSizedBox.kHeightSizedBox32,
                            const Padding(
                              padding: EdgeInsets.all(KPadding.kPaddingSize32),
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            ),
                            KSizedBox.kHeightSizedBox32,
                          ],
                        )
                      : SingleChildScrollView(
                          child: MarkdownBody(
                            key: KWidgetkeys.screen.privacyPolicy.text,
                            data: _,
                            styleSheet: MarkdownStyleSheet(
                              a: AppTextStyle.materialThemeBodyLarge,
                            ),
                            onTapLink: context.copyText,
                          ),
                        ),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(KPadding.kPaddingSize16),
          child: CancelWidget(
            widgetKey: KWidgetkeys.screen.privacyPolicy.closeIcon,
            onPressed: () => context.pop(),
          ),
        ),
      ],
    );
  }
}
