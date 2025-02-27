import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsAddBodyWidget extends StatefulWidget {
  const DiscountsAddBodyWidget({required this.discountId, super.key});

  final String? discountId;
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
  late TextEditingController requirmentsController;
  late TextEditingController descriptionController;
  late TextEditingController emailController;
  // late TextEditingController eligibilityController;
  @override
  void initState() {
    // discountsController = TextEditingController();
    titleController = TextEditingController(text: '');
    linkController = TextEditingController(text: '');
    // categoryController = TextEditingController();
    // cityController = TextEditingController();
    periodController = TextEditingController(text: '');
    requirmentsController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    // eligibilityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CompanyWatcherBloc, CompanyWatcherState>(
          listener: (context, state) {
            if (context.read<DiscountsAddBloc>().state.discount == null) {
              context.read<DiscountsAddBloc>().add(
                    DiscountsAddEvent.loadedDiscount(
                      discount: null,
                      discountId: widget.discountId,
                    ),
                  );
            }
          },
          listenWhen: (previous, current) =>
              previous.company.id != current.company.id &&
              widget.discountId != null,
        ),
        BlocListener<DiscountsAddBloc, DiscountsAddState>(
          listenWhen: (previous, current) =>
              previous.formState != current.formState ||
              previous.period != current.period ||
              previous.discount == null,
          listener: (context, state) {
            if (state.formState == DiscountsAddEnum.success) {
              context.goNamed(KRoute.myDiscounts.name);
            }
            if (state.formState.isDetail) {
              periodController.text = state.period.value
                      ?.toLocalDateString(context: context, showDay: true) ??
                  '';
            }
            if (state.formState == DiscountsAddEnum.initial &&
                state.discount != null) {
              titleController.text =
                  state.discount!.title.getTrsnslation(context);
              linkController.text =
                  state.discount!.directLink ?? linkController.text;
              // categoryController = TextEditingController();
              // cityController = TextEditingController();
              periodController.setNewText(
                state.discount!.expiration?.getTrsnslation(context),
              );
              requirmentsController.setNewText(
                state.discount!.requirements?.getTrsnslation(context),
              );
              descriptionController.text =
                  state.discount!.description.getTrsnslation(context);
            }
          },
        ),
      ],
      child: BlocBuilder<DiscountsAddBloc, DiscountsAddState>(
        // Add because without it we have small lag when fast write some fields
        buildWhen: (previous, current) =>
            !(previous.link != current.link ||
                previous.title != current.title ||
                previous.description != current.description ||
                previous.requirements != current.requirements) ||
            (current.discount != previous.discount) ||
            current.formState != previous.formState,
        builder: (context, _) => ScaffoldWidget(
          titleDeskPadding: _.failure.linkIsWrong
              ? null
              : ({required maxWidth}) => maxWidth.screenPadding(
                    precent: KDimensions.fifteenPercent,
                  ),
          titleChildWidgetsFunction: ({required isDesk}) => [
            KSizedBox.kHeightSizedBox24,
            ShortTitleIconWidget(
              title: _.failure.linkIsWrong
                  ? context.l10n.invalidLinkTitle
                  : context.l10n.offerDiscount,
              titleKey: DiscountsAddKeys.title,
              isDesk: isDesk,
              expanded: !(_.failure.linkIsWrong && isDesk),
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
          isForm: true,
          mainDeskPadding: ({required double maxWidth}) =>
              maxWidth.screenPadding(precent: KDimensions.thirtyPercent),
          mainChildWidgetsFunction: ({required isDesk, required isTablet}) => _
                  .failure.linkIsWrong
              ? [
                  if (isDesk)
                    KSizedBox.kHeightSizedBox80
                  else
                    KSizedBox.kHeightSizedBox24,
                  KIcon.found.copyWith(
                    key: DiscountsAddKeys.imageWrongLink,
                  ),
                  KSizedBox.kHeightSizedBox24,
                  Text(
                    context.l10n.discountEditNotFound,
                    key: DiscountsAddKeys.textWrongLink,
                    style: AppTextStyle.materialThemeTitleMedium,
                    textAlign: isDesk ? TextAlign.center : TextAlign.start,
                  ),
                  KSizedBox.kHeightSizedBox16,
                  Align(
                    alignment: isDesk ? Alignment.center : Alignment.centerLeft,
                    child: TextButton(
                      key: DiscountsAddKeys.buttonWrongLink,
                      onPressed: () => context.goNamed(KRoute.myDiscounts.name),
                      style: KButtonStyles.borderBlackDiscountAddButtonStyle,
                      child: Text(
                        context.l10n.back,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                    ),
                  ),
                ]
              : [
                  KSizedBox.kHeightSizedBox40,
                  BreadcrumbsWidget(
                    key: DiscountsAddKeys.pageIndicator,
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
                      textFieldKey: DiscountsAddKeys.categoryField,
                      // controller: categoryController,
                      description: context.l10n.categoryDescription,
                      onChanged: (text) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.categoryAdd(text)),
                      isRequired: true,
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
                      widgetKey: DiscountsAddKeys.titleField,
                      controller: titleController,
                      isRequired: true,
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
                      key: DiscountsAddKeys.descriptionField,
                      controller: descriptionController,
                      changeMessage: (text) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.descriptionUpdate(text)),
                      isDesk: isDesk,
                      isRequired: true,
                      labelText: context.l10n.description,
                      showErrorText: _.formState.hasError,
                      errorText: _.description.error.value(context),
                      maxLength: KMinMaxSize.descriptionMaxLength,
                    ),
                  KSizedBox.kHeightSizedBox32,
                  if (_.formState.isDetail) ...[
                    CitiesDropFieldWidget(
                      textFieldKey: DiscountsAddKeys.cityField,
                      removeCity: (value) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.cityRemove(value)),
                      // controller: cityController,
                      onChanged: (value) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.cityAdd(value)),
                      isDesk: isDesk, isRequired: true,
                      citiesList: _.citiesList,
                      showErrorText: _.formState.hasError && !_.isOnline,
                      errorText: _.city.error.value(context),
                      selectedCities: _.city.value,
                    ),
                    Row(
                      spacing: KPadding.kPaddingSize16,
                      children: [
                        SwitchWidget(
                          key: DiscountsAddKeys.onlineSwitcher,
                          onChanged: () => context.read<DiscountsAddBloc>().add(
                                const DiscountsAddEvent.onlineSwitch(),
                              ),
                          isSelected: _.isOnline,
                        ),
                        Expanded(
                          child: Text(
                            context.l10n.online,
                            key: DiscountsAddKeys.onlineText,
                            style: AppTextStyle.materialThemeBodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ] else if (_.formState.isMain)
                    MultiDropFieldWidget(
                      textFieldKey: DiscountsAddKeys.discountsField,
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
                      isRequired: true,
                      showErrorText: _.formState.hasError,
                      errorText: _.discounts.error.value(context),
                      onChanged: (text) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.discountAddItem(text)),
                      values: _.discounts.value,
                      removeEvent: (value) =>
                          context.read<DiscountsAddBloc>().add(
                                DiscountsAddEvent.discountRemoveItem(value),
                              ),
                      description: context.l10n.discountDescription,
                    )
                  else
                    MessageFieldWidget(
                      key: DiscountsAddKeys.exclusionField,
                      controller: requirmentsController,
                      isDesk: isDesk,
                      labelText: context.l10n.getYouNeed,
                      description: context.l10n.getYouNeedDescription,
                      // showErrorText: _.formState.hasError,
                      // errorText: _.exclusions.error.value(context),
                      changeMessage: (text) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.requirementsUpdate(text)),
                    ),
                  if (_.formState.isMain) ...[
                    KSizedBox.kHeightSizedBox32,
                    MultiDropFieldWidget(
                      textFieldKey: DiscountsAddKeys.eligibilityField,
                      // controller: eligibilityController,
                      isDesk: isDesk,
                      labelText: context.l10n.eligibility, isRequired: true,
                      isButton: true,
                      dropDownList: List.generate(
                        EligibilityEnum.values.length,
                        (index) => EligibilityEnum.values
                            .elementAt(index)
                            .getValue(context),
                      ),
                      allElemts: context.l10n.allOfListed,
                      showErrorText: _.formState.hasError,
                      errorText: _.eligibility.error.value(context),
                      onChanged: (text) => context.read<DiscountsAddBloc>().add(
                            DiscountsAddEvent.eligibilityAddItem(
                              text,
                            ),
                          ),
                      values: List.generate(
                        _.eligibility.value.length,
                        (index) => _.eligibility.value
                            .elementAt(index)
                            .getValue(context),
                        growable: false,
                      ),
                      removeEvent: (value) =>
                          context.read<DiscountsAddBloc>().add(
                                DiscountsAddEvent.eligibilityRemoveItem(
                                  value,
                                ),
                              ),
                      description: context.l10n.eligibilityDescription,
                    ),
                  ],
                  KSizedBox.kHeightSizedBox32,
                  if (_.formState.isDetail) ...[
                    TextButton(
                      onPressed: _.isIndefinitely
                          ? null
                          : () => context.read<DiscountsAddBloc>().add(
                                DiscountsAddEvent.periodUpdate(
                                  context.getDate(currecntDate: _.period.value),
                                ),
                              ),
                      style: KButtonStyles.discountAddButtonTransparent,
                      child: TextFieldWidget(
                        widgetKey: DiscountsAddKeys.periodField,
                        controller: periodController,
                        labelText: context.l10n.period,
                        onChanged: null,
                        isDesk: isDesk,
                        suffixIcon: _.isIndefinitely
                            ? KIcon.calendarClock
                            : KIcon.calendarClockVariant70,
                        disabledBorder: KWidgetTheme.outlineInputBorderEnabled,
                        cursor: _.isIndefinitely
                            ? SystemMouseCursors.basic
                            : SystemMouseCursors.click,
                        enabled: false,
                        showErrorText:
                            !_.isIndefinitely && _.formState.hasError,
                        errorText: _.period.error.value(context),
                        suffixIconPadding: KPadding.kPaddingSize16,
                        labelTextStyle: _.isIndefinitely
                            ? AppTextStyle
                                .materialThemeTitleMediumNeutralVariant70
                            : null,
                        textStyle: _.isIndefinitely
                            ? AppTextStyle
                                .materialThemeTitleMediumNeutralVariant70
                            : null,
                      ),
                    ),
                    Row(
                      spacing: KPadding.kPaddingSize16,
                      children: [
                        SwitchWidget(
                          key: DiscountsAddKeys.indefinitelySwitcher,
                          onChanged: () => context.read<DiscountsAddBloc>().add(
                                const DiscountsAddEvent.indefinitelyUpdate(),
                              ),
                          isSelected: _.isIndefinitely,
                        ),
                        Expanded(
                          child: Text(
                            context.l10n.indefinitely,
                            key: DiscountsAddKeys.indefinitelyText,
                            style: AppTextStyle.materialThemeBodyLarge,
                          ),
                        ),
                      ],
                    ),
                    KSizedBox.kHeightSizedBox8,
                  ] else if (_.formState.isMain)
                    TextFieldWidget(
                      widgetKey: DiscountsAddKeys.linkField,
                      controller: linkController,
                      isDesk: isDesk,
                      labelText: context.l10n.link,
                      description: context.l10n.discountLinkDescription,
                      showErrorText: _.formState.hasError,
                      errorText: _.link.error.value(context),
                      onChanged: (text) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.linkUpdate(text)),
                    )
                  else if (context
                          .read<CompanyWatcherBloc>()
                          .state
                          .company
                          .isAdmin &&
                      _.discount == null)
                    TextFieldWidget(
                      widgetKey: DiscountsAddKeys.emailField,
                      controller: emailController,
                      isDesk: isDesk,
                      labelText: context.l10n.companyEmail,
                      description: context.l10n.showOnlyForAdminAccount,
                      showErrorText: _.formState.hasError,
                      errorText: _.email.error.value(context),
                      onChanged: (text) => context
                          .read<DiscountsAddBloc>()
                          .add(DiscountsAddEvent.emailUpdate(text)),
                      isRequired: true,
                    ),
                  SendingTextWidget(
                    textKey: DiscountsAddKeys.submitingText,
                    failureText: _.failure?.value(context),
                    sendingText: context.l10n.dataSendInProgress,
                    showSuccessText: _.formState == DiscountsAddEnum.success,
                    successText: context.l10n.dataIsSavedSuccess,
                    showSendingText:
                        _.formState == DiscountsAddEnum.sendInProgress,
                  ),
                  if (!_.formState.isDescription ||
                      context.read<CompanyWatcherBloc>().state.company.isAdmin)
                    KSizedBox.kHeightSizedBox40,
                  if (isDesk)
                    Row(
                      spacing: KPadding.kPaddingSize40,
                      children:
                          _buttons(context: context, isDesk: true, state: _),
                    )
                  else
                    ..._buttons(context: context, isDesk: false, state: _)
                        .reversed,
                  KSizedBox.kHeightSizedBox32,
                ],
        ),
      ),
    );
  }

  List<Widget> _buttons({
    required BuildContext context,
    required bool isDesk,
    required DiscountsAddState state,
  }) =>
      [
        if (isDesk)
          Expanded(
            child:
                _cancelButton(context: context, isDesk: isDesk, state: state),
          )
        else
          _cancelButton(context: context, isDesk: isDesk, state: state),
        if (!isDesk) KSizedBox.kHeightSizedBox24,
        if (isDesk)
          Expanded(
            child: _sendButton(context: context, isDesk: isDesk, state: state),
          )
        else
          _sendButton(context: context, isDesk: isDesk, state: state),
      ];
  Widget _cancelButton({
    required BuildContext context,
    required bool isDesk,
    required DiscountsAddState state,
  }) =>
      SecondaryButtonWidget(
        widgetKey: DiscountsAddKeys.cancelButton,
        align: Alignment.center,
        onPressed: state.formState.isLoading
            ? null
            : state.formState.isMain
                ? () => context.dialog.showConfirmationDialog(
                      isDesk: isDesk,
                      title: context.l10n.cancelChanges,
                      subtitle: context.l10n.cancelChangesQuestion,
                      confirmText: context.l10n.cancel,
                      unconfirmText: context.l10n.continueWorking,
                      confirmButtonBackground:
                          AppColors.materialThemeKeyColorsSecondary,
                      onAppliedPressed: () {
                        context.goNamed(KRoute.myDiscounts.name);
                      },
                    )
                : () => context.read<DiscountsAddBloc>().add(
                      const DiscountsAddEvent.back(),
                    ),
        text: state.formState.isMain ? context.l10n.cancel : context.l10n.back,
        isDesk: isDesk,
      );
  Widget _sendButton({
    required BuildContext context,
    required bool isDesk,
    required DiscountsAddState state,
  }) =>
      BlocListener<DiscountsAddBloc, DiscountsAddState>(
        listenWhen: (previous, current) =>
            previous.formState != current.formState &&
            current.formState == DiscountsAddEnum.showDialog,
        listener: (contextValue, state) {
          context.dialog.showConfirmationPublishDiscountDialog(
            isDesk: isDesk,
            onPressed: () => _sendEvent(context),
            onClose: () => context.read<DiscountsAddBloc>().add(
                  const DiscountsAddEvent.closeDialog(),
                ),
          );
        },
        child: DoubleButtonWidget(
          key: DiscountsAddKeys.sendButton,
          align: Alignment.center,
          text: state.formState.isDescription
              ? state.discount == null
                  ? context.l10n.publish
                  : context.l10n.update
              : context.l10n.next,
          isDesk: isDesk,
          onPressed:
              state.formState.isLoading ? null : () => _sendEvent(context),
          mobTextWidth: double.infinity,
          widgetKey: const Key(''),
          deskTextWidth: double.infinity,
          darkMode: true,
          mobVerticalTextPadding: KPadding.kPaddingSize16,
          mobIconPadding: KPadding.kPaddingSize16,
        ),
      );

  void _sendEvent(BuildContext context) => context.read<DiscountsAddBloc>().add(
        const DiscountsAddEvent.send(),
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
    requirmentsController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    // eligibilityController.dispose();
  }
}
