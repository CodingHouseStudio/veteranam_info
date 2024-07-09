part of 'body/investors_body_widget.dart';

List<Widget> _investorsImageWidgetList({required bool isDesk}) {
  if (isDesk) {
    return [
      Column(
        key: KWidgetkeys.screen.investors.leftImages,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _leftImage(isDesk: isDesk),
      ),
      KSizedBox.kWidthSizedBox24,
      Column(
        key: KWidgetkeys.screen.investors.rightImages,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _rightImage(isDesk: isDesk),
      ),
    ];
  } else {
    return [
      Row(
        children: [
          Expanded(
            child: Column(
              key: KWidgetkeys.screen.investors.rightImages,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _leftImage(isDesk: isDesk),
            ),
          ),
          KSizedBox.kWidthSizedBox8,
          Expanded(
            child: Column(
              key: KWidgetkeys.screen.investors.leftImages,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _rightImage(isDesk: isDesk),
            ),
          ),
        ],
      ),
    ];
  }
}

List<Widget> _leftImage({required bool isDesk}) => [
      KImage.veteran1(),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      KImage.veteran2(),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      KImage.veteran3(),
    ];
List<Widget> _rightImage({required bool isDesk}) => [
      KImage.veteran4(),
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      KImage.veteran5(),
    ];
