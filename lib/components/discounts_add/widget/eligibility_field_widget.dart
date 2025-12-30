import 'package:basic_dropdown_button/basic_dropwon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class EligibilityFieldWidget extends StatelessWidget {
  const EligibilityFieldWidget({
    required this.isDesk,
    required this.state,
    super.key,
  });
  final bool isDesk;
  final DiscountsAddState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: KPadding.kPaddingSize8,
      children: [
        BasicDropDownButton(
          buttonStyle: null,
          buttonText: null,
          menuItems: null,
          menuBackgroundColor: null,
          menuVerticalSpacing: KPadding.kPaddingSize8,
          position: DropDownButtonPosition.bottomCenter,
          buttonIcon: null,
          customButton: ({
            required showHideMenuEvent,
            required showMenu,
          }) =>
              InkWell(
            onTap: showHideMenuEvent,
            borderRadius: KBorderRadius.kBorderRadius32,
            mouseCursor: SystemMouseCursors.click,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            child: IgnorePointer(
              child: TextFieldWidget(
                isDesk: isDesk,
                widgetKey: DiscountsAddKeys.eligibilityField,
                labelText: context.l10n.eligibility,
                onChanged: null,
                suffixIcon: showMenu
                    ? IconButton(
                        key: DropListFieldKeys.activeIcon,
                        icon: KIcon.close,
                        onPressed: showHideMenuEvent,
                      )
                    : KIcon.dropListtrailing,
                showErrorText: state.formState.hasError,
                errorText: state.eligibility.error.value(context),
                disabledBorder: KWidgetTheme.outlineInputBorderEnabled,
                description: context.l10n.eligibilityDescription,
                isRequired: true,
              ),
            ),
          ),
          menuList: ({required buttonWidth, required hideMenu}) => Container(
            constraints: BoxConstraints(
              minWidth: buttonWidth,
              maxWidth: buttonWidth,
              maxHeight:
                  isDesk ? KMinMaxSize.maxHeight400 : KMinMaxSize.maxHeight220,
            ),
            decoration: KWidgetTheme.boxDecorationCardShadow,
            clipBehavior: Clip.hardEdge,
            child: ListView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              padding: const EdgeInsets.symmetric(
                vertical: KPadding.kPaddingSize16,
              ),
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return KSizedBox.kHeightSizedBox8;
                } else {
                  final indexValue = index ~/ 2;
                  final value = EligibilityEnum.values.elementAt(indexValue);
                  return TextButton(
                    key: DiscountsAddKeys.eligibilityItems,
                    onPressed: state.eligibility.value.contains(value) ||
                            state.eligibility.value
                                .contains(EligibilityEnum.all)
                        ? null
                        : () {
                            hideMenu();
                            context.read<DiscountsAddBloc>().add(
                                  DiscountsAddEvent.eligibilityAddItem(
                                    value,
                                  ),
                                );
                          },
                    style: KButtonStyles.dropListButtonStyle,
                    child: Text(
                      value.getValue(context),
                      style: AppTextStyle.materialThemeBodyLarge,
                    ),
                  );
                }
              },
              itemCount: EligibilityEnum.values.length * 2 - 1,
            ),
          ),
        ),
        if (state.eligibility.value.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: KPadding.kPaddingSize8,
              runSpacing: KPadding.kPaddingSize8,
              children: List.generate(
                state.eligibility.value.length,
                (index) => CancelChipWidget(
                  widgetKey: DiscountsAddKeys.eligibilityActiveItems,
                  isDesk: isDesk,
                  labelText: state.eligibility.value
                      .elementAt(index)
                      .getValue(context),
                  padding: const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize8,
                    vertical: KPadding.kPaddingSize4,
                  ),
                  textStyle: isDesk
                      ? AppTextStyle.materialThemeTitleMedium
                      : AppTextStyle.materialThemeTitleSmall,
                  onPressed: () => context.read<DiscountsAddBloc>().add(
                        DiscountsAddEvent.eligibilityRemoveItem(
                          state.eligibility.value.elementAt(index),
                        ),
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
