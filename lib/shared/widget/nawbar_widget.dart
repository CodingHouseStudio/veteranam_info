import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class NawbarWidget extends StatefulWidget implements PreferredSizeWidget {
  const NawbarWidget({
    required this.isDesk,
    this.hasMicrophone = true,
    super.key,
  });
  final bool isDesk;
  final bool hasMicrophone;

  @override
  Size get preferredSize => const Size.fromHeight(KSize.kPreferredSize);

  @override
  State<NawbarWidget> createState() => _NawbarWidgetState();

  @override
  StatefulElement createElement() {
    return StatefulElement(this);
  }
}

class _NawbarWidgetState extends State<NawbarWidget> {
  late FocusNode focusNode;
  late bool isFocused = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(
      () => setState(() {
        isFocused = focusNode.hasFocus;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidetTheme.boxDecorationCard,
      margin: EdgeInsets.only(
        left: widget.isDesk ? KPadding.kPaddingSize90 : KPadding.kPaddingSize16,
        right:
            widget.isDesk ? KPadding.kPaddingSize90 : KPadding.kPaddingSize16,
        top: KPadding.kPaddingSize24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSize8),
        child: Row(
          children: [
            if (widget.isDesk || !isFocused)
              Padding(
                padding: EdgeInsets.only(
                  left: widget.isDesk
                      ? KPadding.kPaddingSize24
                      : KPadding.kPaddingSize8,
                ),
                child: InkWell(
                  onTap: () => EasyDebounce.debounce(
                    context.l10n.logo,
                    const Duration(milliseconds: 500),
                    () => context.goNamed(KRoute.home.name),
                  ),
                  child: Text(
                    context.l10n.logo,
                    key: KWidgetkeys.widget.nawbar.title,
                    style: widget.isDesk
                        ? AppTextStyle.text32
                        : AppTextStyle.text24,
                  ),
                ),
              ),
            if (widget.isDesk)
              KSizedBox.kWidthSizedBox40
            else
              KSizedBox.kWidthSizedBox22,
            Expanded(
              child: TextFieldWidget(
                key: _formKey,
                widgetKey: KWidgetkeys.widget.nawbar.field,
                hintStyle:
                    widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                focusNode: focusNode,
                prefixIcon: KIcon.search,
                onChanged: (text) {},
                hintText: context.l10n.search,
                suffixIcon: widget.isDesk || !widget.hasMicrophone
                    ? null
                    : KIcon.mic.setIconKey(
                        KWidgetkeys.widget.nawbar.iconMic,
                      ),
                border: KBorder.outlineInputTransparent,
                enabledBorder: KBorder.outlineInputTransparent,
                focusedBorder: KBorder.outlineInputTransparent,
                disposeFocusNode: false,
                isDesk: widget.isDesk,
                contentPadding: widget.isDesk
                    ? EdgeInsets.zero
                    : const EdgeInsets.all(KPadding.kPaddingSize16),
              ),
            ),
            if (widget.isDesk && widget.hasMicrophone)
              Padding(
                padding: const EdgeInsets.only(right: KPadding.kPaddingSize32),
                child: IconWidget(
                  key: KWidgetkeys.widget.nawbar.iconMic,
                  icon: KIcon.mic,
                ),
              ),
            if (widget.isDesk || !isFocused)
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
                child: LanguagesSwitcherWidget(),
              ),
            if (context.read<AuthenticationBloc>().state.user == null)
              if (widget.isDesk)
                TextButton(
                  key: KWidgetkeys.widget.nawbar.button,
                  style: KButtonStyles.whiteButtonStyle,
                  onPressed: () => context.goNamed(KRoute.login.name),
                  child: Text(
                    context.l10n.login,
                    style: AppTextStyle.text24,
                  ),
                )
              else if (!isFocused)
                InkWell(
                  onTap: () => context.goNamed(KRoute.login.name),
                  child: IconWidget(
                    key: KWidgetkeys.widget.nawbar.iconPerson,
                    icon: KIcon.person,
                  ),
                ),
            if (context.read<AuthenticationBloc>().state.user != null)
              if (!isFocused || widget.isDesk)
                if (context.read<AuthenticationBloc>().state.user!.photo ==
                    null)
                  InkWell(
                    onTap: () => context.goNamed(KRoute.profile.name),
                    child: IconWidget(
                      key: KWidgetkeys.widget.nawbar.iconPerson,
                      icon: KIcon.person,
                    ),
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(KSize.kUserPhoto),
                    child: InkWell(
                      onTap: () => context.goNamed(KRoute.profile.name),
                      child: CachedNetworkImage(
                        imageUrl: context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .photo!,
                        placeholder: (context, url) => Image.asset(''),
                        errorWidget: (context, url, error) => KIcon.error,
                        fit: BoxFit.contain,
                        width: KSize.kUserPhoto,
                        height: KSize.kUserPhoto,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
