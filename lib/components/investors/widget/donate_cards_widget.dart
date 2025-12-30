import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class DonatesCardsWidget extends StatefulWidget {
  const DonatesCardsWidget({
    required this.fundItems,
    this.isLoading = false,
    super.key,
  });
  final List<FundModel> fundItems;
  final bool isLoading;

  @override
  State<DonatesCardsWidget> createState() => _DonatesCardsWidgetState();
}

class _DonatesCardsWidgetState extends State<DonatesCardsWidget> {
  late List<bool> hasSubtitles;
  @override
  void initState() {
    hasSubtitles = List.filled(KDimensions.donateCardsLine, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: KPadding.kPaddingSize24,
      children: List.generate(
        KDimensions.donateCardsLine,
        (index) {
          final changeSize = hasSubtitles.fundsCardChangeSize(index);
          return Expanded(
            flex: hasSubtitles.elementAt(index)
                ? KDimensions.donateCardBigExpanded
                : hasSubtitles.contains(true) && !changeSize
                    ? KDimensions.donateCardStandartExpanded
                    : KDimensions.donateCardSmallExpanded,
            child: widget.fundItems.length > index
                ? MouseRegion(
                    onEnter: (event) => setState(() {
                      hasSubtitles[index] = true;
                    }),
                    onExit: (event) => setState(() {
                      hasSubtitles[index] = false;
                    }),
                    child: SkeletonizerWidget(
                      isLoading: widget.isLoading,
                      child: DonateCardWidget(
                        key: InvestorsKeys.card,
                        fundModel: widget.fundItems.elementAt(index),
                        hasSubtitle: hasSubtitles.elementAt(index),
                        titleStyle: hasSubtitles.contains(true) && changeSize
                            ? AppTextStyle.text24
                            : null,
                        isDesk: true,
                        // reportEvent: null,
                        // () =>
                        //     context.read<InvestorsWatcherBloc>().add(
                        //           const InvestorsWatcherEvent.getReport(),
                        //         ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
        growable: false,
      ),
    );
  }
}
