import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discounts_add/discounts_add.dart';
import 'package:veteranam/shared/shared.dart';

class DiscountsAddBodyWidget extends StatefulWidget {
  const DiscountsAddBodyWidget({required this.discount, super.key});
  final DiscountModel? discount;

  @override
  State<DiscountsAddBodyWidget> createState() => _DiscountsAddBodyWidgetState();
}

class _DiscountsAddBodyWidgetState extends State<DiscountsAddBodyWidget> {
  // late TextEditingController discountsController;
  late TextEditingController titleController;
  late TextEditingController linkController;
  // late TextEditingController categoryController;
  // late TextEditingController cityController;
  late TextEditingController periodController;
  late TextEditingController exclusionController;
  late TextEditingController descriptionController;
  // late TextEditingController eligibilityController;
  @override
  void initState() {
    // discountsController = TextEditingController();
    titleController = TextEditingController(text: widget.discount?.title);
    linkController = TextEditingController(text: widget.discount?.link);
    // categoryController = TextEditingController();
    // cityController = TextEditingController();
    periodController = TextEditingController(text: widget.discount?.expiration);
    exclusionController =
        TextEditingController(text: widget.discount?.exclusions);
    descriptionController =
        TextEditingController(text: widget.discount?.description);
    // eligibilityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscountsAddBloc, DiscountsAddState>(
      listenWhen: (previous, current) =>
          previous.formState != current.formState ||
          previous.period != current.period,
      listener: (context, state) {
        if (state.formState == DiscountsAddEnum.success) {
          context.goNamed(KRoute.myDiscounts.name);
        }
        if (state.formState.isDetail) {
          periodController.text = state.period.value
                  ?.toLocalDateString(context: context, showDay: true) ??
              '';
        }
      },
      // Add because without it we have small lag when fast write some fields
      buildWhen: (previous, current) => !(previous.link != current.link ||
          previous.title != current.title ||
          previous.description != current.description ||
          previous.exclusions != current.exclusions),
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
        isForm: true,
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
          if (_.formState.isDetail)
            MultiDropFieldWidget(
              textFieldKey: KWidgetkeys.screen.discountsAdd.categoryField,
              // controller: categoryController,
              description: context.l10n.categoryDescription,
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.categoryAdd(text)),
              labelText: context.l10n.category,
              dropDownList: _.categoryList,
              isDesk: isDesk,
              showErrorText: _.formState.hasError,
              errorText: _.category.error.value(context),
              removeEvent: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.categoryRemove(text)),
              values: _.category.value,
            )
          else if (_.formState.isMain)
            TextFieldWidget(
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
              maxLength: KMinMaxSize.descriptionMaxLength,
            ),
          KSizedBox.kHeightSizedBox32,
          if (_.formState.isDetail)
            CitiesDropFieldWidget(
              textFieldKey: KWidgetkeys.screen.discountsAdd.cityField,
              removeCity: (value) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.cityRemove(value)),
              // controller: cityController,
              onChanged: (value) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.cityAdd(value)),
              isDesk: isDesk,
              citiesList: _.citiesList,
              showErrorText: _.formState.hasError,
              errorText: _.city.error.value(context),
              selectedCities: _.city.value,
            )
          else if (_.formState.isMain)
            MultiDropFieldWidget(
              textFieldKey: KWidgetkeys.screen.discountsAdd.discountsField,
              // controller: discountsController,
              isDesk: isDesk,
              labelText: context.l10n.discount,
              dropDownList: const [
                '100%',
                '5%',
                '10%',
                '15%',
                '20%',
                '50%',
              ],
              showErrorText: _.formState.hasError,
              errorText: _.discounts.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.discountAddItem(text)),
              values: _.discounts.value,
              removeEvent: (value) => context.read<DiscountsAddBloc>().add(
                    DiscountsAddEvent.discountRemoveItem(value),
                  ),
              errorMaxLines: 3,
              description: context.l10n.discountDescription,
            )
          else
            MessageFieldWidget(
              key: KWidgetkeys.screen.discountsAdd.exclusionField,
              controller: exclusionController,
              isDesk: isDesk,
              labelText: context.l10n.getYouNeed,
              description: context.l10n.getYouNeedDescription,
              // showErrorText: _.formState.hasError,
              // errorText: _.exclusions.error.value(context),
              changeMessage: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.exclusionsUpdate(text)),
            ),
          if (_.formState.isMain) ...[
            KSizedBox.kHeightSizedBox32,
            MultiDropFieldWidget(
              textFieldKey: KWidgetkeys.screen.discountsAdd.eligibilityField,
              // controller: eligibilityController,
              isDesk: isDesk,
              labelText: context.l10n.eligibility,
              isButton: true,
              dropDownList: [
                context.l10n.allOfBelowMentioned,
                context.l10n.veterans,
                context.l10n.combatantsEligibility,
                context.l10n.militaryEligibility,
                context.l10n.fallenFamilyEligibility,
                context.l10n.disabledWarEligibility,
                context.l10n.dsnsEligibility,
                context.l10n.policeEligibility,
                context.l10n.idpEligibility,
              ],
              allElemts: context.l10n.allOfBelowMentioned,
              showErrorText: _.formState.hasError,
              errorText: _.eligibility?.error.value(context),
              onChanged: (text) => context
                  .read<DiscountsAddBloc>()
                  .add(DiscountsAddEvent.eligibilityAddItem(text)),
              values: _.eligibility?.value,
              removeEvent: (value) => context.read<DiscountsAddBloc>().add(
                    DiscountsAddEvent.eligibilityRemoveItem(value),
                  ),
              description: context.l10n.eligibilityDescription,
            ),
          ],
          KSizedBox.kHeightSizedBox32,
          if (_.formState.isDetail)
            TextButton(
              onPressed: _.isIndefinitely
                  ? null
                  : () => context
                      .read<DiscountsAddBloc>()
                      .add(DiscountsAddEvent.periodUpdate(context.getDate)),
              style: KButtonStyles.footerButtonTransparent.copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.zero,
                ),
              ),
              child: TextFieldWidget(
                widgetKey: KWidgetkeys.screen.discountsAdd.periodField,
                controller: periodController,
                labelText: context.l10n.period,
                onChanged: null,
                isDesk: isDesk,
                suffixIcon: KIcon.calendarClock.copyWith(
                  color: _.isIndefinitely
                      ? AppColors.materialThemeRefNeutralVariantNeutralVariant70
                      : null,
                ),
                disabledBorder: KWidgetTheme.outlineInputBorderEnabled,
                cursor: _.isIndefinitely
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                enabled: false,
                showErrorText: !_.isIndefinitely && _.formState.hasError,
                errorText: _.period.error.value(context),
                suffixIconPadding: KPadding.kPaddingSize16,
                labelTextStyle: _.isIndefinitely
                    ? AppTextStyle.materialThemeTitleMediumNeutralVariant70
                    : null,
                textStyle: _.isIndefinitely
                    ? AppTextStyle.materialThemeTitleMediumNeutralVariant70
                    : null,
                // text: _.period.value?.toLocalDateString(
                //   context: context,
                //   showDay: true,
                // ),
              ),
              // [
              //   Text(
              //     context.l10n.period,
              //     style: _.isIndefinitely
              //         ? AppTextStyle.materialThemeTitleMediumNeutralVariant70
              //         : AppTextStyle.materialThemeTitleMedium,
              //   ),
              //   Text(
              //     _.period.value?.toLocalDateString(
              //           context: context,
              //           showDay: true,
              //         ) ??
              //         '',
              //     style: _.isIndefinitely
              //         ? AppTextStyle.materialThemeTitleMediumNeutralVariant70
              //         : AppTextStyle.materialThemeTitleMedium,
              //     textAlign: TextAlign.center,
              //   ),
              //   KIcon.calendarClock,
              // ],
            )
          // child: TextFieldWidget(
          //   widgetKey: KWidgetkeys.screen.discountsAdd.periodField,
          //   controller: periodController,
          //   labelText: context.l10n.period,
          //   onChanged: (value) {},
          //   isDesk: isDesk,
          //   suffixIcon: KIcon.calendarClock,
          //   enabled: _.period != null,
          //   showErrorText: _.formState.hasError,
          //   errorText: _.period?.error.value(context),
          // ),

          else if (_.formState.isMain)
            TextFieldWidget(
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
          if (_.formState.isDetail) ...[
            Row(
              children: [
                SwitchWidget(
                  key: KWidgetkeys.screen.discountsAdd.indefinitelySwitcher,
                  onChanged: () => context.read<DiscountsAddBloc>().add(
                        const DiscountsAddEvent.indefinitelyUpdate(),
                      ),
                  isSelected: _.isIndefinitely,
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
          KSizedBox.kHeightSizedBox32,
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
          Expanded(child: _cancelButton(context: context, isDesk: isDesk))
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
      SecondaryButtonWidget(
        widgetKey: KWidgetkeys.screen.discountsAdd.cancelButton,
        align: Alignment.center,
        onPressed: context.read<DiscountsAddBloc>().state.formState.isMain
            ? () => context.dialog.showConfirmationDialog(
                  isDesk: isDesk,
                  title: context.l10n.cancelChanges,
                  subtitle: context.l10n.cancelChangesQuestion,
                  confirmText: context.l10n.cancel,
                  unconfirmText: context.l10n.continueWorking,
                  background: AppColors.materialThemeKeyColorsSecondary,
                  onPressed: () {
                    context.goNamed(KRoute.myDiscounts.name);
                  },
                )
            : () => context.read<DiscountsAddBloc>().add(
                  const DiscountsAddEvent.back(),
                ),
        text: context.read<DiscountsAddBloc>().state.formState.isMain
            ? context.l10n.cancel
            : context.l10n.back,
        isDesk: isDesk,
      );
  Widget _sendButton({
    required BuildContext context,
    required bool isDesk,
  }) =>
      DoubleButtonWidget(
        key: KWidgetkeys.screen.discountsAdd.sendButton,
        align: Alignment.center,
        text: context.read<DiscountsAddBloc>().state.formState.isDescription
            ? context.l10n.publish
            : context.l10n.next,
        isDesk: isDesk,
        onPressed: () => context.read<DiscountsAddBloc>().add(
              DiscountsAddEvent.send(
                context.read<DiscountsAddBloc>().state.formState.isDescription
                    ? widget.discount
                    : null,
              ),
            ),
        mobTextWidth: double.infinity,
        widgetKey: const Key(''),
        deskTextWidth: double.infinity,
        darkMode: true,
        mobVerticalTextPadding: KPadding.kPaddingSize16,
        mobIconPadding: KPadding.kPaddingSize16,
      );

  @override
  void dispose() {
    super.dispose();
    // discountsController.dispose();
    titleController.dispose();
    linkController.dispose();
    // categoryController.dispose();
    // cityController.dispose();
    periodController.dispose();
    exclusionController.dispose();
    descriptionController.dispose();
    // eligibilityController.dispose();
  }
}
