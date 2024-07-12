import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class DonatesCardsWidget extends StatefulWidget {
  const DonatesCardsWidget({
    required this.fundItems,
    required this.isLoading,
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
    hasSubtitles = List.generate(KDimensions.donateCardsLine, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        KDimensions.donateCardsLine,
        (index) {
          final changeSize =
              hasSubtitles.indexOf(true) < hasSubtitles.length - 1
                  ? hasSubtitles.indexOf(true) + 1 == index
                  : hasSubtitles.indexOf(true) - 1 == index;
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: widget.fundItems.length + 1 != index
                            ? KPadding.kPaddingSize24
                            : 0,
                      ),
                      child: SkeletonizerWidget(
                        isLoading: widget.isLoading,
                        child: DonateCardWidget(
                          key: KWidgetkeys.screen.investors.card,
                          fundModel: widget.fundItems.elementAt(index),
                          hasSubtitle: hasSubtitles.elementAt(index),
                          titleStyle: hasSubtitles.contains(true) && changeSize
                              ? AppTextStyle.text24
                              : null,
                          isDesk: true,
                          reportEvent: () =>
                              context.read<InvestorsWatcherBloc>().add(
                                    const InvestorsWatcherEvent.getReport(),
                                  ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
