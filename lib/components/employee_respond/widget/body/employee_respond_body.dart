import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../employee_respond_container_widget_list.dart';

class EmployeeRespondBodyWidget extends StatelessWidget {
  const EmployeeRespondBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeRespondBloc, EmployeeRespondState>(
      // buildWhen: (previous, current) => previous.formState !=
      // current.formState,
      builder: (context, state) {
        return ScaffoldDecorationWidget(
          titleChildWidgetsFunction: ({required isDesk}) => [
            if (isDesk)
              KSizedBox.kHeightSizedBox68
            else
              KSizedBox.kHeightSizedBox32,
            Text(
              key: EmployeeRespondKeys.title,
              context.l10n.respond,
              style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
            ),
            KSizedBox.kHeightSizedBox8,
            Row(
              children: [
                KIcon.chevronLeft,
                Text(
                  key: EmployeeRespondKeys.subtitle,
                  KMockText.workTitle,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
              ],
            ),
          ],
          mainDecoration: KWidgetTheme.boxDecorationWidget,
          mainPadding: ({required isDesk, required maxWidth}) =>
              maxWidth.screenPadding(
            precent: KDimensions.fifteenPercent,
            notUseHorizontal: maxWidth > KMinMaxSize.maxWidth640,
            verticalPadding:
                isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
          ),
          mainDecorationPadding: ({required isDesk}) => EdgeInsets.all(
            isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          ),
          mainChildWidgetsFunction: ({required isDesk}) =>
              _employeeRespondContainerWidgetList(
            context: context,
            isDesk: isDesk,
          ),
        );
      },
    );
  }
}
