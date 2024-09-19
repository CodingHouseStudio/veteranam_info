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
            selectedPage: _.formState.pageNumber,
          ),
          KSizedBox.kHeightSizedBox40,
          if (_.formState.isMain)
            DropListFieldWidget(
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.categoryUpdate(text)),
              labelText: context.l10n.category,
              dropDownList: _.categoryList,
              isDesk: isDesk,
              showErrorText: _.formState.hasError,
              errorText: _.category.error.value(context),
            )
          else if (_.formState.isDetail)
            TextFieldDescriptionWidget(
              widgetKey: const Key(''),
              isDesk: isDesk,
              description: context.l10n.titleExample,
              labelText: context.l10n.title,
              suffixIcon: KIcon.distance,
              showErrorText: _.formState.hasError,
              errorText: _.city.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.titleUpdate(text)),
            )
          else
            MessageFieldWidget(
              changeMessage: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.descriptionUpdate(text)),
              isDesk: isDesk,
              labelText: context.l10n.description,
              showErrorText: _.formState.hasError,
              errorText: _.description.error.value(context),
            ),
          KSizedBox.kHeightSizedBox32,
          if (_.formState.isMain)
            TextFieldWidget(
              widgetKey: const Key(''),
              labelText: context.l10n.city,
              onChanged: (value) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.cityUpdate(value)),
              isDesk: isDesk,
              suffixIcon: KIcon.distance,
              showErrorText: _.formState.hasError,
              errorText: _.city.error.value(context),
            )
          else if (_.formState.isDetail)
            TextFieldDescriptionWidget(
              widgetKey: const Key(''),
              isDesk: isDesk,
              labelText: context.l10n.discount,
              description: context.l10n.discountDescription,
              suffixIcon: KIcon.distance,
              showErrorText: _.formState.hasError,
              errorText: _.discounts.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.discountUpdate(int.parse(text))),
            )
          else
            TextFieldDescriptionWidget(
              widgetKey: const Key(''),
              isDesk: isDesk,
              labelText: context.l10n.discount,
              description: context.l10n.discountDescription,
              suffixIcon: KIcon.distance,
              showErrorText: _.formState.hasError,
              errorText: _.exclusions.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.exclusionsUpdate(text)),
              isMessage: true,
            ),
          KSizedBox.kHeightSizedBox32,
          if (_.formState.isMain)
            TextFieldWidget(
              widgetKey: const Key(''),
              labelText: context.l10n.period,
              onChanged: (value) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.periodUpdate(value)),
              isDesk: isDesk,
              suffixIcon: KIcon.calendarClock,
              enabled: _.period != null,
              showErrorText: _.formState.hasError,
              errorText: _.period?.error.value(context),
            )
          else if (_.formState.isDetail)
            TextFieldDescriptionWidget(
              widgetKey: const Key(''),
              isDesk: isDesk,
              labelText: context.l10n.link,
              description: context.l10n.linkDescription,
              suffixIcon: KIcon.distance,
              showErrorText: _.formState.hasError,
              errorText: _.discounts.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.linkUpdate(text)),
            ),
          if (!_.formState.isDescription) KSizedBox.kHeightSizedBox8,
          if (_.formState.isMain)
            Row(
              children: [
                SwitchWidgetWithoutBloc(
                  onSelected: ({required isSelected}) => context
                      .read<DiscountsAddBloc>()
                      .add(
                        DiscountsAddEvent.periodUpdate(isSelected ? null : ''),
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
