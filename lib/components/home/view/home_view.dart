import 'package:flutter/material.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/dimensions/size_constants.dart';
import 'package:veteranam/shared/constants/theme/app_colors.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/widget/mob_navigation_widget.dart'
    deferred as bottm_nav_bar;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = HomeBlocprovider(
      key: KWidgetkeys.screen.home.screen,
      childWidget: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Config.isWeb
            ? null
            : FutureBuilder(
                future: bottm_nav_bar.loadLibrary(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return bottm_nav_bar.MobNavigationWidget(
                      index: 0,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
        appBar: AppBar(
          backgroundColor: AppColors.materialThemeWhite,
          toolbarHeight: KSize.kAppBarHeight,
        ),
        body: const HomeBodyWidget(),
      ),
    );
    if (Config.isWeb) {
      return scaffold;
    }
    return SafeArea(child: scaffold);
  }
}
