import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddBodyWidget extends StatefulWidget {
  const DiscountsAddBodyWidget({super.key});

  @override
  State<DiscountsAddBodyWidget> createState() => _DiscountsAddBodyWidgetState();
}

class _DiscountsAddBodyWidgetState extends State<DiscountsAddBodyWidget> {
  late TextEditingController discountsController;
  late TextEditingController titleController;
  late TextEditingController linkController;
  late TextEditingController categoryController;
  late TextEditingController cityController;
  late TextEditingController periodController;
  late TextEditingController exclusionController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    super.initState();
    discountsController = TextEditingController();
    titleController = TextEditingController();
    linkController = TextEditingController();
    categoryController = TextEditingController();
    cityController = TextEditingController();
    periodController = TextEditingController();
    exclusionController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    discountsController.dispose();
    titleController.dispose();
    linkController.dispose();
    categoryController.dispose();
    cityController.dispose();
    periodController.dispose();
    exclusionController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscountsAddBloc, DiscountsAddState>(
      listener: (context, state) {
        if (state.formState == DiscountsAddEnum.success) {
          context.goNamed(KRoute.myDiscounts.name);
        }
      },
      builder: (context, _) => ScaffoldWidget(
        titleDeskPadding: ({required maxWidth}) => maxWidth.screenPadding(
          precent: KDimensions.fifteenPercent,
        ),
        titleChildWidgetsFunction: ({required isDesk}) => [
          KSizedBox.kHeightSizedBox24,
          ShortTitleIconWidget(
            title: context.l10n.offerDiscount,
            titleKey: KWidgetkeys.screen.discountsAdd.title,
            isDesk: isDesk,
            expanded: true,
          ),
        ],
        mainDeskPadding: ({required double maxWidth}) =>
            maxWidth.screenPadding(precent: KDimensions.thirtyPercent),
        mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
          KSizedBox.kHeightSizedBox40,
          BreadcrumbsWidget(
            key: KWidgetkeys.screen.discountsAdd.pageIndicator,
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
              key: KWidgetkeys.screen.discountsAdd.categoryField,
              controller: categoryController,
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
              widgetKey: KWidgetkeys.screen.discountsAdd.titleField,
              controller: titleController,
              isDesk: isDesk,
              description: context.l10n.titleExample,
              labelText: context.l10n.title,
              showErrorText: _.formState.hasError,
              errorText: _.title.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.titleUpdate(text)),
              maxLength: KMinMaxSize.titleMaxLength,
            )
          else
            MessageFieldWidget(
              key: KWidgetkeys.screen.discountsAdd.descriptionField,
              controller: descriptionController,
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
              widgetKey: KWidgetkeys.screen.discountsAdd.cityField,
              controller: cityController,
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
              childWidget: MultiDropFieldWidget(
                key: KWidgetkeys.screen.discountsAdd.discountsField,
                controller: discountsController,
                isDesk: isDesk,
                labelText: context.l10n.discount,
                dropDownList: [
                  context.l10n.free,
                  '5%',
                  '10%',
                  '15%',
                  '20%',
                  '50%',
                ],
                // suffixIcon: KIcon.distance,
                showErrorText: _.formState.hasError,
                errorText: _.discounts.error.value(context),
                onChanged: (text) => context
                    .read<DiscountsAddBloc>()
                    .add(DiscountsAddEvent.discountAddItem(text)),
                values: _.discounts.value,
                removeEvent: (String value) =>
                    context.read<DiscountsAddBloc>().add(
                          DiscountsAddEvent.discountRemoveItem(value),
                        ),
                // errorMaxLines: 3,
              ),
              widgetKey: null,
              isDesk: isDesk,
              description: context.l10n.discountDescription,
              labelText: null,
            )
          else
            TextFieldDescriptionWidget(
              widgetKey: KWidgetkeys.screen.discountsAdd.exclusionField,
              controller: exclusionController,
              isDesk: isDesk,
              labelText: context.l10n.getYouNeed,
              description: context.l10n.getYouNeedDescription,
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
              widgetKey: KWidgetkeys.screen.discountsAdd.periodField,
              controller: periodController,
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
              widgetKey: KWidgetkeys.screen.discountsAdd.linkField,
              controller: linkController,
              isDesk: isDesk,
              labelText: context.l10n.link,
              description: context.l10n.linkDescription,
              showErrorText: _.formState.hasError,
              errorText: _.link.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.linkUpdate(text)),
            ),
          if (_.formState.isMain) ...[
            Row(
              children: [
                SwitchWidgetWithoutBloc(
                  key: KWidgetkeys.screen.discountsAdd.indefinitelySwitcher,
                  onSelected: ({required isSelected}) => context
                      .read<DiscountsAddBloc>()
                      .add(
                        DiscountsAddEvent.periodUpdate(isSelected ? null : ''),
                      ),
                ),
                KSizedBox.kWidthSizedBox16,
                Expanded(
                  child: Text(
                    context.l10n.indefinitely,
                    key: KWidgetkeys.screen.discountsAdd.indefinitelyText,
                    style: AppTextStyle.materialThemeBodyLarge,
                  ),
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox8,
          ],
          if (!_.formState.isDescription) KSizedBox.kHeightSizedBox40,
          if (isDesk)
            Row(
              children: _buttons(context: context, isDesk: true),
            )
          else
            ..._buttons(context: context, isDesk: false).reversed,
        ],
      ),
    );
  }

  List<Widget> _buttons({
    required BuildContext context,
    required bool isDesk,
  }) =>
      [
        if (isDesk)
          Expanded(
            child: _cancelButton(context: context, isDesk: isDesk),
          )
        else
          _cancelButton(context: context, isDesk: isDesk),
        if (isDesk) KSizedBox.kWidthSizedBox40 else KSizedBox.kHeightSizedBox24,
        if (isDesk)
          Expanded(
            child: _sendButton(context: context, isDesk: isDesk),
          )
        else
          _sendButton(context: context, isDesk: isDesk),
      ];
  Widget _cancelButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      TextButton(
        key: KWidgetkeys.screen.discountsAdd.cancelButton,
        onPressed: () => context.read<DiscountsAddBloc>().state.formState.isMain
            ? context.pop()
            : context.read<DiscountsAddBloc>().add(
                  const DiscountsAddEvent.back(),
                ),
        style: KButtonStyles.borderBlackButtonStyle.copyWith(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize16,
            ),
          ),
        ),
        child: Text(
          context.read<DiscountsAddBloc>().state.formState.isMain
              ? context.l10n.cancel
              : context.l10n.back,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
      );
  Widget _sendButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      DoubleButtonWidget(
        key: KWidgetkeys.screen.discountsAdd.sendButton,
        text: context.read<DiscountsAddBloc>().state.formState.isDescription
            ? context.l10n.publish
            : context.l10n.next,
        isDesk: isDesk,
        onPressed: () => context.read<DiscountsAddBloc>().add(
              const DiscountsAddEvent.send(),
            ),
        mobTextWidth: double.infinity,
        widgetKey: const Key(''),
        deskTextWidth: double.infinity,
        darkMode: true,
        mobVerticalTextPadding: KPadding.kPaddingSize16,
        mobIconPadding: KPadding.kPaddingSize16,
      );
}
