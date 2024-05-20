import 'package:flutter/material.dart';
import 'package:kozak/components/employee_respond/widget/employee_respond_buttons_widget.dart';

import 'package:kozak/shared/shared.dart';

class EmployeeRespondContainerWidget extends StatelessWidget {
  const EmployeeRespondContainerWidget({required this.isDesk, super.key});

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize336 : KPadding.kPaddingSize16,
        vertical: isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
      ),
      decoration: KWidgetTheme.boxDecorationWidget(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key: KWidgetkeys.screen.employeeRespond.username,
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
              key: KWidgetkeys.screen.employeeRespond.emailText,
              context.l10n.email,
              style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
            ),
          ),
          KSizedBox.kHeightSizedBox8,
          TextFieldWidget(
            widgetKey: KWidgetkeys.screen.employeeRespond.emailField,
            onChanged: null,
            hintText: context.l10n.emailHint,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox16,
          Padding(
            padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
            child: Text(
              key: KWidgetkeys.screen.employeeRespond.phoneNumberText,
              context.l10n.phoneNumber,
              style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
            ),
          ),
          KSizedBox.kHeightSizedBox8,
          TextFieldWidget(
            widgetKey: KWidgetkeys.screen.employeeRespond.phoneNumberField,
            onChanged: null,
            hintText: context.l10n.phoneNumberHint,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox16,
          Padding(
            padding: const EdgeInsets.only(left: KPadding.kPaddingSize16),
            child: Text(
              key: KWidgetkeys.screen.employeeRespond.resume,
              context.l10n.resume,
              style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
            ),
          ),
          KSizedBox.kHeightSizedBox8,
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
                    key: KWidgetkeys.screen.employeeRespond.upload,
                    context.l10n.upload,
                    style: isDesk
                        ? AppTextStyle.text24.copyWith(
                            decoration: TextDecoration.underline,
                          )
                        : AppTextStyle.text16.copyWith(
                            decoration: TextDecoration.underline,
                          ),
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
                  right: KPadding.kPaddingSize16,
                ),
                child: CheckPointSingleWidget(
                  key: KWidgetkeys.screen.employeeRespond.checkPoint,
                  onChanged: null,
                ),
              ),
              Text(
                key: KWidgetkeys.screen.employeeRespond.noResume,
                context.l10n.noResume,
                style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
              ),
            ],
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox16,
          EmployeeRespondButtonsWidget(isDesk: isDesk),
          if (isDesk)
            KSizedBox.kHeightSizedBox32
          else
            KSizedBox.kHeightSizedBox16,
        ],
      ),
    );
  }
}
