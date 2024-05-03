import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkRespondBodyWidget extends StatelessWidget {
  const WorkRespondBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        Text(
          key: KWidgetkeys.screen.workRespond.title,
          context.l10n.respond,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          key: KWidgetkeys.screen.workRespond.subtitle,
          KMockText.workTitle,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        Container(
          padding: EdgeInsets.all(
            isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          ),
          margin: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize336 : KPadding.kPaddingSize16,
            vertical:
                isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
          ),
          constraints: const BoxConstraints(
            maxWidth: KMinMaxSize.maxWidth768,
          ),
          decoration: KWidgetTheme.boxDecorationWidget(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key: KWidgetkeys.screen.workRespond.username,
                KMockText.userName,
                style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
              Padding(
                padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
                child: Text(
                  key: KWidgetkeys.screen.workRespond.email,
                  context.l10n.email,
                  style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
                ),
              ),
              TextFieldWidget(
                widgetKey: KWidgetkeys.screen.workRespond.emailHint,
                onChanged: (value) {},
                hintText: context.l10n.emailHint,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
              Padding(
                padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
                child: Text(
                  key: KWidgetkeys.screen.workRespond.phoneNumber,
                  context.l10n.phoneNumber,
                  style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
                ),
              ),
              TextFieldWidget(
                widgetKey: KWidgetkeys.screen.workRespond.phoneNumberHint,
                onChanged: (value) {},
                hintText: context.l10n.phoneNumberHint,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
              Padding(
                padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
                child: Text(
                  key: KWidgetkeys.screen.workRespond.resume,
                  context.l10n.resume,
                  style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(
                  isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
                ),
                decoration: KWidgetTheme.boxDecorationWidget(context),
                width: double.infinity,
                height: KMinMaxSize.minmaxHeight94,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    KIcon.attachFile,
                    KSizedBox.kWidthSizedBox8,
                    GestureDetector(
                      child: Text(
                        key: KWidgetkeys.screen.workRespond.upload,
                        context.l10n.upload,
                        style: isDesk
                            ? AppTextStyle.text24.underline
                            : AppTextStyle.text16.underline,
                      ),
                    ),
                  ],
                ),
              ),
              KSizedBox.kHeightSizedBox8,
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: KPadding.kPaddingSize32,
                    ),
                    child: CheckPointWidget(
                      key: KWidgetkeys.screen.workRespond.checkbox,
                      onChanged: () {},
                      isCheck: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: KPadding.kPaddingSize16,
                    ),
                    child: Text(
                      key: KWidgetkeys.screen.workRespond.noResume,
                      context.l10n.noResume,
                      style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                    ),
                  ),
                ],
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
              if (isDesk)
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        key: KWidgetkeys.screen.workRespond.send,
                        text: context.l10n.send,
                        onPressed: () {},
                        isDesk: isDesk,
                      ),
                    ),
                    KSizedBox.kWidthSizedBox73,
                    Expanded(
                      child: ButtonWidget(
                        key: KWidgetkeys.screen.workRespond.cancel,
                        text: context.l10n.cancel,
                        onPressed: () {},
                        isDesk: isDesk,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                )
              else ...[
                ButtonWidget(
                  key: KWidgetkeys.screen.workRespond.send,
                  text: context.l10n.send,
                  onPressed: () {},
                  isDesk: isDesk,
                ),
                KSizedBox.kHeightSizedBox16,
                ButtonWidget(
                  key: KWidgetkeys.screen.workRespond.cancel,
                  text: context.l10n.cancel,
                  onPressed: () {},
                  isDesk: isDesk,
                  backgroundColor: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
