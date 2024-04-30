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
          context.l10n.respond,
          key: const Key(''),
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          KMockText.workTitle,
          
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,

         Container(
          padding: const EdgeInsets.all(KPadding.kPaddingSize32),
          margin: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize240,
          ),
          
          constraints: const BoxConstraints(
            maxWidth: KMinMaxSize.maxWidth768,
          ),
          decoration: KWidgetTheme.boxDecorationWidget,
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                KMockText.userName,
                style: isDesk ? AppTextStyle.text40 : AppTextStyle.text32,
              ),
              if(isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
           
              Text(
                context.l10n.email, 
                style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
              ),
              TextFieldWidget(
                widgetKey: const Key(''), 
                onChanged: (value) {}, 
                hintText: context.l10n.emailHint,
              ),
              if(isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox16,
              
              Text(
                context.l10n.phoneNumber, 
                style: isDesk ? AppTextStyle.text32 : AppTextStyle.text24,
              ),
              TextFieldWidget(
                widgetKey: const Key(''), 
                onChanged: (value) {}, 
                hintText: context.l10n.emailHint,
              ),
            ],
            ),
         ),
      ],
    );
  }
}
