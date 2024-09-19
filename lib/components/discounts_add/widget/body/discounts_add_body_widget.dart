import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddBodyWidget extends StatelessWidget {
  const DiscountsAddBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountsAddBloc, DiscountsAddState>(
      builder: (context, _) => ScaffoldWidget(
        titleDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
          precent: KDimensions.fifteenPercent,
        ),
        titleChildWidgetsFunction: ({required isDesk}) => [
          KSizedBox.kHeightSizedBox24,
          ShortTitleIconWidget(
            title: context.l10n.offerDiscount,
            titleKey: KWidgetkeys.screen.signUp.title,
            isDesk: isDesk,
            expanded: true,
          ),
        ],
        mainDeskPadding: ({required double maxWidth}) =>
            maxWidth.screenPadding(precent: KDimensions.thirtyPercent),
        mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
          KSizedBox.kHeightSizedBox40,
          BreadcrumbsWidget(
            pageName: [
              context.l10n.main,
              context.l10n.details,
              context.l10n.description,
            ],
            selectedPage: context.l10n.details,
          ),
          KSizedBox.kHeightSizedBox40,
          DropListFieldWidget(
            onChanged: (text) => context
                .read<DiscountsAddBloc>()
                .add(DiscountsAddEvent.updateCategory(text)),
            hintText: context.l10n.category,
            dropDownList: _.categoryList,
            isDesk: isDesk,
          ),
          KSizedBox.kHeightSizedBox32,
          TextFieldWidget(
            widgetKey: const Key(''),
            onChanged: (value) => context
                .read<DiscountsAddBloc>()
                .add(DiscountsAddEvent.updateCity(value)),
            isDesk: isDesk,
            suffixIcon: KIcon.distance,
          ),
          KSizedBox.kHeightSizedBox32,
          TextFieldWidget(
            widgetKey: const Key(''),
            onChanged: (value) => context
                .read<DiscountsAddBloc>()
                .add(DiscountsAddEvent.updatePeriod(value)),
            isDesk: isDesk,
            suffixIcon: KIcon.calendarClock,
          ),
          KSizedBox.kHeightSizedBox8,
          Row(
            children: [
              SwitchWidgetWithoutBloc(
                onSelected: ({required isSelected}) => context
                    .read<DiscountsAddBloc>()
                    .add(
                      DiscountsAddEvent.updatePeriod(isSelected ? null : ''),
                    ),
              ),
              KSizedBox.kWidthSizedBox16,
              Text(
                context.l10n.indefinitely,
                style: AppTextStyle.materialThemeBodyLarge,
              ),
            ],
          ),
          KSizedBox.kHeightSizedBox40,
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => context.pop(),
                  style: KButtonStyles.borderBlackButtonStyle.copyWith(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize16,
                      ),
                    ),
                  ),
                  child: Text(
                    context.l10n.cancel,
                    style: AppTextStyle.materialThemeTitleMedium,
                  ),
                ),
              ),
              KSizedBox.kWidthSizedBox40,
              Expanded(
                child: DoubleButtonWidget(
                  text: context.l10n.next,
                  isDesk: isDesk,
                  onPressed: () => context.read<DiscountsAddBloc>().add(
                        const DiscountsAddEvent.send(),
                      ),
                  mobTextWidth: double.infinity,
                  widgetKey: const Key(''),
                  deskTextWidth: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
